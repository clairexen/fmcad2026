formal: prove_bmsag/PASS prove_bmgas/PASS prove_bmwaw/PASS prove_bmaww/PASS prove_bmext/PASS prove_bmdep/PASS

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

clean:
	rm -rf prove_bmsag/
	rm -rf prove_bmgas/
	rm -rf prove_bmwaw/
	rm -rf prove_bmaww/
	rm -rf prove_bmext/
	rm -rf prove_bmdep/

.PHONY: formal clean
