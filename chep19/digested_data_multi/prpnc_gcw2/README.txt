# commands used
for d in ariamGCW_8 ariamGCW_32 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpnc_gcw2/$d); done
