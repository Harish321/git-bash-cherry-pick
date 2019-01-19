import sys
f=open("count.txt","r")
data = f.read()
f.close()
data = int(data)
new_data = data+4
f = open("count.txt","w")
f.write(str(new_data))
f.close()