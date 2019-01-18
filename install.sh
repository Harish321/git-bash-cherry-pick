#!/bin/bash

mainPath="$(pwd)"
scriptsPath="$mainPath/scripts"
logsPath="$mainPath/logs"
dataPath="$mainPath/data"
echo "Please give the path of the master branch folder of irf-perdix-client :"
while read path; do
    masterBranchPath=$path
    break
done < /dev/stdin
echo "Please give the path of the client branch folder of irf-perdix-client :"
while read path; do
    clientBranchPath=$path
    break
done < /dev/stdin

echo $dataPath
echo $mainPath > $dataPath/path.txt
echo $scriptsPath >> $dataPath/path.txt
echo $logsPath >> $dataPath/path.txt
echo $dataPath >> $dataPath/path.txt
echo $masterBranchPath >> $dataPath/path.txt
echo $clientBranchPath >> $dataPath/path.txt