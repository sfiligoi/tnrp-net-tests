# commands used to create the digested files
for d in ariapmtE_160 ariapmtE_32 ariapmtE_400  ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msaeuw_msae1/$d); done
