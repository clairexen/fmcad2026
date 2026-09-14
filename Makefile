formal: prove_bmsag/PASS prove_bmgas/PASS prove_bmwaw/PASS prove_bmaww/PASS prove_bmext/PASS prove_bmdep/PASS prove_hilewitz/PASS

decoder-stats: decoder_stats.md

decoder_stats.md: decoder_stats.sh hilewitz.v
	bash decoder_stats.sh $@

prove_bmsag/PASS: bmsag.v bmwaw.v
	sby -f prove_bmsag.sby

prove_bmgas/PASS: bmgas.v bmaww.v
	sby -f prove_bmgas.sby

prove_bmwaw/PASS: bmwaw.v
	sby -f prove_bmwaw.sby

prove_bmaww/PASS: bmaww.v
	sby -f prove_bmaww.sby

prove_bmext/PASS: bmext.v bmwaw.v
	sby -f prove_bmext.sby

prove_bmdep/PASS: bmdep.v bmaww.v
	sby -f prove_bmdep.sby

prove_hilewitz/PASS: hilewitz.v
	sby -f prove_hilewitz.sby

clean:
	rm -rf prove_bmsag/
	rm -rf prove_bmgas/
	rm -rf prove_bmwaw/
	rm -rf prove_bmaww/
	rm -rf prove_bmext/
	rm -rf prove_bmdep/
	rm -rf prove_hilewitz/
	rm -f decoder_stats.md

.PHONY: formal decoder-stats clean
