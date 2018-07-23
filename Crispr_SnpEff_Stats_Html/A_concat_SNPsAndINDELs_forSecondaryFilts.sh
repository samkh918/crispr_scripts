#!/bin/bash

# Created by: Sam Khalouei
# Purpose: Using "bcftools concat" concatenates the "bcftools isec" 0000.vcf file of SNPs and INDELs


module load bcftools
module load tabix

while IFS='' read -r VCF || [[ -n "$VCF" ]]; do
	dir=$(dirname $VCF)
	sample=$(basename $(dirname $(dirname $(dirname $dir))));
	echo sample: $sample; 
	#mkdir -p $dir/concat_3orMoreOf19controls_SnpsIndels0000vcf

	rm -f $dir/${sample}_Exclude3orMoreOf19Controls.0000.concat.vcf*

	## compress the SNPs and INDELS VCF files before they can be concatenated
	bgzip -c $dir/${sample}_19ControlsEnsemble_3orMore_bcftools_isec_snps/0000.vcf > $dir/${sample}_19ControlsEnsemble_3orMore_bcftools_isec_snps/0000.vcf.gz &&
	tabix -p vcf $dir/${sample}_19ControlsEnsemble_3orMore_bcftools_isec_snps/0000.vcf.gz &&

	bgzip -c $dir/${sample}_19ControlsEnsemble_3orMore_bcftools_isec_indels/0000.vcf > $dir/${sample}_19ControlsEnsemble_3orMore_bcftools_isec_indels/0000.vcf.gz &&
	tabix -p vcf $dir/${sample}_19ControlsEnsemble_3orMore_bcftools_isec_indels/0000.vcf.gz &&
	
	## Run bcftools concat to concatenate the snps and indels
        bcftools concat -a $dir/${sample}_19ControlsEnsemble_3orMore_bcftools_isec_snps/0000.vcf.gz $dir/${sample}_19ControlsEnsemble_3orMore_bcftools_isec_indels/0000.vcf.gz -Ov -o ${VCF}.Exclude3orMoreOf19Controls.0000.concat.vcf &&
        bgzip -c ${VCF}.Exclude3orMoreOf19Controls.0000.concat.vcf > ${VCF}.Exclude3orMoreOf19Controls.0000.concat.vcf.gz &&
        tabix -p vcf ${VCF}.Exclude3orMoreOf19Controls.0000.concat.vcf.gz

done < filtered_VCF_list_All.txt
