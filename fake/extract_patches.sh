#TODO check number of parameters
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 pathToLog"
    exit
fi

objTypes[0]="ball"
objTypes[1]="goal"
objTypes[2]="obstacle"
objTypes[3]="object"

ROBOTS=(sycu2 sycu4)

dstFolder="patches/results"


folderName=$1

# Cleaning existing results
rm -rf $dstFolder
mkdir -p $dstFolder

for robot in ${ROBOTS[@]}; do
    robotPath=${folderName}/${robot}
    if [ ! -d "$robotPath" ]; then
        continue
    fi
    echo ${robot}
    seqPaths=$(ls -d ${robotPath}/*/)
    echo $seqPaths
    for seqFolder in ${seqPaths[@]}; do
        echo "-> ${seqFolder}"


        # Prepare environment
        ./prepare.sh ${robot} ${seqFolder}
        
        # Ensure patches folder are created and empty
        for objType in ${objTypes[@]}; do
            rm -rf patches/${objType}
            mkdir -p patches/${objType}
        done
        # Get logs
        ./run.sh

        # Move objTypes inside folder
	seqName=$(basename $seqFolder)
        seqDst=${dstFolder}/${robot}/${seqName}
        mkdir -p ${seqDst}
        for objType in ${objTypes[@]}; do
            mv patches/${objType} ${seqDst}
        done
    done
done

# TODO print recap of what has been seen

# Zip the logs to an archive
cd ${dstFolder}
zip -r patches.zip *
