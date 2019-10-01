#
arias - aria2c, single stream
ariam - aria2c, using multiple parallel streams

ariamW - aria2c, remote from US West

upload - upload to S3

# command used to create the digest data
for d in ariam_800; do echo $d; mkdir $d; (cd $d && ../../digest_one_noRC.py ../../../raw_data_multi/awse1_awse1/$d); done
for d in ariam_256 ariam_512 ariam_1000 arias_256 arias_512 arias_1000; do echo $d; mkdir $d; (cd $d && ../../digest_one.py ../../../raw_data_multi/awse1_awse1/$d); done
for d in ariamW_80 ariamW_160 ariamW_400 ariamW_500; do echo $d; mkdir $d; (cd $d && ../../digest_one_noRC.py ../../../raw_data_multi/awse1_awse1/$d); done
for d in upload_16 upload_400 ; do echo $d; mkdir $d; (cd $d && ../../digest_one_noRC.py ../../../raw_data_multi/awse1_awse1/$d); done
