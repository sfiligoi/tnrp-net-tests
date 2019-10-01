# Typers of tests
ariab - Single Standard Blob Storage account
ariap - Single Premium Blob Storage account
ariapm - Multiple Premium Blob Storage accounts

uploadp - Upload to Premium Blob Storage
uploadpm - Upload to multiple Premium Blob Storage
# command used to produce digested results
for d in ariab_128 ariab_32 ariab_64 ariap_128 ariap_160 ariap_64; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msae1_msae1/$d); done
for d in uploadp_64 uploadpm_128 ; do echo $d; mkdir $d; (cd $d && ../../digest_one_noRC.py ../../../raw_data_multi/msae1_msae1/$d); done
