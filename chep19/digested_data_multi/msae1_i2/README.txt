# Command used to generate the results
for d in aria1AM_16 aria1AM_32 aria1CH_16 aria1CH_32 aria1KS_16 aria1KS_32 aria1SD_16 aria1SD_32 aria1SD_64; do mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msae1_i2/$d); done
for d in aria1NY_16 aria1NY_32 aria1NY_64 ; do mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msae1_i2/$d); done
for d in aria1NYCH_32  aria1NYSD_32 ; do mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msae1_i2/$d); done

