import sys

data = sys.argv
f=open(data[1],"r")
fileContent= int(f.read())
new_data = fileContent+int(data[2])
f = open(data[1],"w")
f.write(str(new_data))
f.close()