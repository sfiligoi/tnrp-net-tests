#!/bin/bash
echo "# Timestamp Idle Running"

data=`condor_status -schedd -af TotalIdleJobs -af TotalRunningJobs | awk 'BEGIN{i=0;r=0}/./{i=i+$1;r=r+$2}END{printf("%i %i\n",i,r)}'`

echo "`date +%s` ${data}"
