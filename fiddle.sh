#!/bin/bash
while [ $# -gt 0 ]; do
	case "$1" in
		--setxlog2)
			sed -i -e "/parameter integer XLOG2 =/ s/[0-9]*,/$2,/" bm{sag,gas,waw,aww,ext,dep}.v
			grep "parameter integer XLOG2 = [0-9]*," bm{sag,gas,waw,aww,ext,dep}.v
			shift 2;;
		*)
			echo "Usage examples:" >&2
			echo "bash fiddle.sh --setxlog2 4" >&2
			exit 1
	esac
done
