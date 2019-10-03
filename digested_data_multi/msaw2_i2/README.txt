# command used to create the digested files
for d in aria1SD_32 aria1CH_32 aria1NY_32  ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msaw2_i2/$d); done
