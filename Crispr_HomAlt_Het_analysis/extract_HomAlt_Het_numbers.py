import os, sys, re, string
import datetime, subprocess

# Created by: Sam Khalouei
# Purpose: For each variant in the merged VCF input file, prints the number of "Het (0/1)" and "HomAlt (1/1)" genotypes

inputFile = open("All53samples-gatk-haplotype-annotated-decomposed_filt_noRepeat_nodbsnp150_2padd.concat.vcf","r")

myList = inputFile.readlines()

for myLine in myList:
	if '#' in myLine:
		continue
	else:
		spline=myLine.split()
		Het_count=0
		HomAlt_count=0
		for j in range(9,62):
			GNT=spline[j].split(":")[0]
			if GNT == "0/1": Het_count+=1
			elif GNT == "1/1": HomAlt_count+=1
	print "\t".join(spline[0:5]),"\t",Het_count,"\t",HomAlt_count

inputFile.close()
