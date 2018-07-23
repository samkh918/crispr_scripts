#!/bin/bash

module load bcftools
module load tabix

# Created by: Sam Khalouei
# Purpose: To break each sample's concatenated VCF file into "concat_Het.vcf" and "concat_HomAlt.vcf"

while IFS='' read -r VCF || [[ -n "$VCF" ]]; do
	dir=$(dirname $VCF)
	sample=$(basename $(dirname $(dirname $(dirname $dir))));
	echo $sample

	bcftools filter -i "GT='0/1'" ${VCF}_2padd.concat.vcf.gz -Ov -o ${VCF}_2padd.concat_Het.vcf 
	bgzip -c ${VCF}_2padd.concat_Het.vcf > ${VCF}_2padd.concat_Het.vcf.gz
	tabix -p vcf ${VCF}_2padd.concat_Het.vcf.gz
	
        bcftools filter -i "GT='1/1'" ${VCF}_2padd.concat.vcf.gz -Ov -o ${VCF}_2padd.concat_HomAlt.vcf
        bgzip -c ${VCF}_2padd.concat_HomAlt.vcf > ${VCF}_2padd.concat_HomAlt.vcf.gz
        tabix -p vcf ${VCF}_2padd.concat_HomAlt.vcf.gz

done < filtered_VCF_list_All_2.txt
