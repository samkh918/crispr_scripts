#!/bin/bash

module load bcftools
module load tabix

# Purpose: to create a merged VCF file from a list of 53 input VCF files

bcftools merge \
--file-list 2b_Merge_Concatenated_PrimaryFilteredVCF_53samples_2padd_FileList.txt \
-Ov -o All53samples-gatk-haplotype-annotated-decomposed_filt_noRepeat_nodbsnp150_2padd.concat.vcf && \
bgzip -c All53samples-gatk-haplotype-annotated-decomposed_filt_noRepeat_nodbsnp150_2padd.concat.vcf > All53samples-gatk-haplotype-annotated-decomposed_filt_noRepeat_nodbsnp150_2padd.concat.vcf.gz && \
tabix -p vcf All53samples-gatk-haplotype-annotated-decomposed_filt_noRepeat_nodbsnp150_2padd.concat.vcf.gz

