#!/bin/bash

source ~/.bashrc

#param=FS
param=SOR
#param=MQ

commFolder=/hpf/largeprojects/lauryl/results/bcbio_nextgen/new_*/*/final/2*/applied_filters2
mkdir -p $param

for file in $(ls ${commFolder}/*.Exclude2orMore76Samples.0000.concat.vcf.gz); do 
	sample=`echo $file | cut -f8 -d"/"`
	echo $sample

	getVCFfield $file $param > $param/${sample}_${param}.txt
	
	#justFile=$(basename $file)
	#bcftools filter -e "FS>${FScutoff}" $file -Oz -o secondFiltVCFfiles/${MODE}/fold1_FSfilteredVCFs/${justFile%$".vcf.gz"}.FSle${FScutoff}.vcf.gz
	#tabix -p vcf secondFiltVCFfiles/${MODE}/fold1_FSfilteredVCFs/${justFile%$".vcf.gz"}.FSle${FScutoff}.vcf.gz
done

