import os, sys, re, string
import datetime, subprocess

# Created by: Sam Khalouei
# Purpose: Converts the reference sequence to upper case and then sets "match=re.finditer('AG|GG,myList[k+1].upper())" on it to obtain matches to AG and GG.
#  "match" then can be used to obtain the position of match to the output file

inputFile = sys.argv [ 1 ]

myInput = open(inputFile,'r')

myList = myInput.readlines()

k=0
for k in range(len(myList)-1):
	if (myList[k].startswith(">")):
		print (myList[k-1].strip())
		print (myList[k].strip())
		print (myList[k+1].strip())
		#re.search(r'^GG', myList[k+1])
		#match = re.finditer('AG|GG',myList[k+1].upper())
		match = re.finditer(r'(?=AG|GG)',myList[k+1].upper())
		if match:
		   for m in match:
			#print str(m.start())+"_"+str(m.group())+"\t",
			print str(m.start())+"\t",
			#print m.group(),
	   	print "\n"
	

myInput.close()
