#commands used for creating the digested files
for d in ariamAWSE_1 ariamAWSE_32; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpnc_awse1/$d); done
