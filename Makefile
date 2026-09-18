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

formal: prove_bmcf/PASS prove_bmic/PASS prove_bmgf/PASS prove_bmsf/PASS \
	prove_bmext/PASS prove_bmdep/PASS prove_hilewitz_omega/PASS prove_hilewitz_shift/PASS

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

prove_hilewitz_omega/PASS: hilewitz.v
	sby -f prove_hilewitz.sby omega

prove_hilewitz_shift/PASS: hilewitz.v
	sby -f prove_hilewitz.sby shift

.PHONY: formal


######################################
# Rebuilding checked-in files

rebuild:: purge
rebuild:: rebuild-all-sag-types-pngs rebuild-stats

rebuild-all-sag-types-pngs:
	bash illustrations/All-SAG-Types.sh

rebuild-stats:
	bash stats_script.sh mkrules
	$(MAKE) -f stats_script.mk

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
	rm -rf prove_hilewitz_omega/
	rm -rf prove_hilewitz_shift/
	rm -rf stats_cached/
	rm -rf stats_script.mk

purge: clean
	rm -rf stats_cached.md
	rm -rf stats_cached.dat
	rm -rf decoder_stats.md
	rm -rf illustrations/All-SAG-Types-Landscape.png
	rm -rf illustrations/All-SAG-Types-Portrait.png

.PHONY: clean purge
