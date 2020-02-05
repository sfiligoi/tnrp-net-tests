#!/bin/bash

for i in world-s3usc.769 world-s3usc.791 world-gsusc.821 world-gsusc.843; do
 t=`echo $i | awk '{split($0,a,"."); print a[1]}'`
 j=`echo $i | awk '{split($0,a,"."); print a[2]}'`
 if [ ! -f data_multi/all-regions.multi-${t}.all.${j}.out10 ]; then
   echo all-regions.multi-${t}.all.${j}.out10
   ./parse_icecube_multi.py 10 ../condor/out/all-regions.multi-${t}.${j}/data.*multi* >data_multi/all-regions.multi-${t}.all.${j}.out10
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_multi.py 10 ../condor/out/all-regions.multi-${t}.${j}/data.${c}*multi* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi
 done
done

for i in world-long.676 world-long-gsusc.892 world-long-gsusc.914; do
 t=`echo $i | awk '{split($0,a,"."); print a[1]}'`
 j=`echo $i | awk '{split($0,a,"."); print a[2]}'`
 if [ ! -f data_multi/all-regions.multi-${t}.all.${j}.out10 ]; then
   echo all-regions.multi-${t}.all.${j}.out10
   ./parse_icecube_long.py 10 ../condor/out/all-regions.multi-${t}.${j}/data.*long* >data_multi/all-regions.multi-${t}.all.${j}.out10
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_long.py 10 ../condor/out/all-regions.multi-${t}.${j}/data.${c}*long* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi
 done
done

