#!/bin/bash
sed -i -e "/parameter integer XLOG2 =/ s/[0-9]*,/$1,/" bm{sag,gas,waw,aww,ext,dep}.v
grep "parameter integer XLOG2 = [0-9]*," bm{sag,gas,waw,aww,ext,dep}.v
