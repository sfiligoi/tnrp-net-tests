# commands used to created digested files
for d in ariamMSAW_1 ariamMSAW_8 ariamMSAW_16 ariamMSAW_32 ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/prpw1_msaw2/$d); done
