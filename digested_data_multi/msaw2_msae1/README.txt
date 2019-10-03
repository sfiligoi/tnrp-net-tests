#
ariapE  - Fetching from Premium account in East zone - single thread
ariaptE - Fetching from Premium account in East zone - multiple threads 
# commands used to create the digested files
for d in ariapE_64 ariaptE_64  ; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msaw2_msae1/$d); done

