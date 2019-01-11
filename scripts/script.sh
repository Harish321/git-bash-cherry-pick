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

cd ..
scriptPath = "$(pwd)"
cd ../irf-perdix-client
mainPath = "$(pwd)"
cd ../branches/irf-perdix-client
branchPath = "$(pwd)"

# get the from env, to env

# get the log of from env
function getlog() {
    cd $path/irf-perdix-client
    git log > $path/git-bash-cherry-pick/logs/temp.log
    findNewLogs($from,$to,$path)
}

function findNewLogs() {
    python $path/git-bash-cherry-pick/script/prepareCherryPickList.py $from
    timeToCherryPick($path,$from,$to)
}
function timeToCherryPick() {
    cd ../branches/irf-perdix-client
    getBranch = $(git branch | grep \* | cut -d ' ' -f2)
    if [ $getBranch = $to ]; then
        git pull
        while IFS='' read -r line || [[ -n "$line" ]]; do
            applyCherryPick($line)
        done < "$fileName" 
    else 
    fi
}
function applyCherryPick(commit) {
    cd $branchPath
    git cherry-pick $commit > $scriptPath/logs/tempCherrypick.txt
    status = "$(python $scriptPath/scripts/status.py)"    
    if [ $status = 'true']; then
        $count = $count + 1
    else
        code $branchPath
        while read choice; do
            echo "Please fix the conflicts and proceed (Fixed/Abort)"
            value = $choice
            if [$choice = 'f']; then
                $count = $count + 1
            else
                git cherry-pick --abort
                echo "Success fully applied $count Cherry Picks..."
                echo "Aborting..."
                exit 1
            fi
        done < /dev/stdin
    fi
}
# remove already applied logs

# change branch

# apply cherry-pick loop

# error open code

# wait for reolve or abort

# if resolve add to the already list and push

# if abort abort the cherry-pick and push
