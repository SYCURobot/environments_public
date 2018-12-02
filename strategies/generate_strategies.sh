#!/bin/sh

#Path to binary
BIN="../../../../devel_release/lib/kid_size/KickStrategy"

FLAGS=""
# Specifiying kick model collection file
FLAGS="${FLAGS} -j sigmaban_plus_kicks.json"
# Specifiying resolution
FLAGS="${FLAGS} -d 5 -a 0.2"
# Adding time tolerance
FLAGS="${FLAGS} -t 5"
# Adding excentric strategy
#FLAGS="${FLAGS} -e"
#FLAGS="${FLAGS} -f lateral_corridor.json"

#Running learning with grass
${BIN} ${FLAGS} -c tmp_with_grass.csv -w > tmp_with_grass.json

#Running learning against grass
${BIN} ${FLAGS} -c tmp_against_grass.csv -o 0 -w > tmp_against_grass.json
