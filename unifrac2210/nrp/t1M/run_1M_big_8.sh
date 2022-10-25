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
export ISTEP=1432

date
echo "NRP TEST Start: `date +%s`"
t1=`date +%s`
# start the first 27 chunks serially
a=0
for ((n=0; $n<606494; n=$n+75896)); do 
  let m=$n+27*$ISTEP; if [ $m -gt 606494 ]; then m=606494; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=$n; export IEND=$m; source /root/run_1M_support.sh) &
  let a=$a+1
done 
# wait for the IO part of the first to have finished
sleep 90
# then start the last 26 chunks in parallel
a=0
for ((n=0; $n<606494; n=$n+75896)); do 
  let m1=$n+27*$ISTEP
  let m=$n+75896; if [ $m -gt 606494 ]; then m=606494; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=${m1}; export IEND=$m; source /root/run_1M_support.sh) &
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
# start the first 27 chunks serially
a=0
for ((n=0; $n<606494; n=$n+75896)); do 
  let m=$n+27*$ISTEP; if [ $m -gt 606494 ]; then m=606494; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=$n; export IEND=$m; source /root/run_1M_support.sh) &
  let a=$a+1
done 
# wait for the IO part of the first to have finished
sleep 90
# then start the last 26 chunks in parallel
a=0
for ((n=0; $n<606494; n=$n+75896)); do 
  let m1=$n+27*$ISTEP
  let m=$n+75896; if [ $m -gt 606494 ]; then m=606494; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=${m1}; export IEND=$m; source /root/run_1M_support.sh) &
  let a=$a+1
done 
wait
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let t3=${t2}-${t1}
echo "Total runtime: ${t3}"


