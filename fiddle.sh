#!/bin/bash
[ $# -eq 0 ] && set -- --help
while [ $# -gt 0 ]; do
	case "$1" in
		--setxlog2)
			sed -i -e "/parameter integer XLOG2 =/ s/[0-9]*,/$2,/" bm{sag,gas,waw,aww,ext,dep}.v
			grep -E "parameter integer XLOG2 = [0-9]*," bm{sag,gas,waw,aww,ext,dep}.v
			shift 2
			;;
		--enable-yices)
			sed -i -e "/^#smtbmc yices/ s/^#//" prove_bm{sag,gas,waw,aww,ext,dep}.sby
			grep -E "^#?smtbmc yices" prove_bm{sag,gas,waw,aww,ext,dep}.sby
			shift
			;;
		--enable-boolector)
			sed -i -e "/^#smtbmc boolector/ s/^#//" prove_bm{sag,gas,waw,aww,ext,dep}.sby
			grep -E "^#?smtbmc boolector" prove_bm{sag,gas,waw,aww,ext,dep}.sby
			shift
			;;
		--disable-yices)
			sed -i -e "/^smtbmc yices/ s/^/#/" prove_bm{sag,gas,waw,aww,ext,dep}.sby
			grep -E "^#?smtbmc yices" prove_bm{sag,gas,waw,aww,ext,dep}.sby
			shift
			;;
		--disable-boolector)
			sed -i -e "/^smtbmc boolector/ s/^/#/" prove_bm{sag,gas,waw,aww,ext,dep}.sby
			grep -E "^#?smtbmc boolector" prove_bm{sag,gas,waw,aww,ext,dep}.sby
			shift
			;;
		--reset)
			( set -x
			bash fiddle.sh --setxlog2 4
			bash fiddle.sh --enable-yices
			bash fiddle.sh --enable-boolector; )
			shift
			;;
		*)
			echo "Usage examples:" >&2
			echo "bash fiddle.sh --setxlog2 4" >&2
			echo "bash fiddle.sh --disable-yices --setxlog2 6" >&2
			echo "bash fiddle.sh --reset" >&2
			exit 1
	esac
done
