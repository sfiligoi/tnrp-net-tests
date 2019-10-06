# commands used to create the digested files
for d in ariamW_400  ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awseuw1_awsw2/$d); done
