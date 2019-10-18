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
vvs="exav7d2uswest2 exav7d2useast1 exav7d2ussc exav7d2usnc exav7d2euwest exav7d2eunorth exav7d2uksouth exav7d2apse exav7d2apjp exav7d2apau exav7d2apko exav7d2canada"

# other type
vvs="${vvs} exav7d1uswest2 exav7d1useast1 exav7d1ussc exav7d1usnc exav7d1euwest exav7d1eunorth exav7d1apse exav7d1apjp exav7d1apau"

# the hugher count ones, interleaved
for i in 1 2 3; do
  vvs="${vvs} exav7d2uswest2i${i} exav7d2useast1i${i} exav7d2usnci${i} exav7d2euwesti${i} exav7d2eunorthi${i} exav7d2uksouthi${i} exav7d2apsei${i}"
done

for i in 4 5 6 7 8 9; do
  vvs="${vvs} exav7d2uswest2i${i} exav7d2useast1i${i} exav7d2euwesti${i}"
done

for i in a b; do
  vvs="${vvs} exav7d2useast1i${i} exav7d2euwesti${i}"
done

if [ ${istemplate} -eq 0 ]; then
  now=`date +%s`
  mkdir -p /tmp/avmssc0_${now}
  cd /tmp/avmssc0_${now}
  echo Logs in /tmp/avmssc0_${now}
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
