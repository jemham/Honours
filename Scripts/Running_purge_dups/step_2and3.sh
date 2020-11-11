#!/bin/bash
set -xeuo pipefail #added 20200508

#source: https://github.com/dfguan/purge_dups#step-2-purge-haplotigs-and-overlaps-with-the-following-command
#source: https://github.com/dfguan/purge_dups#step-3-get-purged-primary-and-haplotig-sequences-from-draft-assembly


pri_asm=$1
bin=$2

echo begining purge_dups
${bin}/purge_dups -2 -T cutoffs -c PB.base.cov ${pri_asm##*/}.split.self.paf.gz > dups.bed 2> purge_dups.log
echo begining get_seqs
${bin}/get_seqs dups.bed $pri_asm 

