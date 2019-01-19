import sys

status = ""
with open(raw_input("Plese enter input file name: ")) as f:
    for line in f:
    	if "commit" in line:
    		status = "False"
    		break
    	if "insertion" in line:
    		status = "True"
    		break
   	file=open(raw_input("Please enter Output file name:"),"w+")
    file.write(status)
    file.close()