//  Equivalence check for the Hilewitz parallel-extract control logic
//
//  Copyright (C) 2026  Claire Xenia Wolf <claire@clairexen.net>
//
//  Permission to use, copy, modify, and/or distribute this software for any
//  purpose with or without fee is hereby granted, provided that the above
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
//  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
//  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

// Hilewitz and Lee's decoder: a parallel-prefix population count followed by
// one LROTC (left rotate and complement on wrap) for each butterfly subnetwork.
module hilewitz_decoder #(
	parameter integer XLOG2 = 4,
	parameter integer XLEN = 1 << XLOG2
) (input [XLEN-1:0] cin, output [XLOG2*XLEN/2-1:0] ctrl);
	function [XLOG2:0] prefix_count;
		input [XLEN-1:0] value;
		input integer last;
		integer i;
		begin
			prefix_count = 0;
			for (i = 0; i < XLEN; i = i+1)
				if (i <= last)
					prefix_count = prefix_count + value[i];
		end
	endfunction

	genvar n, i;
	generate
		for (n = 0; n < XLOG2; n = n+1) begin:stage
			// pex uses the reverse of the pdep/butterfly stage order.
			localparam integer K = 1 << n;
			for (i = 0; i < (XLEN >> 1); i = i+1) begin:lrotc
				localparam integer BLOCK = i / K;
				localparam integer POS = i % K;
				localparam integer LAST = (2*BLOCK+1)*K-1;
				wire [XLOG2:0] rot;
				assign rot = prefix_count(cin, LAST);
				// LROTC(1^K, rot), with 1 meaning exchange.
				assign ctrl[n*(XLEN/2)+i] = 1'b1 ^ (((rot+K-1-POS) / K) & 1'b1);
			end
		end
	endgenerate
endmodule

// Hilewitz and Lee's bmext implementation
module bmext_hilewitz #(
	parameter integer XLOG2 = 4,
	parameter integer XLEN = 1 << XLOG2
) (input [XLEN-1:0] din, cin, output [XLEN-1:0] dout);
	wire [XLOG2*XLEN/2-1:0] ctrl;
	wire [XLEN-1:0] data [0:XLOG2];

	hilewitz_decoder #(XLOG2, XLEN) decoder (cin, ctrl);
	assign data[0] = din & cin;

	genvar n, i;
	generate
		for (n = 0; n < XLOG2; n = n+1) begin:stage
			localparam integer K = 1 << n;
			for (i = 0; i < (XLEN >> 1); i = i+1) begin:route
				localparam integer BLOCK = i / K;
				localparam integer POS = i % K;
				localparam integer LO = 2*BLOCK*K + POS;
				localparam integer HI = LO + K;
				assign data[n+1][LO] = ctrl[n*(XLEN/2)+i] ?
						data[n][HI] : data[n][LO];
				assign data[n+1][HI] = ctrl[n*(XLEN/2)+i] ?
						data[n][LO] : data[n][HI];
			end
		end
	endgenerate

	assign dout = data[XLOG2];
endmodule

// the "omega"-style control generator from bmgf.v
module clairexen_omega_decoder #(
	parameter integer XLOG2 = 4,
	parameter integer XLEN = 1 << XLOG2
) (input [XLEN-1:0] cin, output [XLOG2*XLEN/2-1:0] ctrl);
	genvar n, i;

	generate
		for (n = 0; n < XLOG2; n = n+1) begin:stage
			wire [XLEN-1:0] st_ci, st_msk, st_xor, st_ct, st_co;
			assign st_xor[0] = !st_ci[0];
			for (i = 1; i < XLEN; i = i+1) begin:control
				assign st_xor[i] = !st_ci[i] ^ (st_xor[i-1] & st_msk[i-1]);
			end
			for (i = 0; i < (XLEN >> 1); i = i+1) begin:route
				assign ctrl[n*(XLEN/2)+i] = st_xor[2*i];
				assign st_ct[2*i  ] = st_xor[2*i] ? st_ci[2*i+1] : st_ci[2*i  ];
				assign st_ct[2*i+1] = st_xor[2*i] ? st_ci[2*i  ] : st_ci[2*i+1];
				assign st_co[(XLEN >> 1) + i] = st_ct[2*i+1], st_co[i] = st_ct[2*i];
			end
		end
		for (n = 1; n < XLOG2; n = n+1) begin:interconn
			assign stage[n].st_msk = stage[n-1].st_msk &
					({stage[n-1].st_msk, stage[n-1].st_msk} >> (XLEN >> n));
			assign stage[n].st_ci = stage[n-1].st_co;
		end
	endgenerate

	assign stage[0].st_ci = cin;
	assign stage[0].st_msk = (1 << (XLEN-1)) - 1;
endmodule

