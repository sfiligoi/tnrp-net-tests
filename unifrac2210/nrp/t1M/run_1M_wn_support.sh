if [ "x$ICORES" == "x" ]; then
  # just in case
  export ICORES=0-63
fi

for ((i=$ISTART; $i<$IEND; i=$i+$ISTEP)); do 
  let j=$i+$ISTEP; if [ $j -gt 606494 ]; then j=606494; fi
  echo start $i stop $j gpu ${ACC_DEVICE_NUM} cores $ICORES
  time taskset -c $ICORES ssu -m weighted_normalized_fp32 -i x_merged.withplacement_even1k_4replicates.biom -t x_merged.withplacement_even1k_4replicates.features.tre  -f --mode partial --start $i --stop $j -o a.p${i}
  echo "rc: " $?
  ls -l a.p${i}
  rm -f a.p${i}
done