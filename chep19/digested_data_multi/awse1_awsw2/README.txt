ariamW - aria2c, remote from US West
# command used to create the digest data
for d in ariamW_80 ariamW_160 ariamW_400 ariamW_500; do echo $d; mkdir $d; (cd $d && ../../digest_one_noRC.py ../../../raw_data_multi/awse1_awsw2/$d); done
