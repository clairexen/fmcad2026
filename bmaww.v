//  Reference implementation for the "inverse witches and wizards" (BMAWW) operation
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

module bmaww #(
	parameter integer XLOG2 = 4,
	parameter integer XLEN = 1 << XLOG2
) (input [XLEN-1:0] din, cin, output [XLEN-1:0] dout, cout);
	genvar n, i;

	generate
		for (n = 0; n < XLOG2; n = n+1) begin:fwd_stage
			wire [XLEN-1:0] st_ci, st_msk, st_xor, st_ct, st_co;
			assign st_xor[0] = !st_ci[0];
			for (i = 1; i < XLEN; i = i+1) begin:control
				assign st_xor[i] = !st_ci[i] ^ (st_xor[i-1] & st_msk[i-1]);
			end
			for (i = 0; i < (XLEN >> 1); i = i+1) begin:route
				assign st_ct[2*i  ] = st_xor[2*i] ? st_ci[2*i+1] : st_ci[2*i  ];
				assign st_ct[2*i+1] = st_xor[2*i] ? st_ci[2*i  ] : st_ci[2*i+1];
				assign st_co[(XLEN >> 1) + i] = st_ct[2*i+1], st_co[i] = st_ct[2*i];
			end
		end
		for (n = 1; n < XLOG2; n = n+1) begin:interconn
			assign fwd_stage[n].st_msk = fwd_stage[n-1].st_msk &
					({fwd_stage[n-1].st_msk, fwd_stage[n-1].st_msk} >> (XLEN >> n));
			assign fwd_stage[n].st_ci = fwd_stage[n-1].st_co;
		end
	endgenerate

	assign fwd_stage[0].st_ci = cin;
	assign fwd_stage[0].st_msk = (1 << (XLEN-1)) - 1;
	assign cout = fwd_stage[XLOG2-1].st_co;

	generate
		for (n = 0; n < XLOG2; n = n+1) begin:rev_stage
			wire [XLEN-1:0] st_di, st_xor, st_dt, st_do;
			assign st_xor = fwd_stage[XLOG2-n-1].st_xor;
			for (i = 0; i < (XLEN >> 1); i = i+1) begin:route
				assign st_dt[2*i+1] = st_di[(XLEN >> 1) + i], st_dt[2*i] = st_di[i];
				assign st_do[2*i  ] = st_xor[2*i] ? st_dt[2*i+1] : st_dt[2*i  ];
				assign st_do[2*i+1] = st_xor[2*i] ? st_dt[2*i  ] : st_dt[2*i+1];
			end
		end
		for (n = 1; n < XLOG2; n = n+1) begin:interconn
			assign rev_stage[n].st_di = rev_stage[n-1].st_do;
		end
	endgenerate

	assign rev_stage[0].st_di = din;
	assign dout = rev_stage[XLOG2-1].st_do;
`ifdef FORMAL
	integer k, cnt1, cnt0;
	always @* begin
		cnt1 = 0;
		cnt0 = 0;
		for (k = 0; k < XLEN; k = k + 1) begin
			if (cin[k]) begin
				assert (din[cnt1] == dout[k]);
				cnt1 = cnt1 + 1;
			end else begin
				assert (din[XLEN-cnt0-1] == dout[k]);
				cnt0 = cnt0 + 1;
			end
		end
	end
`endif
endmodule
