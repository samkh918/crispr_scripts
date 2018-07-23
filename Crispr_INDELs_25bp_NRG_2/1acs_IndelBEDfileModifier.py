import os, sys, re, string
import datetime, subprocess

# Created by: Sam Khalouei
# Purpose: Creates a BED file from the input VCF file variants list. Adjusts for the length of the INDELs in the BED file

inputFile = sys.argv [ 1 ]

myInput = open(inputFile,'r')

myList = myInput.readlines()

for myLine in myList:
        if '#' in myLine:
                continue
        else:
		spline=myLine.split()
		if len(spline[3]) > len(spline[4]): ## it's a deletion, we want to add the length of the INDEL to the interval, so that the added 25bp is starting from the end of the INDEL
			print spline[0]+"\t"+spline[1]+"\t"+str(int(spline[1])+len(spline[3])-1)+"\t"+spline[3]+"\t"+spline[4]
		else: ## it's an insertion
			print spline[0]+"\t"+spline[1]+"\t"+spline[1]+"\t"+spline[3]+"\t"+spline[4]
