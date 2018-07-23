#!/bin/bash

# Created by: Sam Khalouei

# The goal of this script is to obtain the BAM file that was used by the gatk haplotypeCaller, it's done by the following method:
# This script first detects the folders in the current directory that start with "MBP1..", it will then go into the work/log folder of that folder and 
# uses the first line that has a "Caller" phrase in it (which corresponds to the gatk_haplotypeCaller line). It then breaks the line at the "-I" 
# position (note that awk had to be used since "cut -f -d" only accepts single character as delimeter) and subsequently breaks the line by "-L" and 
# prints the first element. This leaves only the BAM file as output

for fold in $(ls -d */); do 
	if [[ $fold == MBP1* ]]; then 
		echo ${fold%/}; 
		cat ${fold}work/log/bcbio-nextgen-commands.log | grep "Caller" | head -1 | awk '{split($0,a,"-I"); print a[2]}' | awk '{split($0,a,"-L"); print a[1]}' | grep --color ".bam"
	fi; 
done
