# command used to create the digest data
for d in aria_800 aria_1000; do echo $d; mkdir $d; (cd $d && ../../digest_one_noRC.py ../../../raw_data_multi/awse1_awse1/$d); done
