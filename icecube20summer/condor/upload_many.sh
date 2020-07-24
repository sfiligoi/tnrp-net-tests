#!/bin/bash

#
# Usage:
#   $1 proxy file
#   $2 infile_base
#   $3 infile size
#   $4 serverurl
#   $5 num repeats
#

dd if=/dev/urandom of=${2}_0.bin bs=1M count=$3
rc=$?

if [ $rc -ne 0 ]; then
  echo "ERROR creating file!"   
  exit $rc
fi

for ((i=0; $i<$5; i=$i+1)); do
   ./upload_file.sh "$1" "${2}_${i}.bin" "$3" "$4" 
   rc=$?
   if [ $rc -ne 0 ]; then
     rm  -f "${2}_${i}.bin"
     exit $rc
   fi
   let j=$i+1
   mv "${2}_${i}.bin" "${2}_${j}.bin"
done
rm  -f "${2}_${i}.bin"




