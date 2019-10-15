#!/bin/bash

if [ ! -f "/dev/shm/count_slots.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  ngpus=`clinfo -l |grep Device |wc -l`
  ncpus=`grep '^processor' /proc/cpuinfo |wc -l`

  let leftcpus="${ncpus} - 2 * ${ngpus}"
  echo "NUM_SLOTS_TYPE_1 = ${ngpus}"    >  ${fname}
  echo "NUM_SLOTS_TYPE_2 = ${leftcpus}" >> ${fname}
  mv ${fname} /dev/shm/count_slots.config
fi

cat /dev/shm/count_slots.config
