# commands used to create the digested files
for d in ariamW_32 ariamW_160 ariamW_300 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awsapsyd_awsw2/$d); done
