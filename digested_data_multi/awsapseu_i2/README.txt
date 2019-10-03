# commands used to create the digested files
for d in aria1KO_4 aria1SD_32 aria1CH_32  ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awsapseu_i2/$d); done
