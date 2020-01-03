# commands used
for d in ariamGCE_32 ariaGCE_32; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpe1_gce1/$d); done
