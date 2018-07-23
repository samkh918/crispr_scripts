#!/bin/bash

module load bcftools
module load tabix

# Created by: Sam Khalouei
# Purpose: This scripts accepts a file containing the list of VCF file prefixes for one of the CRISPR batches (i.e. Jax, UCD, or TCP) and
#   runs the "Cacs_SnpEff-csv-VarTypeNum-extractor.py" file and appends the output of each run to the "All_SnpEff-csv-varNums.txt" file

output_dir=BoxPlots_scripts_inputs_outputs
mkdir -p $output_dir

input=$1
Batch=${input#$"filtered_VCF_list_"}
Batch=${Batch%$".txt"}
echo $Batch

echo "Sample,Batch,Num,Category" > $output_dir/All_Exclude3orMoreOf19Controls.0000.concat.SnpEff-csv-varNums.txt

while IFS='' read -r VCF || [[ -n "$VCF" ]]; do
	dir=$(dirname $VCF)
	sample=$(basename $(dirname $(dirname $(dirname $dir))));
	echo $sample

	python Cacs_SnpEff-csv-VarTypeNum-extractor.py ${VCF} ${sample} TCP
	cat ${VCF}.Exclude3orMoreOf19Controls.0000.concat.effects-stats-numbers.txt >> $output_dir/All_Exclude3orMoreOf19Controls.0000.concat.SnpEff-csv-varNums.txt
done < $1
