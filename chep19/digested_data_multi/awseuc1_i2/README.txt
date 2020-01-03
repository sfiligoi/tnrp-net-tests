# Command used to create the digested files
for d in aria1AM_8 aria1AM_32 aria1AM_64 aria1SD_32 aria1NY_32 aria1CH_32; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awseuc1_i2/$d); done
