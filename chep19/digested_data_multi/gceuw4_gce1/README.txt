# commands used to create the digested files
for d in ariaE_32 ariaE_400 ariaE_800; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/gceuw4_gce1/$d); done
