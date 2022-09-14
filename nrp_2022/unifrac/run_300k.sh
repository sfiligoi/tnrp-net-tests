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
date
echo "NRP TEST Start: `date +%s`"
for ((i=0; $i<153619; i=$i+9632)); do 
  let j=$i+9632; if [ $j -gt 153619 ]; then j=153619; fi
  echo $i $j
  time ssu -m unweighted_fp32 -i x_merged.withplacement_even500.anonymized.biom -t archive-redbiom-070920-insertion_tree.relabelled.tre -f --mode partial --start $i --stop $j -o a.p${i}
  echo "rc: " $?
  ls -l a.p${i}
  rm -f a.p${i}
done
date
echo "NRP TEST Start: `date +%s`"
for ((i=0; $i<153619; i=$i+9632)); do 
  let j=$i+9632; if [ $j -gt 153619 ]; then j=153619; fi
  echo $i $j
  time ssu -m unweighted_fp32 -i x_merged.withplacement_even500.anonymized.biom -t archive-redbiom-070920-insertion_tree.relabelled.tre -f --mode partial --start $i --stop $j -o a.p${i}
  echo "rc: " $?
  ls -l a.p${i}
  rm -f a.p${i}
done
echo "NRP TEST End: `date +%s`"
