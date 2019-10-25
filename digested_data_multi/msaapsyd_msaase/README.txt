# commands used
for d in ariapAP_32 ariapAP_400 ariapmAP_32 ariapmAP_400 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msaapsyd_msaase/$d); done
