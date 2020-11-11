#!/bin/bash
set -xeuo pipefail #added 20200508
#source: https://github.com/dfguan/purge_dups#step-1-split-an-assembly-and-do-a-self-self-alignment-commands-are-following

#edits:
#adding the variable thing
#adding variable for bin as well

#update 20200508, add {##*/} to reove path so that new files are created in same folder as action.

pri_asm=$1
bin=$2

echo begining split_fa
${bin}/split_fa $pri_asm > ${pri_asm##*/}.split
echo begining self-self minimap
minimap2 -xasm5 -DP ${pri_asm##*/}.split ${pri_asm##*/}.split | gzip -c - > ${pri_asm##*/}.split.self.paf.gz
