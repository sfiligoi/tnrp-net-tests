nvidia-smi -L
echo "======================================="
lscpu
echo "======================================="
clinfo
echo "======================================="
nvidia-smi
echo "======================================="
cd /root
conda activate unifrac
wget -q http://uaf-10.t2.ucsd.edu/~sfiligoi/unifrac_inputs/50k/ag_emp_even500.biom
wget -q http://uaf-10.t2.ucsd.edu/~sfiligoi/unifrac_inputs/50k/ag_emp.tre 
export UNIFRAC_GPU_INFO=Y
export OMP_NUM_THREADS=4
rm -f a.h5
date
echo "NRP TEST Start: `date +%s`"
time ssu -m unweighted_fp32 -i ag_emp_even500.biom -t ag_emp.tre -f --pcoa 0 -o a.h5 -r hdf5
echo "NRP TEST End: `date +%s`"
rm -f a.h5
date
echo "NRP TEST Start: `date +%s`"
time ssu -m unweighted_fp32 -i ag_emp_even500.biom -t ag_emp.tre -f --pcoa 0 -o a.h5 -r hdf5
echo "NRP TEST End: `date +%s`"
