#!/bin/bash

for i in max.373 max.382 world-s3usc.769 world-s3usc.791 world-gsusc.821 world-gsusc.843; do
 t=`echo $i | awk '{split($0,a,"."); print a[1]}'`
 j=`echo $i | awk '{split($0,a,"."); print a[2]}'`
 if [ ! -f data_multi/all-regions.multi-${t}.all.${j}.out ]; then
   echo all-regions.multi-${t}.all.${j}.out
   ./parse_icecube_multi.py 30 ../condor/out/all-regions.multi-${t}.${j}/data.*multi* >data_multi/all-regions.multi-${t}.all.${j}.out
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out ]; then
     echo all-regions.multi-${t}.${c}.${j}.out
     ./parse_icecube_multi.py 30 ../condor/out/all-regions.multi-${t}.${j}/data.${c}*multi* >data_multi/all-regions.multi-${t}.${c}.${j}.out
   fi
 done
done

for i in max-long.658 max-long.667 world-long.676 world-long-gsusc.892 world-long-gsusc.914; do
 t=`echo $i | awk '{split($0,a,"."); print a[1]}'`
 j=`echo $i | awk '{split($0,a,"."); print a[2]}'`
 if [ ! -f data_multi/all-regions.multi-${t}.all.${j}.out ]; then
   echo all-regions.multi-${t}.all.${j}.out
   ./parse_icecube_long.py 30 ../condor/out/all-regions.multi-${t}.${j}/data.*long* >data_multi/all-regions.multi-${t}.all.${j}.out
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out ]; then
     echo all-regions.multi-${t}.${c}.${j}.out
     ./parse_icecube_long.py 30 ../condor/out/all-regions.multi-${t}.${j}/data.${c}*long* >data_multi/all-regions.multi-${t}.${c}.${j}.out
   fi
 done
done

els=`(cd ../condor/out && ls -1 data.*icecube.multi.0.out)`
for f in $els; do
  p=`echo $f | awk '{split($0,a,".icecube.multi"); print a[1]}'`
  #echo $p
  if [ ! -f data_multi/${p}.out ]; then
    echo ${p}.out
    ./parse_icecube_multi.py 30 ../condor/out/${p}.*icecube.multi* >data_multi/${p}.out
  fi
done

els=`(cd ../condor/out && ls -1 data.*icecube_gsusc.multi.0.out)`
for f in $els; do
  p=`echo $f | awk '{split($0,a,".icecube_gsusc.multi"); print a[1]}'`
  #echo $p
  if [ ! -f data_multi/${p}.gsusc.out ]; then
    echo ${p}.out
    ./parse_icecube_multi.py 30 ../condor/out/${p}.*icecube_gsusc.multi* >data_multi/${p}.gsusc.out
  fi
done

els=`(cd ../condor/out && ls -1 data.*icecube_s3usc.multi.0.out)`
for f in $els; do
  p=`echo $f | awk '{split($0,a,".icecube_s3usc.multi"); print a[1]}'`
  #echo $p
  if [ ! -f data_multi/${p}.s3usc.out ]; then
    echo ${p}.out
    ./parse_icecube_multi.py 30 ../condor/out/${p}.*icecube_s3usc.multi* >data_multi/${p}.s3usc.out
  fi
done

for gt in standard; do
  els=`(cd ../condor/out/gcp-${gt} && ls -1 data.GCP*multi.0.out)`
  for f in $els; do
    p=`echo $f | awk '{split($0,a,".icecube.multi"); print a[1]}'`
    #echo $p
    if [ ! -f data_multi/${gt}.${p}.out ]; then
      echo ${gt}.${p}.out
      ./parse_icecube_multi.py 30 ../condor/out/gcp-${gt}/${p}.*multi* >data_multi/${gt}.${p}.out
    fi
  done
done
