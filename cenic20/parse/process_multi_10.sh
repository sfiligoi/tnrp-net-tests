#!/bin/bash

for i in world-s3usc.769 world-s3usc.791 world-gsusc.821 world-gsusc.843 world-azusw.981 world-azusw.1017 world-prpwww.1074 world-prpwww.1096 world-prpwww.1118 world-prpwww.1140; do
 t=`echo $i | awk '{split($0,a,"."); print a[1]}'`
 j=`echo $i | awk '{split($0,a,"."); print a[2]}'`

 dir=../condor/out/all-regions.multi-${t}.${j}
 if [ ! -f data_multi/all-regions.multi-${t}.all.${j}.out10 ]; then
   echo all-regions.multi-${t}.all.${j}.out10
   ./parse_icecube_multi.py 10 ${dir}/data.*multi* >data_multi/all-regions.multi-${t}.all.${j}.out10
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_multi.py 10 ${dir}/data.${c}*multi* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi
 done

 c=us
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_multi.py 10 ${dir}/data.AWS-us-*multi* ${dir}/data.GCP-us-*multi* ${dir}/data.AZURE-*us.* ${dir}/data.AZURE-*us2.* ${dir}/data.AZURE-CanadaCentral* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi

 c=eu
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_multi.py 10 ${dir}/data.AWS-eu-*multi* ${dir}/data.GCP-eu*multi* ${dir}/data.AZURE-*eu* ${dir}/data.AZURE-*uk* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi

 c=ap
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_multi.py 10 ${dir}/data.AWS-ap-*multi* ${dir}/data.GCP-asia-*multi* ${dir}/data.AZURE-au* ${dir}/data.AZURE-ja* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi

done

for i in world-long.676 world-long-gsusc.892 world-long-gsusc.914; do
 t=`echo $i | awk '{split($0,a,"."); print a[1]}'`
 j=`echo $i | awk '{split($0,a,"."); print a[2]}'`

 dir=../condor/out/all-regions.multi-${t}.${j}

 if [ ! -f data_multi/all-regions.multi-${t}.all.${j}.out10 ]; then
   echo all-regions.multi-${t}.all.${j}.out10
   ./parse_icecube_long.py 10 ${dir}/data.*long* >data_multi/all-regions.multi-${t}.all.${j}.out10
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_long.py 10 ${dir}/data.${c}*long* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi
 done

 c=us
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_long.py 10 ${dir}/data.AWS-us-*long* ${dir}/data.GCP-us-*long* ${dir}/data.AZURE-*us.* ${dir}/data.AZURE-*us2.* ${dir}/data.AZURE-CanadaCentral* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi

 c=eu
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_long.py 10 ${dir}/data.AWS-eu-*long* ${dir}/data.GCP-eu*long* ${dir}/data.AZURE-*eu* ${dir}/data.AZURE-*uk* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi

 c=ap
   if [ ! -f data_multi/all-regions.multi-${t}.${c}.${j}.out10 ]; then
     echo all-regions.multi-${t}.${c}.${j}.out10
     ./parse_icecube_long.py 10 ${dir}/data.AWS-ap-*long* ${dir}/data.GCP-asia-*long* ${dir}/data.AZURE-au* ${dir}/data.AZURE-ja* >data_multi/all-regions.multi-${t}.${c}.${j}.out10
   fi

done

for i in prp.955 prp.1002 prp.1008 prpwww.1066; do
 t=`echo $i | awk '{split($0,a,"."); print a[1]}'`
 j=`echo $i | awk '{split($0,a,"."); print a[2]}'`
 if [ ! -f data_multi/all-clouds.multi-${t}.all.${j}.out10 ]; then
   echo all-clouds.multi-${t}.all.${j}.out10
   ./parse_icecube_multi.py 10 ../condor/out/all-clouds.multi-${t}.${j}/data.*multi* >data_multi/all-clouds.multi-${t}.all.${j}.out10
 fi
 for c in AWS AZURE GCP; do
   if [ ! -f data_multi/all-clouds.multi-${t}.${c}.${j}.out10 ]; then
     echo all-clouds.multi-${t}.${c}.${j}.out10
     ./parse_icecube_multi.py 10 ../condor/out/all-clouds.multi-${t}.${j}/data.${c}*multi* >data_multi/all-clouds.multi-${t}.${c}.${j}.out10
   fi
 done
done

for g in gsusc gsusw s3usc s3usw azusc azusw; do

  els=`(cd ../condor/out && ls -1 data.*icecube_${g}.multi.0.out)`
  for f in $els; do
    p=`echo $f | awk '{split($0,a,".icecube_"); print a[1]}'`
    #echo $p
    if [ ! -f data_multi/${p}.${g}.out10 ]; then
      echo ${p}.${g}.out10
      ./parse_icecube_multi.py 10 ../condor/out/${p}.*icecube_${g}.multi* >data_multi/${p}.${g}.out10
    fi
  done
done

