nvidia-smi -L
echo "======================================="
lscpu
echo "======================================="
nvidia-smi
echo "======================================="
cd /home/suxingyu98 

tar -xf /data/512_075.tar

unzip /data/VD_TF_clean.zip 
cd VD_TF/
t1=`date +%s`
echo "NRP TEST Start: `date +%s`"
time python -u model_train.py
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let dt=$t2-$t1
echo "Elapsed time: $dt"

cd ..
rm -fr VD_TF
unzip /data/VD_TF_clean.zip
cd VD_TF/
t1=`date +%s`
echo "NRP TEST Start: `date +%s`"
time python -u model_train.py
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let dt=$t2-$t1
echo "Elapsed time: $dt"

