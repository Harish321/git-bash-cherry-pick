#!/bin/bash

# so read the input

while getopts f:t: option
do
case "${option}"
in
f) from=${OPTARG};;
t) to=${OPTARG};;
esac
done
echo $from
echo $to
tempCount=0
count=0
array=()
cd ..
mainPath="$(pwd)"
pathFileName="$mainPath/data/path.txt"
while IFS='' read -r line || [[ -n "$line" ]]; do
    array[$tempCount]=$line
    tempCount=$((tempCount+1))
done < "$pathFileName"

if [ $tempCount = 6 ]; then
    mainPath=${array[0]}
    scriptPath=${array[1]}
    logPath=${array[2]}
    dataPath=${array[3]}
    masterBranchPath=${array[4]}
    clientBranchPath=${array[5]}
else
    echo "All the paths are not set. Please run install.sh to set the path"
fi
fileName=$dataPath/listOfCherryPick.txt
countFileName=$dataPath/count.txt

function getlog() {
    cd $masterBranchPath
    git log > $logPath/gitLog.txt
    findNewLogs
}

function findNewLogs() {
    python $scriptPath/prepareCherryPickList.py "$dataPath/count.txt" "$logPath/gitLog.txt" "$from" > $fileName
    timeToCherryPick
}
function timeToCherryPick() {
    cd $clientBranchPath
    getBranch=$(git branch | grep \* | cut -d ' ' -f2)
    if [ $getBranch = $to ]; then
        git pull
        while IFS='' read -r line || [[ -n "$line" ]]; do
            echo $line
            applyCherryPick $line
        done < "$fileName"
        newUpdateList $count
    fi
}
function applyCherryPick() {
    cd $clientBranchPath
    git cherry-pick $1 2>&1 | tee $logPath/tempCherryPickStatus.txt
    status="$(python $scriptPath/status.py $logPath/tempCherryPickStatus.txt)"
    echo $status
    if [ $status == 'True' ]; then
        count=$((count + 1))
    else
        code .
        echo "choice (f/a)"
        read value </dev/tty
        if [ $value == 'f' ]; then
            count=$((count + 1))
        else
            git cherry-pick --abort
            msg=$count
            msg+=" Cherry Picks applied successfully"
            echo $msg
            newUpdateList $count
            exit 1
        fi
    fi
}
function newUpdateList() {
    python $scriptPath/count.py $dataPath/count.txt $1
}
function updateList() {
    while IFS='' read -r line || [[ -n "$line" ]]; do
        number=expr $line + $count + 0
        echo $number > $countFileName
    done < "$countFileName"
    exit 1
}

getlog
