# commands used to create the digested files
for d in ariamW_32 ariamW_160 ariamW_400   ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awseuc1_awsw2/$d); done
