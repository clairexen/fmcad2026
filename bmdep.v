//  Reference implementation for the "bitmask deposit" (BMDEP) operation
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

module bmicf #(
	parameter integer XLOG2 = 4,
	parameter integer XLEN = 1 << XLOG2
) (input [XLEN-1:0] din, cin, output [XLEN-1:0] dout, cout);
	bmsf #(XLOG2, XLEN) impl (din & cout, cin, dout, cout);

`ifdef FORMAL
	integer k, cnt1, cnt0;
	always @* begin
		cnt1 = 0;
		cnt0 = 0;
		for (k = 0; k < XLEN; k = k + 1) begin
			if (cin[k] == 1'b1) begin
				assert (din[cnt1] == dout[k]);
				cnt1 = cnt1 + 1;
			end
			if (cin[XLEN-k-1] == 1'b0) begin
				assert (1'b0 == dout[XLEN-k-1]);
				cnt0 = cnt0 + 1;
			end
		end
			
	end
`endif
endmodule
