# commands used to create the digested files
for d in ariamE_32 ariamE_160 ariamE_400 ariamE_768 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awseuw1_awse1/$d); done
