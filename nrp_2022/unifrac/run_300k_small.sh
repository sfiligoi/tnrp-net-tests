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
export OMP_NUM_THREADS=8
export ISTART=0
export IEND=153619
export ISTEP=6416
date
echo "NRP TEST Start: `date +%s`"
source /root/run_300k_support.sh 
echo "NRP TEST End: `date +%s`"

date
echo "NRP TEST Start: `date +%s`"
source /root/run_300k_support.sh 
echo "NRP TEST End: `date +%s`"
