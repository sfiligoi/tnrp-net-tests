#!/bin/bash

if [ ! -f "/dev/shm/condor_public_ip.config" ]; then
  myip=`curl -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text"`
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # still showing private ip
    sleep 5
    myip=`curl -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text"`
  fi
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # still showing private ip
    sleep 30
    myip=`curl -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text"`
  fi

  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # no way this will ever work, just prevent it to be matched
    echo "START = FALSE" > ${fname}
  else
    echo "TCP_FORWARDING_HOST = ${myip}" > ${fname}
  fi
  mv ${fname} /dev/shm/condor_public_ip.config
fi

cat /dev/shm/condor_public_ip.config
