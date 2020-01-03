# commands used
for d in ariamGCW_8; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpw1_gcw2/$d); done
