#
arias - aria2c, single stream
ariam - aria2c, using multiple parallel streams

# command used to create the digest data
for d in ariam_800; do echo $d; mkdir $d; (cd $d && ../../digest_one_noRC.py ../../../raw_data_multi/awse1_awse1/$d); done
