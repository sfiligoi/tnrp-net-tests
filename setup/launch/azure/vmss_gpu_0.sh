#!/bin/bash

# base one per Region
vvs="exav7ncuswest2 exav7nc2uswest2 exav7nc3uswest2 exav7nduseast1 exav7nc2useast1 exav7nc3useast1"
vvs="${vvs} exav7nc2ussc exav7nc3ussc exav7ncusnc exav7nvusnc"
vvs="${vvs} exav7ndeuwest exav7c2euwest"
vvs="${vvs} exav7nvapse exav7ndapse exav7ncv3apau"

now=`date +%s`
mkdir -p /tmp/avmssg0_${now}
cd /tmp/avmssg0_${now}
echo Logs in /tmp/avmssg0_${now}
for n in ${vvs}; do 
  echo "az vmss scale  --resource-group exa --name ${n}  --new-capacity 0"
  az vmss scale  --resource-group exa --name ${n}  --new-capacity 0 > ${n}.log &
  # sleep a bit in between so not to overwhelm the system
  sleep 1
done
echo "Waiting for completion"
wait
