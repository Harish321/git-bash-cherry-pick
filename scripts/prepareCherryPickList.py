import sys

substrList = []
finalCommitArray = []
Fcount = 0
count = 0
substr = "<kgfs-sit>"

args = sys.argv
countFileName = args[1]
gitLogFileName = args[2]
with open(countFileName) as b:
    for line in b:
        line = line.split("\n")
        if (line[0] == "\n" or line[0] == ""):
            continue
        Fcount = line[0]


def generateCommitHash(commit):
    commit = commit.split(' ')
    finalCommitArray.append(commit[1])

def findByMsg(msg,substr):
    boolean = True
    with open(infile)as c:
        for line in c:
            if substr in line:
                 boolean = False
            elif boolean == False:
                return
        if boolean == True:
            print substr

with open(gitLogFileName) as b:
    for line in b:
        line = line.split("\n")
        if (line[0] == "\n" or line[0] == ""):
            continue
        substrList.append(line[0])

for code in substrList:
    if substr in code:
        generateCommitHash(substrList[count-3])
        # print substrList[count-2]
    count = count+1
range1 = len(finalCommitArray)-int(Fcount)
for x in range(range1,-1,-1):
    print finalCommitArray[x]