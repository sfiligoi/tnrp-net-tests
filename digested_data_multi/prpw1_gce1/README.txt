# command executed
for d in ariaGCE_8 for d in ariamGCE_8 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpw1_gce1/$d); done
