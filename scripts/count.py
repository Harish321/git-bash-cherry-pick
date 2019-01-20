import sys

data = sys.argv

f=open(data[2],"r")
fileContent= int(f.read())
new_data = fileContent+int(data[1])
f = open(data[2],"w")
f.write(str(new_data))
f.close()