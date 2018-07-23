#!/bin/bash

#PBS -l walltime=10:00:00,nodes=1:ppn=1
#PBS -N samtools_mpileup
#PBS -joe .
#PBS -l vmem=20g,mem=20g

# Created by: Sam Khalouei
# Purpose: This script works with the accompanied "1acs_IndelBEDfileModifier.py" file. It uses “bedtools slop” to add 25bp to each side
#  of the generated BED file and using “samtools faidx” obtains the reference region for each interval of this BED file

module load samtools
module load bcftools
module load bedtools


while IFS='' read -r VCF || [[ -n "$VCF" ]]; do
	input=${VCF}_2padd.indels.vcf
	dir=$(dirname $input)
	sample=$(basename $(dirname $(dirname $(dirname $dir))))
	echo $sample


	## Generate a BED file from the provided input INDELs VCF file
	python 1acs_IndelBEDfileModifier.py $input > $dir/${sample}_Indels_2padd.BED &&


	## Padd the generated BED file by 20 on either side of the Indel using "bedtools slop" and call it "_padd25.BED"
	bedtools slop -i $dir/${sample}_Indels_2padd.BED -g chrom_sizes.txt -b 25 > $dir/${sample}_Indels_2padd_padd25.BED


	mkdir -p Indels_25bp_Ref_eitherside
	rm -rf Indels_25bp_Ref_eitherside/${sample}_Indels_25bp_eitherSide_2padd.txt
	## Go through each interval of this "_padd25.BED" file  and obtain that region from the reference sequence using "samtools faidx Ref.fa ChromPosition"
	while IFS="" read -r line || [[ -n "$line" ]]; do
		echo -n $line >> Indels_25bp_Ref_eitherside/${sample}_Indels_25bp_eitherSide_2padd.txt
		IFS="	" read -a myarray <<< "$line"
		chr=${myarray[0]}
		start=${myarray[1]}
		end=${myarray[2]}
		## Note: the line commented out below was originally used but if the retrieved sequence from fasta is longer than 60 bases it would go into the
		## next line because "samtools faidx" keeps the original fasta file format. In my case this would occur in "deletion" INDELS where the lenght of 
		## the INDEL was longer than say 10bp
		## The line immediately following that uses "awk" to convert the broken line to a single line
		#samtools faidx /hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Mmusculus/mm10/seq/mm10.fa $chr:$start-$end >> Indels_25bp_Ref_eitherside/${sample}_Indels_25bp_eitherSide_2padd.txt
		samtools faidx /hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Mmusculus/mm10/seq/mm10.fa $chr:$start-$end | awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' >> Indels_25bp_Ref_eitherside/${sample}_Indels_25bp_eitherSide_2padd.txt
		echo "------------------------------------------" >> Indels_25bp_Ref_eitherside/${sample}_Indels_25bp_eitherSide_2padd.txt
	done < $dir/${sample}_Indels_2padd_padd25.BED

done < $1

