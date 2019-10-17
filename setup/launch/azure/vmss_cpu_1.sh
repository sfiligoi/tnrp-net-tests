#!/bin/bash

now=`date +%s`
mkdir -p /tmp/avmssc1_${now}
cd /tmp/avmssc1_${now}
for n in exav7d2uswest2 exav7d2useast1 exav7d2ussc exav7d2usnc exav7d2euwest exav7d2eunorth exav7d2uksouth exav7d2apse exav7d2apjp exav7d2apau exav7d2apko exav7d2canada; do \
  az vmss scale  --resource-group exa --name ${n}  --new-capacity 1 > ${n}.log &
  # sleep a bit in between so not to overwhelm the system
  sleep 1
done
echo Logs in /tmp/avmssc1_${now}
wait
