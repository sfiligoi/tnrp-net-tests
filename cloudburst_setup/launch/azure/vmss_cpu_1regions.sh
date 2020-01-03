#!/bin/bash

#
# Only start one per region
# Useful for setup issues
#

# base one per Region
vvs="exav7d2uswest2 exav7d2useast1 exav7d2ussc exav7d2usnc exav7d2euwest exav7d2eunorth exav7d2uksouth exav7d2apse exav7d2apjp exav7d2apau exav7d2apko exav7d2canada"

now=`date +%s`
mkdir -p /tmp/avmssc0_${now}
cd /tmp/avmssc0_${now}
echo Logs in /tmp/avmssc0_${now}
for n in ${vvs}; do 
  echo "az vmss scale  --resource-group exa --name ${n}  --new-capacity 1"
  az vmss scale  --resource-group exa --name ${n}  --new-capacity 1 > ${n}.log &
  # sleep a bit in between so not to overwhelm the system
  sleep 1
done
echo "Waiting for completion"
wait
