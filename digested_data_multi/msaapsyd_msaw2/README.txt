# commands used to create the digested files
for d in ariapmtW_32 ariapmtW_160 ariapmtW_400 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msaapsyd_msaw2/$d); done