module prove_bmext_bmdep_omega_encoders_equiv #(
	parameter integer XLOG2 = 4,
	parameter integer XLEN = 1 << XLOG2
) (
	input [XLEN-1:0] cin,
	output [XLOG2*XLEN/2-1:0] h_ctrl, c_ctrl, c_ctrl_reshuffled
);
	hilewitz_decoder #(XLOG2, XLEN) href (cin, h_ctrl);
	clairexen_omega_decoder #(XLOG2, XLEN) mref (cin, c_ctrl);

	// Undo the accumulated perfect unshuffles: apply zero perfect shuffles to
	// the first control word, one to the second, and so forth.
	genvar n, i;
	generate
		for (n = 0; n < XLOG2; n = n+1) begin:reshuffle_stage
			for (i = 0; i < (XLEN >> 1); i = i+1) begin:reshuffle_bit
				localparam integer DST = ((i << n) |
						(i >> (XLOG2-n-1))) & ((XLEN >> 1)-1);
				assign c_ctrl_reshuffled[n*(XLEN/2)+DST] =
					c_ctrl[n*(XLEN/2)+i];
			end
		end
	endgenerate

`ifdef FORMAL
	always @* assert (h_ctrl == c_ctrl_reshuffled);
`endif
endmodule

// -----------------------------------------------------------------------

// the "shift"-style control generator from bmext.v
module clairexen_shift_decoder #(
	parameter integer XLOG2 = 4,
	parameter integer XLEN = 1 << XLOG2
) (input [XLEN-1:0] cin, output [XLOG2*XLEN-1:0] ctrl);
	genvar n, i;

	generate
		for (n = 0; n < XLOG2; n = n+1) begin:stage
			wire [XLEN-1:0] st_ci, st_msk, st_xor, st_ct, st_co;
			assign st_xor[0] = !st_ci[0];
			for (i = 1; i < XLEN; i = i+1) begin:control
				assign st_xor[i] = !st_ci[i] ^ (st_xor[i-1] & st_msk[i-1]);
			end
			assign st_ct = (st_xor & ((st_ci >> 1) & st_msk)) | (~st_xor & st_ci);
			for (i = 0; i < (XLEN >> 1); i = i+1) begin:route
				assign st_co[(XLEN >> 1) + i] = st_ct[2*i+1], st_co[i] = st_ct[2*i];
			end
			assign ctrl[n*XLEN +: XLEN] = st_xor;
			wire [XLEN-1:0] stage_ctrl;
			assign stage_ctrl = ctrl[n*XLEN +: XLEN];
		end
		for (n = 1; n < XLOG2; n = n+1) begin:interconn
			assign stage[n].st_msk = stage[n-1].st_msk &
					({stage[n-1].st_msk, stage[n-1].st_msk} >> (XLEN >> n));
			assign stage[n].st_ci = stage[n-1].st_co;
		end
	endgenerate

	assign stage[0].st_ci = cin;
	assign stage[0].st_msk = (1 << (XLEN-1)) - 1;
endmodule

module shift_network #(
	parameter integer XLOG2 = 4,
	parameter integer XLEN = 1 << XLOG2
) (
	input [XLEN-1:0] din,
	input [XLEN*XLOG2-1:0] ctrl,
	output [XLEN-1:0] dout
);
	genvar n, i;

	generate
		for (n = 0; n < XLOG2; n = n+1) begin:stage
			wire [XLEN-1:0] st_di, st_ci, st_msk, st_xor, st_dt, st_ct, st_do, st_co;
			assign st_xor = ctrl[n*XLEN +: XLEN];
			assign st_dt = (st_xor & ((st_di >> 1) & st_msk)) | (~st_xor & st_di);
			for (i = 0; i < (XLEN >> 1); i = i+1) begin:route
				assign st_do[(XLEN >> 1) + i] = st_dt[2*i+1], st_do[i] = st_dt[2*i];
			end
		end
		for (n = 1; n < XLOG2; n = n+1) begin:interconn
			assign stage[n].st_msk = stage[n-1].st_msk &
					({stage[n-1].st_msk, stage[n-1].st_msk} >> (XLEN >> n));
			assign stage[n].st_di = stage[n-1].st_do;
		end
	endgenerate

	assign stage[0].st_di = din;
	assign stage[0].st_msk = (1 << (XLEN-1)) - 1;
	assign dout = stage[XLOG2-1].st_do;
endmodule

module prove_bmext_bmdep_shift_encoder #(
	parameter integer XLOG2 = 4,
	parameter integer XLEN = 1 << XLOG2
) (
	input [XLEN-1:0] din, cin,
	output [XLEN-1:0] dout,
	output [XLOG2*XLEN-1:0] ctrl,
);
	clairexen_shift_decoder #(XLOG2, XLEN) c_ref (cin, ctrl);
	shift_network #(XLOG2, XLEN) c_shift (din & cin, ctrl, dout);

`ifdef FORMAL
	integer k, cnt1, cnt0;
	always @* begin
		cnt1 = 0;
		cnt0 = 0;
		for (k = 0; k < XLEN; k = k + 1) begin
			if (cin[k] == 1'b1) begin
				assert (dout[cnt1] == din[k]);
				cnt1 = cnt1 + 1;
			end else begin
				assert (dout[XLEN-cnt0-1] == 1'b0);
				cnt0 = cnt0 + 1;
			end
		end
	end
`endif
endmodule
