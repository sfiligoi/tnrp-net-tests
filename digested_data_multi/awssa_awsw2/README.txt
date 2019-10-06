# commands used to create the digestted files
for d in ariamW_32 ariamW_160 ariamW_400  ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awssa_awsw2/$d); done
