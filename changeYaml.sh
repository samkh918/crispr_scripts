#!/bin/bash

# Created by: Sam Khalouei
# Purpose: Automating Yaml file modifications for the entire samples (e.g. changing the aligner option from "bwa" to "false")

for sample in $(ls -d */); do \
#for sample in {MBP10097_9,MBP10098_11}; do \
	echo ${sample}; \
	cp ${sample}config/${sample}.yaml ${sample}config/${sample%/}_bak_2018_0504.yaml; # first backup the file\
	sed -i 's/aligner: bwa/aligner: false/g' ${sample}config/${sample%/}.yaml; \
	sed -i 's/recalibrate: gatk/recalibrate: false/g' ${sample}config/${sample%/}.yaml; \
	sed -i 's/- seq2c/- seq2c\n    - metasv/g' ${sample}config/${sample%/}.yaml; \
	sed -i '/R1_001.fastq/d' ${sample}config/${sample%/}.yaml; # delete the line having that phrase \ 
	sed -i '/R2_001.fastq/c\    -' ${sample}config/${sample%/}.yaml; # Change the "entire" line with new phrase, here "   -" \ 
	cat ${sample}work/log/bcbio-nextgen-commands.log | grep "Caller" | head -1 | awk '{split($0,a,"-I"); print a[2]}' | awk '{split($0,a,"-L"); print a[1]}' >> ${sample}config/${sample%/}.yaml
done
