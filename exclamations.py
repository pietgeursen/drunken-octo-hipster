import sys
import re

file_to_process = sys.argv[1] #call the script with the name of the file to open.

isFromPiet = False
isFromBabs = False

count = 0

with open(file_to_process,'r') as f:
	for line in f:
		if(re.search('(From: Piet)',line)):
			isFromPiet = True
		if(re.search('(From: Babs)',line)):
			isFromBabs = True
		
		ex = re.findall('(!)', line)
		if(ex):
			count += len(ex)

print isFromBabs
print isFromPiet
print count