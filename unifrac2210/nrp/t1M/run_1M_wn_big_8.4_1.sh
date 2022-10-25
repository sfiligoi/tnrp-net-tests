#!/bin/bash
source /root/.bashrc

nvidia-smi -L
echo "======================================="
lscpu
echo "======================================="
nvidia-smi
echo "======================================="
cd /root
conda activate unifrac
export UNIFRAC_GPU_INFO=Y
export UNIFRAC_TIMING_INFO=Y
export OMP_NUM_THREADS=8
export ISTEP=1458

date
echo "NRP TEST Start: `date +%s`"
t1=`date +%s`
# start the first 7 chunks serially
a=0
for ((n=0; $n<151624; n=$n+18953)); do 
  let m=$n+7*$ISTEP; if [ $m -gt 151624 ]; then m=151624; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=$n; export IEND=$m; source /root/run_1M_wn_support.sh) &
  let a=$a+1
done 
# wait for the IO part of the first to have finished
sleep 90
# then start the last 6 chunks in parallel
a=0
for ((n=0; $n<151624; n=$n+18953)); do 
  let m1=$n+7*$ISTEP
  let m=$n+18953; if [ $m -gt 151624 ]; then m=151624; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=${m1}; export IEND=$m; source /root/run_1M_wn_support.sh) &
  let a=$a+1
done 
wait
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let t3=${t2}-${t1}
echo "Total runtime: ${t3}"

date
echo "NRP TEST Start: `date +%s`"
t1=`date +%s`
# start the first 7 chunks serially
a=0
for ((n=0; $n<151624; n=$n+18953)); do 
  let m=$n+7*$ISTEP; if [ $m -gt 151624 ]; then m=151624; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=$n; export IEND=$m; source /root/run_1M_wn_support.sh) &
  let a=$a+1
done 
# wait for the IO part of the first to have finished
sleep 90
# then start the last 6 chunks in parallel
a=0
for ((n=0; $n<151624; n=$n+18953)); do 
  let m1=$n+7*$ISTEP
  let m=$n+18953; if [ $m -gt 151624 ]; then m=151624; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=${m1}; export IEND=$m; source /root/run_1M_wn_support.sh) &
  let a=$a+1
done 
wait
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let t3=${t2}-${t1}
echo "Total runtime: ${t3}"


