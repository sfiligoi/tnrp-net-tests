#!/bin/bash

# base one per Region
vvs=""
vvs="${vvs} exav7nc3apau exav7nc3apjp exav7nc3apko exav7nc3apse exav7nc3canada exav7nc3euwest exav7nc3uksouth exav7nc3useast1 exav7nc3ussc exav7nc3uswest2" 
vvs="${vvs} exav7nc2apse exav7nc2euwest exav7nc2useast1 exav7nc2ussc exav7nc2uswest2"
vvs="${vvs} exav7ndapse exav7ndeuwest exav7nduseast1 exav7nduswest2" 
vvs="${vvs} exav7nvapau exav7nvapjp exav7nvapse exav7nveunorth exav7nveuwest exav7nvuksouth exav7nvuseast1 exav7nvusnc exav7nvussc exav7nvuswest1 exav7nvuswest2" 
vvs="${vvs} exav7ncapau exav7nceunorth exav7nceuwest exav7ncuksouth exav7ncuseast1 exav7ncusnc exav7ncussc exav7ncuswest2"
vvs="${vvs} exav7nv3apau exav7nv3apse exav7nv3eunorth exav7nv3euwest exav7nv3useast1 exav7nv3ussc" 

now=`date +%s`
mkdir -p /tmp/avmssg0_${now}
cd /tmp/avmssg0_${now}
echo Logs in /tmp/avmssg0_${now}

for n in 1 2 3 4 5; do
  if [ $n -eq 1 ]; then
   nstr=""
  else
   nstr="-i${n}"
  fi

  for n in ${vvs}; do 
    echo "az vmss scale  --resource-group exa --name ${n}${nstr}  --new-capacity 0"
    az vmss scale  --resource-group exa --name ${n}${nstr}  --new-capacity 0 > ${n}${nstr}.log &
    # sleep a bit in between so not to overwhelm the system
    sleep 1
  done
done

echo "Waiting for completion"
wait
