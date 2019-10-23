# commands used to create the derived files
for d in ariaW_32 ariaW_400 ariaW_800; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/gce1_gcw2/$d); done
