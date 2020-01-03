#!/bin/bash
cd /dev/shm
pwd

# we need space, and don't care about cvmfs
sudo /bin/rm -fr cvmfs

date
date 1>&2

