# commands used for creating the digested files
for d in ariapmtE_32 ariapmtE_160 ariapmtE_400 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msasabra_msae1/$d); done
