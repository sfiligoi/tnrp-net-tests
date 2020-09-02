#!/bin/bash

#
# Usage:
#   $1 proxy file
#   $2 infile_base
#   $3 infile size
#   $4 serverurl
#   $5 num repeats
#   $6 num parallels
#

np=$6

for ((i=0; $i<${np}; i=$i+1)); do
   fname="$2_$i"
   # percen +-32%
   let p=68+${RANDOM}%64
   let size=$3*${p}/100

   ./upload_many.sh "$1" "${fname}" "${size}" "$4" "$5" >up_$i.out.log 2>up_$i.err.log &
done
echo "`date` INFO: Submitted $np uploads"
wait
echo "`date` INFO: Finished $np uploads"

for ((i=0; $i<${np}; i=$i+1)); do
  echo "=== Stream $i ===="
  cat up_$i.out.log
  rm -f up_$i.out.log
  cat up_$i.err.log 1>&2
  rm -f up_$i.err.log
done



