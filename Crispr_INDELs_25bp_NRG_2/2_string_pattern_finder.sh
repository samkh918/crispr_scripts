#!/bin/bash

#PBS -l walltime=10:00:00,nodes=1:ppn=1
#PBS -N samtools_mpileup
#PBS -joe .
#PBS -l vmem=20g,mem=20g

# Created by: Sam Khalouei
# Purpose: Runs the accompanying "2acs_string_pattern_finder.py" file on each sample

module load samtools
module load bcftools
module load bedtools


while IFS='' read -r VCF || [[ -n "$VCF" ]]; do
	dir=$(dirname $VCF)
	sample=$(basename $(dirname $(dirname $(dirname $dir))))
	echo $sample

	#input = ${VCF}_2padd.indels.vcf
	python 2acs_string_pattern_finder.py Indels_25bp_Ref_eitherside/${sample}_Indels_25bp_eitherSide_2padd.txt > Indels_25bp_Ref_eitherside/${sample}_Indels_25bp_eitherSide_2padd_match.txt

done < $1

