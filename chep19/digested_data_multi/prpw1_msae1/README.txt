# commands used to created digested files
for d in ariamMSAE_1 ariamMSAE_8 ariamMSAE_16 ariamMSAE_32 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpw1_msae1/$d); done
