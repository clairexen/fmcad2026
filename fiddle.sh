#!/bin/bash
[ $# -eq 0 ] && set -- --help
while [ $# -gt 0 ]; do
	case "$1" in
		--setxlog2)
			sed -i -e "/parameter integer XLOG2 =/ s/[0-9]*,/$2,/" bm{cf,ic,gf,sf,ext,dep}.v hilewitz.v
			grep -E "parameter integer XLOG2 = [0-9]*," bm{cf,ic,gf,sf,ext,dep}.v hilewitz.v
			shift 2
			;;
		--enable-yices)
			sed -i -e "/^#smtbmc yices/ s/^#//" prove_{bm{cf,ic,gf,sf,ext,dep},hilewitz}.sby
			grep -E "^#?smtbmc yices" prove_{bm{cf,ic,gf,sf,ext,dep},hilewitz}.sby
			shift
			;;
		--enable-boolector)
			sed -i -e "/^#smtbmc boolector/ s/^#//" prove_{bm{cf,ic,gf,sf,ext,dep},hilewitz}.sby
			grep -E "^#?smtbmc boolector" prove_{bm{cf,ic,gf,sf,ext,dep},hilewitz}.sby
			shift
			;;
		--disable-yices)
			sed -i -e "/^smtbmc yices/ s/^/#/" prove_{bm{cf,ic,gf,sf,ext,dep},hilewitz}.sby
			grep -E "^#?smtbmc yices" prove_{bm{cf,ic,gf,sf,ext,dep},hilewitz}.sby
			shift
			;;
		--disable-boolector)
			sed -i -e "/^smtbmc boolector/ s/^/#/" prove_{bm{cf,ic,gf,sf,ext,dep},hilewitz}.sby
			grep -E "^#?smtbmc boolector" prove_{bm{cf,ic,gf,sf,ext,dep},hilewitz}.sby
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
