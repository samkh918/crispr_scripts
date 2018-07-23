#!/bin/bash
module load bcftools

# Created by: Sam Khalouei

# Run this script from the WIL5945 folder
# Purpose: It will go through the directories and goes into the final/2018.../applied_filters folder and applies a "bcftools filter -i" for the genotype of interest
#  to both the SNPs and INDELs VCF file

for file in $(ls -d */); do \
	echo $file; \
	bcftools filter -i "GT='0/1'" ${file}final/2*/applied_filters/*noRepeat_nodbsnp150.indels.vcf.gz > HetAlt/${file%/}_indels_HetAlt.vcf; \
	bcftools filter -i "GT='0/1'" ${file}final/2*/applied_filters/*noRepeat_nodbsnp150.snps.vcf.gz > HetAlt/${file%/}_snps_HetAlt.vcf; \
done
