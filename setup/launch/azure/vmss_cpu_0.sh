#!/bin/bash

# base one per Region
vvs="exav7d2uswest2 exav7d2useast1 exav7d2ussc exav7d2usnc exav7d2euwest exav7d2eunorth exav7d2uksouth exav7d2apse exav7d2apjp exav7d2apau exav7d2apko exav7d2canada"

# other type
vvs="${vvs} exav7d1uswest2 exav7d1useast1 exav7d1ussc exav7d1usnc exav7d1euwest exav7d1eunorth exav7d1apse exav7d1apjp exav7d1apau"

# the hugher count ones, interleaved
for i in 1 2 3 4; do
  vvs="${vvs} exav7d2uswest2i${i} exav7d2useast1i${i} exav7d2usnci${i} exav7d2euwesti${i} exav7d2eunorthi${i} exav7d2uksouthi${i} exav7d2apsei${i} exav7d1useast1i${i} exav7d1ussci${i}"
done

for i in 5 6 7 8 9; do
  vvs="${vvs} exav7d2uswest2i${i} exav7d2useast1i${i} exav7d2euwesti${i} exav7d2eunorthi${i} exav7d2uksouthi${i} exav7d2apsei${i} exav7d1useast1i${i} exav7d1ussci${i}"
done

for i in a b c d e f g; do
  vvs="${vvs} exav7d2uswest2i${i} exav7d2useast1i${i} exav7d2euwesti${i} exav7d1useast1i${i} exav7d1ussci${i}"
done

now=`date +%s`
mkdir -p /tmp/avmssc0_${now}
cd /tmp/avmssc0_${now}
echo Logs in /tmp/avmssc0_${now}
for n in ${vvs}; do 
  echo "az vmss scale  --resource-group exa --name ${n}  --new-capacity 0"
  az vmss scale  --resource-group exa --name ${n}  --new-capacity 0 > ${n}.log &
  # sleep a bit in between so not to overwhelm the system
  sleep 1
done
echo "Waiting for completion"
wait
