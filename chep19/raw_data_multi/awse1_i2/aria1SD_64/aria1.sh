#!/bin/bash
cd /dev/shm
pwd
i=`echo ${_CONDOR_SLOT} | awk '{split($0,a,"slot"); print a[2]}'`
echo Slot ${_CONDOR_SLOT}
echo Fetching 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://stashcache.t2.ucsd.edu:8000/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://stashcache.t2.ucsd.edu:8000/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time aria2c -q --header='Want-Digest: ' -j 80 -x 16 http://stashcache.t2.ucsd.edu:8000/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://stashcache.t2.ucsd.edu:8000/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://stashcache.t2.ucsd.edu:8000/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://stashcache.t2.ucsd.edu:8000/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2

