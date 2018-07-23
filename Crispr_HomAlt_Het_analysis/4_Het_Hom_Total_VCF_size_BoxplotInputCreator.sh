#!/bin/bash

module load bcftools
module load tabix


# Created by: Sam Khalouei
# Purpose: To create the input file for the subsequent R script that will generate the Boxplot of number of 
# variants in "Total", "Het", and "HomAlt" VCF files.
#  Note: The "Total" number is the sum of "Het" and "HomAlt" number of variants

output_dir=BoxPlots_scripts_inputs_outputs

input=$1
Batch=${input#$"filtered_VCF_list_"}
Batch=${Batch%$".txt"}
echo $Batch

output_file=${Batch}_Total_Het_HomAlt_Vars_2padd.txt

echo "Sample,Num,Category" > $output_dir/$output_file


while IFS='' read -r VCF || [[ -n "$VCF" ]]; do
	dir=$(dirname $VCF)
	sample=$(basename $(dirname $(dirname $(dirname $dir))));
	echo $sample

	## Total
	echo -n $sample"," >> $output_dir/$output_file
	Total=$(grep -v "^#" ${VCF}_2padd.concat.vcf | wc -l)
	echo -n $Total"," >> $output_dir/$output_file
	echo "Total" >> $output_dir/$output_file

	## Het
	echo -n $sample"," >> $output_dir/$output_file
	Het=$(grep -v "^#" ${VCF}_2padd.concat_Het.vcf | wc -l)
	echo -n $Het"," >> $output_dir/$output_file
	echo "Het" >> $output_dir/$output_file

	## HomAlt
	echo -n $sample"," >> $output_dir/$output_file
	HomAlt=$(grep -v "^#" ${VCF}_2padd.concat_HomAlt.vcf | wc -l)
	echo -n $HomAlt"," >> $output_dir/$output_file
	echo "HomAlt" >> $output_dir/$output_file

done < $1
