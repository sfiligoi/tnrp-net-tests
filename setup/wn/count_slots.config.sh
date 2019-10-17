#!/bin/bash

if [ ! -f "/dev/shm/count_slots.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  ngpus=`clinfo -l |grep Device |wc -l`
  ncpus=`grep '^processor' /proc/cpuinfo |wc -l`

  allmem=`free -m |awk '/^Mem:/{print $2}'`

  let leftcpus="${ncpus} - 2 * ${ngpus}"

  # Condor will fail is there is not enough memory per slot, better tune down
  let cpumem=${allmem}-${ngpus}*10000
  let maxcpus=${cpumem}/2000
  if [ ${maxcpus} -lt ${leftcpus} ]; then
    leftcpus=${maxcpus}
  fi

  echo "NUM_SLOTS_TYPE_1 = ${ngpus}"    >  ${fname}
  echo "NUM_SLOTS_TYPE_2 = ${leftcpus}" >> ${fname}
  mv ${fname} /dev/shm/count_slots.config
fi

cat /dev/shm/count_slots.config
