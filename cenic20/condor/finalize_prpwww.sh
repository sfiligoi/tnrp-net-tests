#!/bin/bash

nmax=`cat "$2" |wc -l`

let n=1+${RANDOM}%${nmax}

node=`head -${n} "$2" |tail -1`

cat "$1" | sed "s/siderea.ucsc.edu/${node}/g"
