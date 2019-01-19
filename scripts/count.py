import sys

data = sys.argv
f=open("count.txt","r")
fileContent= int(f.read())
new_data = fileContent+int(data[1])
f = open("count.txt","w")
f.write(str(new_data))
f.close()