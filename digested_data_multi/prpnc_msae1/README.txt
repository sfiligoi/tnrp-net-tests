#commands used for creating the digested files
for d in ariamMSAE_1 ariamMSAE_8 ariamMSAE_32; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpnc_msae1/$d); done
