# commands used to create the digested files
for d in ariamE_32 ariamE_160 ariamE_400   ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awseuc1_awse1/$d); done
