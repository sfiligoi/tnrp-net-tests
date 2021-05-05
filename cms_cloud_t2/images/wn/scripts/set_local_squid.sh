#!/bin/bash
myip=`hostname -i`

myip1=`echo $myip | awk '{split($1,a,"."); print a[1]}'`
if [ "${myip1}" != "10" ]; then 
  # retry, something went wrong
  sleep 5
  myip=`hostname -i`
  myip1=`echo $myip | awk '{split($1,a,"."); print a[1]}'`
fi
if [ "${myip1}" != "10" ]; then 
  # retry, something went wrong
  sleep 30
  myip=`hostname -i`
  myip1=`echo $myip | awk '{split($1,a,"."); print a[1]}'`
fi

myip2=`echo $myip | awk '{split($1,a,"."); print a[2]}'`

squidip="${myip1}.${myip2}.0.4"

grep -q ' local-squid.local' /etc/hosts
rc=$?
if [ $rc -eq 0 ]; then
  # the entry already exists, remove it
  sed -i 's/.* local-squid.local//' /etc/hosts
fi
echo "${squidip} local-squid.local" >> /etc/hosts

