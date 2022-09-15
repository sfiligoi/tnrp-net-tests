nvidia-smi -L
echo "======================================="
lscpu
echo "======================================="
nvidia-smi
echo "======================================="
unzip /home/suxingyu98/VD_TF_clean.zip 
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
unzip /home/suxingyu98/VD_TF_clean.zip
cd VD_TF/
t1=`date +%s`
echo "NRP TEST Start: `date +%s`"
time python -u model_train.py
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let dt=$t2-$t1
echo "Elapsed time: $dt"

