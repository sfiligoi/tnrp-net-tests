#!/bin/bash

# List of all supported users
groupadd -g 1000 icecube && useradd -u 1000 -g 1000 -s /bin/bash icecube

groupadd -g 3001 isfiligoi && useradd -u 3001 -g 3001 -s /bin/bash isfiligoi

mkdir -p /data/sim/IceCube/2016/generated/CORSIKA-in-ice/

# Hide multiple mountpoint from icecube
for ((i=0; $i<5; i=$i+1)); do
 let j=$i+1
 ln -s /n${j}/data/sim/IceCube/2016/generated/CORSIKA-in-ice/dir${i} /data/sim/IceCube/2016/generated/CORSIKA-in-ice/dir${i}
done

# make sure the crls are fresh
fetch-crl

