# Typers of tests
ariab - Single Standard Blob Storage account
ariap - Single Premium Blob Storage account
ariapm - Multiple Premium Blob Storage accounts
# command used to produce digested results
for d in ariab_128 ariab_32 ariab_64 ariap_128 ariap_160 ariap_64; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msae1_msae1/$d); done
