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
export OMP_NUM_THREADS=16
export ISTEP=19248

date
echo "NRP TEST Start: `date +%s`"
t1=`date +%s`
a=0
for ((n=0; $n<153619; n=$n+19248)); do 
  let m1=$n+12832; if [ $m1 -gt 153619 ]; then m1=153619; fi
  let m2=$m1+6416; if [ $m2 -gt 153619 ]; then m2=153619; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=$n; export IEND=$m1; export ISTEP=12832; source /root/run_300k_support.sh; export ISTART=$m1; export IEND=$m2; export ISTEP=6416; source /root/run_300k_support.sh) &
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
a=0
for ((n=0; $n<153619; n=$n+19248)); do 
  let m1=$n+12832; if [ $m1 -gt 153619 ]; then m1=153619; fi
  let m2=$m1+6416; if [ $m2 -gt 153619 ]; then m2=153619; fi
  let cstart=$a*16
  let cend=${cstart}+15
  (export ACC_DEVICE_NUM=$a; export ICORES=${cstart}-${cend}; export ISTART=$n; export IEND=$m1; export ISTEP=12832; source /root/run_300k_support.sh; export ISTART=$m1; export IEND=$m2; export ISTEP=6416; source /root/run_300k_support.sh) &
  let a=$a+1
done 
wait
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let t3=${t2}-${t1}
echo "Total runtime: ${t3}"


