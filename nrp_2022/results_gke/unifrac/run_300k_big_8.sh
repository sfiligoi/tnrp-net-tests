nvidia-smi -L
echo "======================================="
lscpu
echo "======================================="
nvidia-smi
echo "======================================="
cd /root
conda activate unifrac
wget -q http://uaf-10.t2.ucsd.edu/~sfiligoi/unifrac_inputs/300k/x_merged.withplacement_even500.anonymized.biom 
wget -q http://uaf-10.t2.ucsd.edu/~sfiligoi/unifrac_inputs/300k/archive-redbiom-070920-insertion_tree.relabelled.tre
export UNIFRAC_GPU_INFO=Y
export UNIFRAC_TIMING_INFO=Y
export OMP_NUM_THREADS=6
export ISTEP=4812

date
echo "NRP TEST Start: `date +%s`"
t1=`date +%s`
# start the first two chunks serially
a=0
for ((n=0; $n<153619; n=$n+19248)); do 
  let m=$n+2*$ISTEP; if [ $m -gt 153619 ]; then m=153619; fi
  let cstart=$a*12
  let cend=${cstart}+11
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=$n; export IEND=$m; source /root/run_300k_support.sh) &
  let a=$a+1
done 
# wait for the IO part of the first to have finished
sleep 90
# then start the last chunk in parallel
a=0
for ((n=0; $n<153619; n=$n+19248)); do 
  let m1=$n+2*$ISTEP
  let m=$n+19248; if [ $m -gt 153619 ]; then m=153619; fi
  let cstart=$a*12
  let cend=${cstart}+11
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=${m1}; export IEND=$m; source /root/run_300k_support.sh) &
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
# start the first two chunks serially
a=0
for ((n=0; $n<153619; n=$n+19248)); do 
  let m=$n+2*$ISTEP; if [ $m -gt 153619 ]; then m=153619; fi
  let cstart=$a*12
  let cend=${cstart}+11
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=$n; export IEND=$m; source /root/run_300k_support.sh) &
  let a=$a+1
done 
# wait for the IO part of the first to have finished
sleep 90
# then start the last chunk in parallel
a=0
for ((n=0; $n<153619; n=$n+19248)); do 
  let m1=$n+2*$ISTEP
  let m=$n+19248; if [ $m -gt 153619 ]; then m=153619; fi
  let cstart=$a*12
  let cend=${cstart}+11
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=${m1}; export IEND=$m; source /root/run_300k_support.sh) &
  let a=$a+1
done 
wait
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let t3=${t2}-${t1}
echo "Total runtime: ${t3}"


