#!/bin/bash

#PBS -l walltime=10:00:00,nodes=1:ppn=1
#PBS -N samtools_mpileup
#PBS -joe .
#PBS -l vmem=20g,mem=20g

# Created by: Sam Khalouei

# Purpose: Given an input treated sample VCF file, this script first finds variants in this VCF file not observed in the control VCF file: 
#  stored in $dir/temp_${sample}/0000.vcf. It will reformat these variants into another file (sample_mutationsSties2.txt) in the following
# format, with the ALT allele shown at the end: 
#	chr1:3322965-3322965#G
#	chr1:3413021-3413021#C
#	chr1:3950778-3950778#T
#  Then for each of these variants, It will check the control sample BAM file to see if there is any evidence (i.e. reads) of the ALT allele 
#  The results are written to the "${sample}_samtools_mpileup_out.txt" file


module load samtools
module load bcftools

input=/hpf/largeprojects/lauryl/results/bcbio_nextgen/WIL5954/MBP10172_8/final/2018-04-25_MBP10172_8/applied_filters/MBP10172_8-gatk-haplotype-annotated-decomposed_filt_noRepeat_nodbsnp150.snps.vcf

controlBam=/hpf/largeprojects/lauryl/results/bcbio_nextgen/WIL5954/MBP60/work/align/MBP60_S3_L003/MBP60_S3_L003-sort-dedup.bam
controlVCF=/hpf/largeprojects/lauryl/results/bcbio_nextgen/WIL5954/MBP60/final/2018-04-25_MBP60/MBP60_S3_L003-gatk-haplotype-annotated-decomposed.vcf.gz


dir=$(dirname $input)
sample=$(basename $(dirname $(dirname $(dirname $dir))))
samtoolsoutput=$dir/${sample}_samtools_mpileup_out.txt
echo $sample


bcftools isec $input.gz $controlVCF -p $dir/temp_${sample}


#grep -v "^#" $input | awk '{print $1":" $2 "-" $2 "_" $5}' > $dir/${sample}_mutationsSites.txt
grep -v "^#" $dir/temp_${sample}/0000.vcf | awk '{print $1":" $2 "-" $2 "_" $5}' > $dir/${sample}_mutationsSites2.txt


rm $samtoolsoutput # remove old output files

while IFS='' read -r mutSiteEntry || [[ -n "mutSiteEntry" ]]; do

	IFS="_" read -a entry <<< "$mutSiteEntry"
	mutSite=${entry[0]}
	AltAllele=${entry[1]}
	echo mutSite:${mutSite}
	echo AltAllele:${AltAllele}

	if samtools mpileup -Q 0 -f /hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Mmusculus/mm10/seq/mm10.fa  -r $mutSite $controlBam | cut -f 5 | tr '[a-z]' '[A-Z]' | fold -w 1 | sort | uniq -c | grep -v "," | grep -v "\." | grep -v "\]" | grep -v "\^" | grep -v "\\$" | grep -v "\\*" | grep -v "<" | grep -v "!" | grep $AltAllele ; then echo "*********** not called but found in control BAM ************"; echo $mutSite >> $samtoolsoutput; else echo "---------------not found----------------"; fi \

done < $dir/${sample}_mutationsSites2.txt
