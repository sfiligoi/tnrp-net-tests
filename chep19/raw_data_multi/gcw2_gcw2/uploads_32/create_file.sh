#!/bin/bash
cd /dev/shm
pwd
rm -f 1G.dat
dd if=/dev/urandom of=/dev/shm/1G.dat bs=100000 count=10000
echo "File crearted"
date
date 1>&2

