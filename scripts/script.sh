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
tempCount=0
array=()
cd ..
mainPath="$(pwd)"
pathFileName="$mainPath/data/path.txt"
while IFS='' read -r line || [[ -n "$line" ]]; do
    array[$tempCount]=$line
    $tempCount = $tempCount+1
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
fileName = $dataPath/listOfCherryPick.txt
countFileName = $dataPath/count.txt
getlog()
# get the from env, to env

# get the log of from env
function getlog() {
    cd $masterBranchPath
    git log > $logPath/gitLog.txt
    findNewLogs()
}

function findNewLogs() {
    python $scriptPath/prepareCherryPickList.py "$dataPath/count.txt" "$logPath/gitLog.txt" > $fileName
    timeToCherryPick()
}
function timeToCherryPick() {
    cd clientBranchPath
    getBranch = $(git branch | grep \* | cut -d ' ' -f2)
    if [ $getBranch = $to ]; then
        git pull
        while IFS='' read -r line || [[ -n "$line" ]]; do
            applyCherryPick($line)
        done < "$fileName"
        newUpdateList($count)
    else 
    fi
}
function applyCherryPick(commit) {
    cd $clientBranchPath
    git cherry-pick $commit 2>&1 | tee $logPath/tempCherryPickStatus.txt
    status = "$(python $scriptPath/status.py $logPath/tempCherryPickStatus.txt)"    
    if [ $status = 'True']; then
        $count = $count + 1
    else
        code $branchPath
        echo "Please fix the conflicts and proceed (Fixed/Abort)"
        while read choice; do
            value = $choice
            if [$choice = 'f']; then
                $count = $count + 1
                break
            else
                git cherry-pick --abort
                echo "Success fully applied $count Cherry Picks..."
                echo "Aborting..."
                newUpdateList($count)
                exit 1
            fi
            break
        done < /dev/stdin
    fi
}
function newUpdateList(n) {
    python $scriptPath/count.py $dataPath/count.txt $n 
}
function updateList(n) {
    while IFS='' read -r line || [[ -n "$line" ]]; do
        number = expr $line + $count + 0
        echo $number > $countFileName
    done < "$countFileName"
    exit 1
}
# remove already applied logs

# change branch

# apply cherry-pick loop

# error open code

# wait for reolve or abort

# if resolve add to the already list and push

# if abort abort the cherry-pick and push
