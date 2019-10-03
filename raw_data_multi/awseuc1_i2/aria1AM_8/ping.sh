#!/bin/bash
echo "hostname: `hostname`"
echo "ping fiona-r-uva.vlan7.uvalight.net"
ping -c 2 fiona-r-uva.vlan7.uvalight.net
echo "tracepath fiona-r-uva.vlan7.uvalight.net"
tracepath fiona-r-uva.vlan7.uvalight.net

