#commands used
for d in ariamGCE_8 ariamGCE_32; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpnc_gce1/$d); done
