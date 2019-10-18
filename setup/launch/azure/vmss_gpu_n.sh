#!/bin/bash

if [ $# -ne 1 ]; then 
  echo "ERROR: Usage: vmss_cpu_n.sh <i_per_vmss>|t[emplate]"
  exit 1
fi

capacity=$1

if [ "${capacity:0:1}" == "t" ]; then
  istemplate=1
  capacity=VAL
else
  istemplate=0
fi

# base one per Region
vvs="exav7nc2ussc exav7nc3ussc exav7c2euwest exav7ncv3apau"

if [ ${istemplate} -eq 0 ]; then
  now=`date +%s`
  mkdir -p /tmp/avmssgn_${now}
  cd /tmp/avmssgn_${now}
  echo Logs in /tmp/avmssgn_${now}
else
  echo "INFO: Generating template"
fi

for n in ${vvs}; do 
  echo "az vmss scale  --resource-group exa --name ${n}  --new-capacity ${capacity}"
  if [ ${istemplate} -eq 0 ]; then
    az vmss scale  --resource-group exa --name ${n}  --new-capacity ${capacity} > ${n}.log &
    # sleep a bit in between so not to overwhelm the system
    sleep 1
  fi
done
if [ ${istemplate} -eq 0 ]; then
 echo "Waiting for completion"
 wait
fi
