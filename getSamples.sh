#!/bin/bash


# Created by: Sam Khalouei
# Purpose: This script goes through each CRISPR project batch folder and prints the absolute path of the primary filtered VCF file to the "samples_list.txt"
#  output file

#Remove the old sample list if one exists
rm -rf /hpf/largeprojects/lauryl/results/bcbio_nextgen/control_VQSR_set/samples_list.txt
output=/hpf/largeprojects/lauryl/results/bcbio_nextgen/control_VQSR_set/samples_list.txt

cd jax1
pwd
echo "jax1---------" >> $output
for fold in */; do readlink -f $fold/final/2018-04*/applied_filters/*noRepeat_nodbsnp150.snps.vcf >> $output; done

cd ..
cd jax2
pwd
echo "jax2---------" >> $output
for fold in */; do readlink -f $fold/final/2018-05-03*/applied_filters/*noRepeat_nodbsnp150.snps.vcf >> $output; done

cd ..
cd NUT4356
pwd
echo "NUT4356-------" >> $output
for fold in */; do readlink -f $fold/final/2018-04*/applied_filters/*noRepeat_nodbsnp150.snps.vcf >> $output; done

cd ..
cd NUT5610/with_sv
pwd
echo "NUT5610-------" >> $output
for fold in */; do readlink -f $fold/final/2018-04*/applied_filters/*noRepeat_nodbsnp150.snps.vcf >> $output; done

cd ../..
cd NUT5895/with_sv
pwd
echo "NUT5895-------" >> $output
for fold in */; do readlink -f $fold/final/2018-04*/applied_filters/*noRepeat_nodbsnp150.snps.vcf >> $output; done

cd ../..
cd NUT5896
pwd
echo "NUT5896------" >> $output
for fold in */; do readlink -f $fold/final/2018-04*/applied_filters/*noRepeat_nodbsnp150.snps.vcf >> $output; done

cd ..
cd WIL5954
echo "WIL5954-----" >> $output
for fold in */; do readlink -f $fold/final/2018-04*/applied_filters/*noRepeat_nodbsnp150.snps.vcf >> $output; done

cd ..
pwd

