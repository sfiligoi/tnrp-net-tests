#!/bin/bash

els=`(cd data_multi && ls -1 *.out)`

rm -f digested_multi/max.lst digested_multi/top5mean.lst digested_multi/mean.lst digested_multi/digested.lst

for f in $els; do
  fmax=`(cd data_multi && grep 'max:' $f)`
  ftop5mean=`(cd data_multi && grep 'top5 mean:' $f)`
  mean=`(cd data_multi && grep '^mean:' $f)`
  echo "$f ${fmax}"  >> digested_multi/max.lst
  echo "$f ${ftop5mean}"  >> digested_multi/top5mean.lst
  echo "$f ${mean}" >> digested_multi/mean.lst
  echo "$f ${fmax} ${ftop5mean} ${mean}" >> digested_multi/digested.lst
done
