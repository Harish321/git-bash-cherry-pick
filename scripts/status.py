import sys

status = ""
args = sys.argv
inputFileName = args[1]
with open(inputFileName) as f:
    for line in f:
    	if "commit" in line:
    		print "False"
    		break
    	if "insertion" in line:
    		print "True"
    		break
