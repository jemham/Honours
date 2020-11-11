#!/bin/bash
set -xeuo pipefail #added 20200508

#source: https://github.com/dfguan/purge_dups#step-1-run-minimap2-to-align-pacbio-data-and-generate-paf-files-then-calculate-read-depth-histogram-and-base-level-read-depth-commands-are-as-follows

#unedited origional
#for i in $pb_list
#do
#	minimap2 -xmap-pb $pri_asm $i | gzip -c - > $i.paf.gz
#done
#bin/pbcstat *.paf.gz (produces PB.base.cov and PB.stat files)
#bin/calcuts PB.stat > cutoffs 2>calcults.log

#origional assumes a list of pacbio files (fastq/fast), hance $pb_list. we only have one

#update 20200508 - changing the filepath of outputs with ##*/

pri_asm=$1
i=$2
bin=$3 #have to direct to bin too

echo begining minimap
minimap2 -xmap-pb $pri_asm $i | gzip -c - > ${i##*/}.paf.gz
echo begining pbcstat
${bin}/pbcstat *.paf.gz #(produces PB.base.cov and PB.stat files)
echo begining calcuts
${bin}/calcuts PB.stat > cutoffs 2>calcults.log

