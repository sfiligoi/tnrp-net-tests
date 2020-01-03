#commands used for creating the digested files
for d in ariamAWSW_1 ariamAWSW_8 ariamAWSW_32; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpnc_awsw2/$d); done
