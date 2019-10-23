# gcw2 is really Google US West1 (Oregon)... but keeping the same nomenclature as AWS
# commands used to create the digested files
for d in ariaW_32 ariaW_400 ariaW_800 ariaW_1200; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/gcw2_gcw2/$d); done
