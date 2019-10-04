# Commands used to create the digested files
for d in aria1SD_32 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awsapsyd_i2/$d); done
