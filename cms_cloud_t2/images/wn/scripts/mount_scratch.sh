#!/bin/bash
mkdir -p /mnt/resource/execute
chown condor:condor /mnt/resource/execute
mkdir -p /mnt/resource/cvmfs_cache

mkdir -p /mnt/resource/squid

mkdir -p /mnt/resource/squid/log
chown squid:squid /mnt/resource/squid/log

mkdir -p /mnt/resource/squid/cache
chown squid:squid /mnt/resource/squid/cache

