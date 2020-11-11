#!/bin/bash
set -xeuo pipefail

inputpath=$1
inputfa=${inputpath##*/} 
input=${inputfa%%.fa}

pacbiopath=$2

#.bam file

#map the two read types
minimap2 -ax map-ont ${inputpath} ~/data/nanopore/all_wahlenbergia_nanopore_excluding_flowcell-4.fastq.gz > ${input}_nanopore.mapping.sam   
minimap2 -ax asm20 ${inputpath} ${pacbiopath} > ${input}_pacbio.mapping.sam  
#fixed 20200601 but the -ax was wrong for pacbio

#sort to make .bam files
samtools sort -o ${input}_nanopore.mapping.bam ${input}_nanopore.mapping.sam
samtools sort -o ${input}_pacbio.mapping.bam ${input}_pacbio.mapping.sam

#merge
samtools merge ${input}_combine.mapping.bam ${input}_pacbio.mapping.bam ${input}_nanopore.mapping.bam

#index:
samtools index ${input}_combine.mapping.bam 

#index fai
samtools faidx ${inputpath}

#.bed file

#genome file
awk -v OFS='\t' {'print $1,$2'} ${inputpath}.fai  > ${input}_genomeFile.txt 

#genome file includes all contig sizes, bed file for full contigs just adds a column which is 0 between the existing columns. is there a way to do this without makewindows?
awk 'BEGIN{FS=OFS="\t"}{$1 = $1 OFS 0}1' ${input}_genomeFile.txt > ${input}.bed


#coverage.tab file

#coverage:
samtools bedcov ${input}.bed  ${input}_combine.mapping.bam > ${input}_coverage.tab
