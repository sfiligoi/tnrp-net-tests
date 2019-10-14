# commands used to created digested files
for d in ariamAWSE_1 ariamAWSE_8 ariamAWSE_16 ariamAWSE_32 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpw1_awse1/$d); done
