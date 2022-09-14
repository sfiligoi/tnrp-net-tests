nvidia-smi -L
echo "======================================="
lscpu
echo "======================================="
nvidia-smi
echo "======================================="
cd /rift-example-job
mkdir t1
cp * t1/
mkdir t2
cp t1/* t2/
mkdir t3
cp t1/* t3/
t1=`date +%s`
echo "NRP TEST Start: `date +%s`"
cd /rift-example-job/t1; ./ILE.sh >a.log 2>a.err </dev/null&
cd /rift-example-job/t2; ./ILE.sh >a.log 2>a.err </dev/null&
cd /rift-example-job/t3; ./ILE.sh >a.log 2>a.err </dev/null&
wait
t2=`date +%s`
echo "NRP TEST End: `date +%s`"
let dt=$t2-$t1
echo "Elapsed time for 3 parallel jobs: $dt"
