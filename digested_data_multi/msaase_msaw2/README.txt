# commands used to created digested files
for d in  ariapmtW_32 ariapmtW_400 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msaase_msaw2/$d); done
