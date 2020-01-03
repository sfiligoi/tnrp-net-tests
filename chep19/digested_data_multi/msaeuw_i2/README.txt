# commands used to create the digested files
for d in aria1SD_32 aria1CH_32 aria1NY_32 aria1AM_32 aria1SD_64 aria1CH_64 aria1NY_64 aria1AM_64 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msaeuw_i2/$d); done
