#!/bin/bash

# Created by: Sam Khalouei
# Purpose: Run the snpEff eff program on the input VCF files to create different statistics including number of Downstream, Exonic, Upstream, etc. variants

while IFS='' read -r VCF || [[ -n "$VCF" ]]; do
	dir=$(dirname $VCF)
	sample=$(basename $(dirname $(dirname $(dirname $dir))));
	echo $sample

	/hpf/largeprojects/ccmbio/naumenko/tools/bcbio/anaconda/bin/snpEff -Xms750m -Xmx16g eff \
	-dataDir /hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Mmusculus/mm10/snpeff \
	-hgvs -noLog -i vcf -o vcf \
	-csvStats ${VCF}.Exclude3orMoreOf19Controls.0000.concat.effects-stats.csv \
	-s ${VCF}.Exclude3orMoreOf19Controls.0000.concat.effects-stats.html GRCm38.86 \
	${VCF}.Exclude3orMoreOf19Controls.0000.concat.vcf.gz | \
	/hpf/largeprojects/ccmbio/naumenko/tools/bcbio/anaconda/bin/bgzip --threads 7 -c > ${VCF}.Exclude3orMoreOf19Controls.0000.concat-effects.vcf.gz

done < filtered_VCF_list_All.txt
