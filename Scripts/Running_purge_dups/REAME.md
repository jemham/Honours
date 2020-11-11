purge_dups was run using the following scripts, pulled together from the Manual Pipeline displayed here: https://github.com/dfguan/purge_dups/blob/master/README.md#--pipeline-guide
purge_dups and dependecies were installed as suggested on the above github page, and these scripts provide no new content, the afformetioned process

Step 1a:
Main output: cutoffs to be used in purging
Steps: aligns the reads back to the assembly and looks at coverage
Inputs: assembly, reads & bin path

Step 1b:
Main output: assembly self alignment
Steps: splits assembly at any N, then self aligns
Inputs: assembly & bin path

Step2:
Main output: dups.bed file
Steps: takes the cutoffs and self-alignment
Inputs: assembly & bin path

Step 3:
Main output: hap.fa and pri.fa <- the two assemblies
Steps: uses the dups.bed file to sort contigs in the input assembly
Inputs: assembly & bin path


Steps 1a & 1b can be run concurrently (good idea because minimap2 can be slow), 
but must both be completed before step 2

Steps 2 & 3 must be run consecutively, so have been combined into one script.


purge_dups is described in:
Guan, D., McCarthy, S.A., Wood, J., Howe, K., Wang, Y. & Durbin, R. 2020. Identifying and removing haplotypic duplication in primary genome assemblies. Bioinformatics (Oxford, England), 36: 2896-2898.
