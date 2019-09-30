# Command used to generate the results
for d in aria1AM_16 aria1AM_32 aria1CH_16 aria1CH_32 aria1CH_48 aria1KO_16 aria1KS_16 aria1KS_32 aria1KS_48 aria1NY_16 aria1NY_32 aria1NY_48 aria1SD_16 aria1SD_32 aria1SD_48; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awse1_i2/$d); done
