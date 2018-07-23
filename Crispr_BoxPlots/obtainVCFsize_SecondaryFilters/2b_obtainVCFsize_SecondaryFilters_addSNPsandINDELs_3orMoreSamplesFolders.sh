#!/bin/bash

output_dir=/hpf/largeprojects/lauryl/results/bcbio_nextgen/control_VQSR_set/Crispr_BoxPlots/
#echo "Sample,NumVariants,Batch,Filt" > $output_dir/boxplot_numvar_input_excludeVarsIn3orMoreSamples.txt

while IFS='' read -r VCF || [[ -n "$VCF" ]]; do
	dir=$(dirname $VCF)
	#echo $dir
	sample=$(basename $(dirname $(dirname $(dirname $dir))));
	#echo sample: $sample

	if [[ $dir = *"NUT5610"* ]] || [[ $dir = *"NUT5895"* ]]; then 
		batch=$(basename $(dirname $(dirname $(dirname $(dirname $(dirname $dir))))))
	else
                batch=$(basename $(dirname $(dirname $(dirname $(dirname $dir)))))
	fi;

	echo -n $sample"," >> $output_dir/boxplot_numvar_input_excludeVarsIn3orMoreSamples.txt
	echo $sample

	#snp_num=$(zcat ${VCF}snps.vcf.gz | grep -v "^#" | wc -l)
	snp_num=$(grep -v "^#" $dir/*53ensemble_3orMore_bcftools_isec_snps/0000.vcf | wc -l)
	echo $snp_num

	indel_num=$(grep -v "^#" $dir/*53ensemble_3orMore_bcftools_isec_indels/0000.vcf | wc -l)
	echo $indel_num

	sum=$((snp_num + indel_num))
	echo $sum

	echo -n $sum","  >> $output_dir/boxplot_numvar_input_excludeVarsIn3orMoreSamples.txt
	echo -n $batch"," >> $output_dir/boxplot_numvar_input_excludeVarsIn3orMoreSamples.txt
	echo "ExcludeVars_in_3orMore_samples" >> $output_dir/boxplot_numvar_input_excludeVarsIn3orMoreSamples.txt

done < filtered_VCF_list.txt
