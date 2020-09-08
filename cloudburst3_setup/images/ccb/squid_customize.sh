#!/bin/bash
#
# Edit customize.sh as you wish to customize squid.conf.
# It will not be overwritten by upgrades.
# See customhelps.awk for information on predefined edit functions.
# In order to test changes to this, run this to regenerate squid.conf:
#	service frontier-squid
# and to reload the changes into a running squid use
#	service frontier-squid reload
# Avoid single quotes in the awk source or you have to protect them from bash.
#

awk --file `dirname $0`/customhelps.awk --source '{
setoption("acl NET_LOCAL src", "10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 fc00::/7 fe80::/10")
setoption("cache_mem", "128 MB")
setoptionparameter("cache_dir", 3, "10000")
setoption("workers", 4)
setoptionparameter("cache_dir", 2, "/var/cache/squid/squid${process_number}")
print
}'
