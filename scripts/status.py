import sys

status = ""
with open("status.txt") as f:
    for line in f:
    	if "commit" in line:
    		status = "False"
    		break
    	if "insertion" in line:
    		status = "True"
    		break
   	file=open("output.txt",w+")
    file.write(status)
    file.close()