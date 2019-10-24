# command used for creating digested files
for d in uploads_400; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/msaase_msaase/$d); done
