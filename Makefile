#  Copyright (C) 2026  Claire Xenia Wolf <claire@clairexen.net>
#
#  Permission to use, copy, modify, and/or distribute this software for any
#  purpose with or without fee is hereby granted, provided that the above
#  copyright notice and this permission notice appear in all copies.
#
#  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
#  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
#  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


######################################
# Formal Proofs with SymbiYosys

formal: prove_bmcf/PASS prove_bmic/PASS prove_bmgf/PASS prove_bmsf/PASS prove_bmext/PASS prove_bmdep/PASS prove_hilewitz/PASS

prove_bmcf/PASS: bmcf.v bmgf.v
	sby -f prove_bmcf.sby

prove_bmic/PASS: bmic.v bmsf.v
	sby -f prove_bmic.sby

prove_bmgf/PASS: bmgf.v
	sby -f prove_bmgf.sby

prove_bmsf/PASS: bmsf.v
	sby -f prove_bmsf.sby

prove_bmext/PASS: bmext.v bmgf.v
	sby -f prove_bmext.sby

prove_bmdep/PASS: bmdep.v bmsf.v
	sby -f prove_bmdep.sby

prove_hilewitz/PASS: hilewitz.v
	sby -f prove_hilewitz.sby

.PHONY: formal


######################################
# Rebuilding checked-in files

rebuild:: purge
rebuild:: decoder-stats rebuild-all-sag-types-pngs

rebuild-decoder-stats:
	bash decoder_stats.sh decoder_stats.md

rebuild-all-sag-types-pngs:
	bash illustrations/All-SAG-Types.sh

.PHONY: rebuild rebuild-decoder-stats rebuild-all-sag-types-pngs


######################################
# Housekeeping

clean:
	rm -rf prove_bmcf/
	rm -rf prove_bmic/
	rm -rf prove_bmgf/
	rm -rf prove_bmsf/
	rm -rf prove_bmext/
	rm -rf prove_bmdep/
	rm -rf prove_hilewitz/

purge: clean
	rm -f decoder_stats.md
	rm -f illustrations/All-SAG-Types-Landscape.png
	rm -f illustrations/All-SAG-Types-Portrait.png

.PHONY: clean purge
