#!/bin/bash

day=`date +%Y%m%d`

t1=`date +%s`
/opt/exa_monitor/exa_count_nodes.sh >> /var/log/exa_count_nodes.log-${day}
/opt/exa_monitor/exa_query_collector.sh >> /var/log/exa_query_collector.log-${day}
cat /var/log/exa_query_collector.log-${day} | /opt/exa_monitor/summarize_exa_collector_last.py >> /var/log/exa_summary_collector.log-${day}
/opt/exa_monitor/exa_query_scheds.sh >> /var/log/exa_query_scheds.log-${day}
t2=`date +%s`

# try to start the next query exactly 20s later
let tm=${t1}+20
if [ ${t2} -lt ${tm} ]; then
  let dt=${tm}-${t2}
  sleep $dt
fi

t1=${tm}
/opt/exa_monitor/exa_count_nodes.sh >> /var/log/exa_count_nodes.log-${day}
/opt/exa_monitor/exa_query_collector.sh >> /var/log/exa_query_collector.log-${day}
cat /var/log/exa_query_collector.log-${day} | /opt/exa_monitor/summarize_exa_collector_last.py >> /var/log/exa_summary_collector.log-${day}
/opt/exa_monitor/exa_query_scheds.sh >> /var/log/exa_query_scheds.log-${day}
t2=`date +%s`

# try to start the next query exactly 20s later
let tm=${t1}+20
if [ ${t2} -lt ${tm} ]; then
  let dt=${tm}-${t2}
  sleep $dt
fi

/opt/exa_monitor/exa_count_nodes.sh >> /var/log/exa_count_nodes.log-${day}
/opt/exa_monitor/exa_query_collector.sh >> /var/log/exa_query_collector.log-${day}
cat /var/log/exa_query_collector.log-${day} | /opt/exa_monitor/summarize_exa_collector_last.py >> /var/log/exa_summary_collector.log-${day}
/opt/exa_monitor/exa_query_scheds.sh >> /var/log/exa_query_scheds.log-${day}

