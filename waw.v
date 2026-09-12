//  Reference implementation for the "Witches and Wizards" operation
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

module waw #(
	parameter integer XLOG2 = 6;
	parameter integer XLEN = 1 << XLOG2;
) (input [XLEN-1:0] di, ci, output [XLEN-1:0] do);
	genvar n, i;

	generate for (n = 0; n < XLOG2; n = n+1) begin:stage
		wire [XLEN-1] st_di, st_ci, st_xor, st_dt, st_ct, st_do, st_co;
		assign st_xor[0] = !st_ci[i];
		generate for (i = 1; i < XLEN; i = i+1) begin:control
			assign st_xor[i] = !st_ci[i] ^ st_xor[i-1];
		end
		generate for (i = 0; i < (XLEN >> 1); i = i+1) begin:route
			assign st_dt[2*i+0 :+ 2] = st_xor[2*i+1] ?
					{st_di[2*i+1], st_di[2*i+1]} : st_di[2*i+0 :+ 2];
			assign st_ct[2*i+0 :+ 2] = st_xor[2*i+1] ?
					{st_ci[2*i+1], st_ci[2*i+1]} : st_ci[2*i+0 :+ 2];
			assign {st_do[(XLEN >> 1) + i, st_do[i]} = st_dt[2*i+0 :+ 2];
			assign {st_co[(XLEN >> 1) + i, st_co[i]} = st_ct[2*i+0 :+ 2];
		end
	end

	generate for (n = 1; n < XLOG2; n = n+1) begin:interconnect
		assign stage[n].st_di = stage[n-1].st_do;
		assign stage[n].st_ci = stage[n-1].st_co;
	end

	assign stage[0].st_di = di;
	assign stage[0].st_ci = ci;
	assign do = stage[XLOG2-1].st_do;

`ifdef FORMAL
	integer k, cnt1, cnt0;
	always @* begin
		cnt1 = 0;
		cnt0 = 0;
		for (k = 0; k < XLEN; k = k + 1) begin
			if (ci[k] == 1'b1) begin
				assert (do[cnt1] == di[k]);
				cnt1 = cnt1 + 1;
			end
			if (ci[XLEN-k-1] == 1'b0) begin
				assert (do[XLEN-cnt0-1] == di[XLEN-k-1]);
				cnt0 = cnt0 + 1;
			end
		end
			
	end
`endif
endmodule

