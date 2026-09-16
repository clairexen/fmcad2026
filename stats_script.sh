#!/usr/bin/env bash

set -euo pipefail

dump_rtlil=false

xlens=(8 16 32 64)
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
	declare -A stats
	while read -r design xlen target metric value extra; do
		if [ -z "${design:-}" ] || [ -n "${extra:-}" ]; then
			echo "malformed row in stats_cached.dat" >&2; exit 1
		fi
		key="${design}_${xlen}_${target}_${metric}"
		if [ -n "${stats[$key]+set}" ]; then
			echo "duplicate statistic in stats_cached.dat: $key" >&2; exit 1
		fi
		stats[$key]=$value
	done < stats_cached.dat
	{
		print_stats() {
			echo "# $1 synthesis statistics"; echo
			echo "## $1 synthesis statistics by design and XLEN"; echo
			for design in $2; do
				echo "### \`$design\`"; echo
				echo '| XLEN | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |'
				echo '| ---: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |'
				for xlen in "${xlens[@]}"; do
					keys=("${design}_${xlen}_cmos_transistors" "${design}_${xlen}_cmos_ltp"
						"${design}_${xlen}_lut4_lut4" "${design}_${xlen}_lut4_ltp"
						"${design}_${xlen}_lut6_lut6" "${design}_${xlen}_lut6_ltp")
					for key in "${keys[@]}"; do
						if [ -z "${stats[$key]+set}" ]; then
							echo "missing statistic in stats_cached.dat: $key" >&2; exit 1
						fi
					done
					printf '| %d | %s | %s | %s | %s | %s | %s |\n' "$xlen" \
						"${stats[${keys[0]}]}" "${stats[${keys[1]}]}" \
						"${stats[${keys[2]}]}" "${stats[${keys[3]}]}" \
						"${stats[${keys[4]}]}" "${stats[${keys[5]}]}"
				done; echo
			done

			echo "## $1 synthesis statistics by XLEN and design"; echo
			for xlen in "${xlens[@]}"; do
				case "$xlen" in
					8)  xlog2=3 ;;
					16) xlog2=4 ;;
					32) xlog2=5 ;;
					64) xlog2=6 ;;
					*) echo error >&2; exit 1
				esac
				echo "## \`XLEN=$xlen\` (\`XLOG2=$xlog2\`)"; echo
				echo '| Design | CMOS transistors | CMOS LTP | LUT4 count | LUT4 LTP | LUT6 count | LUT6 LTP |'
				echo '| -----: | ---------------: | -------: | ---------: | -------: | ---------: | -------: |'
				for design in "${designs[@]}"; do
					keys=("${design}_${xlen}_cmos_transistors" "${design}_${xlen}_cmos_ltp"
						"${design}_${xlen}_lut4_lut4" "${design}_${xlen}_lut4_ltp"
						"${design}_${xlen}_lut6_lut6" "${design}_${xlen}_lut6_ltp")
					for key in "${keys[@]}"; do
						if [ -z "${stats[$key]+set}" ]; then
							echo "missing statistic in stats_cached.dat: $key" >&2; exit 1
						fi
					done
					printf '| %s | %s | %s | %s | %s | %s | %s |\n' "$design" \
						"${stats[${keys[0]}]}" "${stats[${keys[1]}]}" \
						"${stats[${keys[2]}]}" "${stats[${keys[3]}]}" \
						"${stats[${keys[4]}]}" "${stats[${keys[5]}]}"
				done; echo
			done
		}
		echo "Cell counts and longest topological paths after mapping with Yosys."; echo
		print_stats "Decoder" hilewitz_decoder clairexen_{bmgf,bmext}_decoder
	} > stats_cached.md
	exit 0
fi

if [ "$1" = "collect" ]; then
	: > stats_cached.dat
	for xlen in "${xlens[@]}"; do
	for target in "${targets[@]}"; do
	for design in "${designs[@]}"; do
		datfile="stats_cached/${design}_${xlen}_${target}.dat"
		while read -r metric value extra; do
			if [ -z "${metric:-}" ] || [ -z "${value:-}" ] || [ -n "${extra:-}" ]; then
				echo "malformed statistic in $datfile" >&2; exit 1
			fi
			printf '%s %s %s %s %s\n' "$design" "$xlen" "$target" "$metric" "$value"
		done < "$datfile"
	done; done; done > stats_cached.dat
	exit 0
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
