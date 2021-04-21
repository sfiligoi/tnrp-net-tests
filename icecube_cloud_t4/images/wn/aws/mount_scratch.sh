#!/bin/bash
mkfs.xfs /dev/nvme1n1
mkdir /scratch
mount /dev/nvme1n1 /scratch
mkdir /scratch/execute
chown condor:condor /scratch/execute
mkdir /scratch/cvmfs_cache
