#!/bin/bash

killall -9 KidSizeNoVision BehaviorViewer
sleep 1

ports[1]=10100
ports[2]=10200
ports[3]=10300

robot_id=1

for port in ${ports[@]}
do
    dst=tmp_robot_${port}
    rm -rf $dst
    mkdir $dst
    cp -r fake/* $dst
    cd $dst
    sed -i "s/id.value = [0-9]/id.value = ${robot_id}/g" rhio/referee/values.conf
    echo "Running robot ${robot_id} on port ${port}"
    ./KidSizeNoVision -p ${port} > out.log 2>&1 &
    robot_id=$((robot_id + 1))
    sleep 1

    /home/steve/Project/Repo/SYCU/BehaviorViewer/build/BehaviorViewer 127.0.0.1 ${port} &
    sleep 1

    cd ..
done
