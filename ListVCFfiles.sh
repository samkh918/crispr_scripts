#!/bin/bash

#for fold in */; do echo $fold; ll ${fold}final/*/*cnvkit.vcf; ll ${fold}final/*/*manta.vcf.gz; ll ${fold}final/*/*delly.vcf.gz; ll ${fold}final/*/*lumpy.vcf.gz; done

for fold in {NUT4356,NUT5610,NUT5895,NUT5896,jax1,jax2,WIL5954}; do \
	echo $fold; \
	if [[ $fold = "NUT5610" ]] || [[ $fold = "NUT5895" ]]; then extra="/with_sv"; else extra=""; fi; \
	#echo $extra;
	for sample in $(ls -d ${fold}${extra}/*/); do \
		if [[ $sample = *"Hom"* ]] || [[ $sample = *"Het"* ]] || [[ $sample = *"old_output"* ]]; then continue; fi; \
		#echo "sample: "$sample
		ls -l ${sample}final/*/*metasv.vcf.gz; \
		ls -l ${sample}final/*/*cnvkit.vcf; \
		ls -l ${sample}final/*/*delly.vcf.gz; \
		ls -l ${sample}final/*/*lumpy.vcf.gz; \
		ls -l ${sample}final/*/*manta.vcf.gz; \
		echo "--------------------------------"
	done
	echo
done


