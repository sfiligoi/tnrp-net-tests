#!/bin/bash

cd /home/centos/monitoring

day=`date +%Y%m%d`

t1=`date +%s`

./exa_query_collector.sh >> log/exa_query_collector.log-${day}
cat log/exa_query_collector.log-${day} | ./summarize_exa_collector_last.py >> log/exa_summary_collector.log-${day}
t2=`date +%s`

# try to start the next query exactly 20s later
let tm=${t1}+20
if [ ${t2} -lt ${tm} ]; then
  let dt=${tm}-${t2}
  sleep $dt
fi

t1=${tm}
./exa_query_collector.sh >> log/exa_query_collector.log-${day}
cat log/exa_query_collector.log-${day} | ./summarize_exa_collector_last.py >> log/exa_summary_collector.log-${day}
t2=`date +%s`

# try to start the next query exactly 20s later
let tm=${t1}+20
if [ ${t2} -lt ${tm} ]; then
  let dt=${tm}-${t2}
  sleep $dt
fi

./exa_query_collector.sh >> log/exa_query_collector.log-${day}
cat log/exa_query_collector.log-${day} | ./summarize_exa_collector_last.py >> log/exa_summary_collector.log-${day}

