#!/usr/bin/env bash

set -euo pipefail

output=${1:-decoder_stats.md}
source_file=${SOURCE_FILE:-hilewitz.v}
widths=(8 16 32 64)
tops=(hilewitz_decoder clairexen_decoder)

if ! command -v yosys >/dev/null 2>&1; then
	echo "error: yosys was not found in PATH" >&2
	exit 1
fi

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

run_yosys() {
	local top=$1
	local xlog2=$2
	local mapping=$3
	local logfile=$4
	local abc_args stat_args

	case $mapping in
		cmos)
			abc_args="-g cmos"
			stat_args="-tech cmos"
			;;
		lut4)
			abc_args="-lut 4"
			stat_args=""
			;;
		lut6)
			abc_args="-lut 6"
			stat_args=""
			;;
		*)
			echo "error: unknown mapping '$mapping'" >&2
			exit 1
			;;
	esac

	yosys -Q -p "read_verilog $source_file; chparam -set XLOG2 $xlog2 $top; synth -top $top; abc $abc_args; stat $stat_args" >"$logfile" 2>&1
}

extract_count() {
	local mapping=$1
	local logfile=$2

	case $mapping in
		cmos)
			awk '/Estimated number of transistors:/ { value=$NF } END { if (value == "") exit 1; print value }' "$logfile"
			;;
		lut4|lut6)
			awk '$1 == "$lut" { value=$2 } END { if (value == "") exit 1; print value }' "$logfile"
			;;
	esac
}

declare -A counts

for width in "${widths[@]}"; do
	case $width in
		8)  xlog2=3 ;;
		16) xlog2=4 ;;
		32) xlog2=5 ;;
		64) xlog2=6 ;;
	esac

	for top in "${tops[@]}"; do
		for mapping in cmos lut4 lut6; do
			logfile="$tmpdir/${top}-${width}-${mapping}.log"
			echo "Synthesizing $top at XLEN=$width for $mapping..." >&2
			run_yosys "$top" "$xlog2" "$mapping" "$logfile"
			counts["$top,$width,$mapping"]=$(extract_count "$mapping" "$logfile")
		done
	done
done

{
	echo "# Decoder synthesis statistics"
	echo
	echo "Generated with Yosys $(yosys -V | sed 's/^Yosys //'). CMOS entries are Yosys's estimated total transistor counts; LUT entries are mapped LUT counts."
	echo
	echo '| XLEN | Hilewitz CMOS | Clairexen CMOS | Hilewitz LUT4 | Clairexen LUT4 | Hilewitz LUT6 | Clairexen LUT6 |'
	echo '| ---: | ------------: | -------------: | -------------: | --------------: | -------------: | --------------: |'
	for width in "${widths[@]}"; do
		printf '| %d | %d | %d | %d | %d | %d | %d |\n' \
			"$width" \
			"${counts[hilewitz_decoder,$width,cmos]}" \
			"${counts[clairexen_decoder,$width,cmos]}" \
			"${counts[hilewitz_decoder,$width,lut4]}" \
			"${counts[clairexen_decoder,$width,lut4]}" \
			"${counts[hilewitz_decoder,$width,lut6]}" \
			"${counts[clairexen_decoder,$width,lut6]}"
	done
} >"$output"

echo "Wrote $output" >&2
