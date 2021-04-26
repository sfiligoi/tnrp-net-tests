#!/bin/bash

cd /home/isfiligoi/monitoring
now0=`date +%Y%m%d`
now1=`date +%s`
now2=`date`

cstr=`./summarize_col_snaphot.py`
sstr=`./get_sched_snapshot.sh`
dstr=`./diff_col.sh`

echo "${now1} [${now2}] ${cstr}" >>logs/coll_${now0}.log
echo "${now1} [${now2}] ${sstr}" >>logs/sched_${now0}.log
echo "${now1} [${now2}] ${dstr}" >>logs/diff_${now0}.log

echo "${now1} [${now2}] ${cstr} ${sstr} Diffs: ${dstr}" >>logs/joined_${now0}.log
