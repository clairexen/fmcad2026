#!/usr/bin/env bash

set -euo pipefail

dump_rtlil=false

xlens=(8)
# xlens=(8 16 32 64)
targets=(cmos lut4 lut6)
designs=(hilewitz_decoder clairexen_{bmgf,bmext}_decoder)

getdeps() {
	case "$1" in
		hilewitz_decoder|clairexen_*_decoder)
			echo "hilewitz.v"
			;;
		*)
			echo "unknown design: $1"
			exit 1
	esac
}

if [ "$1" = "mkrules" ]; then
	{
		echo "stats_cached.md: stats_cached.dat"
		echo "	bash stats_script.sh render"; echo
		echo -n "stats_cached.dat:"
		for w in "${xlens[@]}"; do
		for t in "${targets[@]}"; do
		for d in "${designs[@]}"; do
			echo -n " stats_cached/${d}_${w}_${t}.dat"
		done; done; done; echo; echo
		echo "	bash stats_script.sh collect"; echo
		for w in "${xlens[@]}"; do
		for t in "${targets[@]}"; do
		for d in "${designs[@]}"; do
			echo "stats_cached/${d}_${w}_${t}.dat: stats_cached/${d}_${w}_${t}.log"
			echo "	bash stats_script.sh extract ${d} ${w} ${t}"; echo
			echo "stats_cached/${d}_${w}_${t}.log:" $(getdeps $d $w $t)
			echo "	bash stats_script.sh run ${d} ${w} ${t}"; echo
		done; done; done
	} > stats_script.mk
	exit 0
fi

if [ "$1" = "render" ]; then
	rm -f stats_cached.md
	echo FIXME
	exit 1
fi

if [ "$1" = "collect" ]; then
	rm -f stats_cached.dat
	echo FIXME
	exit 1
fi

if [ "$1" != "extract" -a "$1" != "run" ]; then
	echo "unknown subcommand: $1"
	exit 1
fi

design="$2"
xlen="$3"
target="$4"

case "$xlen" in
	8)  xlog2=3 ;;
	16) xlog2=4 ;;
	32) xlog2=5 ;;
	64) xlog2=6 ;;
	*) echo error >&2; exit 1
esac

mkdir -p stats_cached
logfile="stats_cached/${design}_${xlen}_${target}.log"
datfile="stats_cached/${design}_${xlen}_${target}.dat"

if [ "$1" = "extract" ]; then
	{
		case "$target" in
			cmos)
				awk '/Estimated number of transistors:/ { value=$NF }
						END { if (value == "") exit 1; print "transistors", value }' $logfile
				;;
			lut4|lut6)
				awk '$1 == "$lut" { value=$2 }
						END { if (value == "") exit 1; print "'$target'", value }' $logfile
				;;
		esac
		awk '/Longest topological path in/ { sub(".*=", ""); sub(").*", ""); value=$0 }
				END { if (value == "") exit 1; print "ltp", value }' $logfile
	}> $datfile
	exit 0
fi

yosys_script=""
ys() { yosys_script="$yosys_script
$*"; }

case "$design" in
	hilewitz_decoder|clairexen_*_decoder)
		ys read_verilog hilewitz.v
		ys chparam -set XLOG2 $xlog2 $design
		ys synth -top $design
		;;
	*)
		echo "unknown design: $design"
		exit 1
esac

case "$target" in
	cmos)
		ys splitnets -ports
		ys abc -g cmos
		ys clean
		ys stat -tech cmos
		ys ltp
		;;
	lut4|lut6)
		ys splitnets -ports
		ys abc -lut ${target#lut}
		ys clean
		ys stat
		ys ltp
		;;
	*)
		echo "unknown target: $target"
		exit 1
esac

if $dump_rtlil; then
	ys dump -o stats_cached/${design}_${xlen}_${target}.il
fi

echo "Running yosys -ql \"$logfile\" -p \"...\""
yosys -ql "$logfile" -p "$yosys_script"
