#!/bin/bash

module load bcftools
module load tabix

while IFS='' read -r VCF || [[ -n "$VCF" ]]; do
	dir=$(dirname $VCF)
	sample=$(basename $(dirname $(dirname $(dirname $dir))));
	echo $sample

	bcftools concat -a ${VCF}_2padd.snps.vcf.gz ${VCF}_2padd.indels.vcf.gz -Ov -o ${VCF}_2padd.concat.vcf 
	bgzip -c ${VCF}_2padd.concat.vcf > ${VCF}_2padd.concat.vcf.gz
	tabix -p vcf ${VCF}_2padd.concat.vcf.gz

	#rm -rf ${VCF}_2padd.concat_noAD.vcf*

	#bcftools annotate -x FORMAT/AD,FORMAT/PL ${VCF}_2padd.concat.vcf -Ov -o ${VCF}_2padd.concat_noADnoPL.vcf
	#bgzip -c ${VCF}_2padd.concat_noADnoPL.vcf > ${VCF}_2padd.concat_noADnoPL.vcf.gz
	#tabix -p vcf ${VCF}_2padd.concat_noADnoPL.vcf.gz

done < filtered_VCF_list_All_2.txt
