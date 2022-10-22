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
export OMP_NUM_THREADS=32
export ISTART=0
export IEND=153619
export ISTEP=25664

export ACC_DEVICE_NUM=0
export ICORES=`nvidia-smi topo -m | grep '^GPU0' |awk '{print $5}'`

date
echo "NRP TEST Start: `date +%s`"
t1=`date +%s`
source /root/run_300k_support.sh 
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let t3=${t2}-${t1}
echo "Total runtime: ${t3}"

date
echo "NRP TEST Start: `date +%s`"
t1=`date +%s`
source /root/run_300k_support.sh 
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let t3=${t2}-${t1}
echo "Total runtime: ${t3}"

