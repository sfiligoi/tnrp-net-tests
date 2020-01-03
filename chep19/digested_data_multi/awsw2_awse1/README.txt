# commands used to create the digestted files
for d in ariamE_400 ariamE_550  ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awsw2_awse1/$d); done
