#!/bin/bash

if [ ! -f "/dev/shm/my_local.config" ]; then
  # Deal with race conditions
  sleep 5
fi
if [ ! -f "/dev/shm/my_local.config" ]; then
  # Deal with race conditions
  sleep 30
fi

if [ ! -f "/dev/shm/my_local.config" ]; then
  # should never get in here, but just in case
  cp /etc/condor/regions/invalid_local.config /dev/shm/my_local.config
  chmod a+r /dev/shm/my_local.config
fi

cat /dev/shm/my_local.config

