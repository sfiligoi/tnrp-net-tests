#!/bin/bash

for i in max.373 max.382 world-s3usc.769 world-s3usc.791 world-gsusc.821 world-gsusc.843; do
 t=`echo $i | awk '{split($0,a,"."); print a[1]}'`
 j=`echo $i | awk '{split($0,a,"."); print a[2]}'`
 if [ ! -f data_multi/all-regions.multi-${t}.all.${j}.out ]; then
   echo all-regions.multi-${t}.all.${j}.out
   ./parse_icecube_multi.py ../condor/out/all-regions.multi-${t}.${j}/data.*multi* >data_multi/all-regions.multi-${t}.all.${j}.out
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out ]; then
     echo all-regions.multi-${t}.${c}.${j}.out
     ./parse_icecube_multi.py ../condor/out/all-regions.multi-${t}.${j}/data.${c}*multi* >data_multi/all-regions.multi-${t}.${c}.${j}.out
   fi
 done
done

for j in 658 667; do
 if [ ! -f data_multi/all-regions.multi-max-long.all.${j}.out ]; then
   echo all-regions.multi-max-long.all.${j}.out
   ./parse_icecube_long.py ../condor/out/all-regions.multi-max-long.${j}/data.*long* >data_multi/all-regions.multi-max-long.all.${j}.out
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-regions.multi-max-long.${c}.${j}.out ]; then
     echo all-regions.multi-max-long.${c}.${j}.out
     ./parse_icecube_long.py ../condor/out/all-regions.multi-max-long.${j}/data.${c}*long* >data_multi/all-regions.multi-max-long.${c}.${j}.out
   fi
 done
done

for j in 676; do
 if [ ! -f data_multi/all-regions.multi-world-long.all.${j}.out ]; then
   echo all-regions.multi-world-long.all.${j}.out
   ./parse_icecube_long.py ../condor/out/all-regions.multi-world-long.${j}/data.*long* >data_multi/all-regions.multi-world-long.all.${j}.out
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-regions.multi-world-long.${c}.${j}.out ]; then
     echo all-regions.multi-world-long.${c}.${j}.out
     ./parse_icecube_long.py ../condor/out/all-regions.multi-world-long.${j}/data.${c}*long* >data_multi/all-regions.multi-world-long.${c}.${j}.out
   fi
 done
done


els=`(cd ../condor/out && ls -1 data.*multi.0.out)`
for f in $els; do
  p=`echo $f | awk '{split($0,a,".icecube.multi"); print a[1]}'`
  #echo $p
  if [ ! -f data_multi/${p}.out ]; then
    echo ${p}.out
    ./parse_icecube_multi.py ../condor/out/${p}.*multi* >data_multi/${p}.out
  fi
done

for gt in standard; do
  els=`(cd ../condor/out/gcp-${gt} && ls -1 data.GCP*multi.0.out)`
  for f in $els; do
    p=`echo $f | awk '{split($0,a,".icecube.multi"); print a[1]}'`
    #echo $p
    if [ ! -f data_multi/${gt}.${p}.out ]; then
      echo ${gt}.${p}.out
      ./parse_icecube_multi.py ../condor/out/gcp-${gt}/${p}.*multi* >data_multi/${gt}.${p}.out
    fi
  done
done
