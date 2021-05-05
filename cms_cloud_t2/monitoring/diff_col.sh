#!/bin/bash
condor_status -af Name -af DaemonStartTime -af 'strcat("R",substr(FileSystemDomain,3,1))'  | sort > tmp/diff_coll_now.txt
if [ -f tmp/diff_coll_prev.txt ]; then
  diff tmp/diff_coll_now.txt tmp/diff_coll_prev.txt > tmp/diff_coll_now.diff
  lost=`grep '<' tmp/diff_coll_now.diff | awk '{print $4}' |sort |uniq -c | awk '{a[$2]=$1}END{for (k in a) {print k ": +" a[k]}}'`
  new=`grep '>' tmp/diff_coll_now.diff | awk '{print $4}' |sort |uniq -c | awk '{a[$2]=$1}END{for (k in a) {print k ": -" a[k]}}'`
  echo $lost $new
fi


# save the old values
rm -f tmp/diff_coll_old.txt
mv -f tmp/diff_coll_prev.txt tmp/diff_coll_old.txt
rm -f tmp/diff_coll_prev.txt
mv -f tmp/diff_coll_now.txt tmp/diff_coll_prev.txt

