#!/bin/bash

# Point to the collector
# The value is porpagated in the environment by the osg_collector_prp service 
echo "CONDOR_HOST = ${OSG_COLLECTOR_SERVICE_HOST}" > /etc/condor/config.d/50_condor_host.config

EXTIP=104.198.217.177
echo "TCP_FORWARDING_HOST = ${EXTIP}" > /etc/condor/config.d/90_nat.config
echo 'HOST_ALIAS = icecube-cloud-t4-ce.t2.ucsd.edu' >> /etc/condor/config.d/90_nat.config

echo "TCP_FORWARDING_HOST = ${EXTIP}" > /etc/condor-ce/config.d/90_nat.config
echo 'HOST_ALIAS = icecube-cloud-t4-ce.t2.ucsd.edu' >> /etc/condor-ce/config.d/90_nat.config

# The default CE config does does work nicely with NAT-ed setups
# Must relax the security to allow commands that seem to come from the NAT host
echo "ALLOW_DAEMON = condor@daemon.htcondor.org/10.* condor@child/10.*" > /etc/condor-ce/config.d/98_security.config


# If this is the first use of the persistent disk areas, create the necessary dirs
# This dirs are normally created by the RPM in the base image

if [ -n "/var/lib/condor/spool" ]; then
  mkdir /var/lib/condor/spool   && chown condor:condor /var/lib/condor/spool
  mkdir /var/lib/condor/execute && chown condor:condor /var/lib/condor/execute
fi
chown condor:condor /var/lib/condor

if [ -n "/var/lib/condor-ce/spool" ]; then
  mkdir /var/lib/condor-ce/spool   && chown condor:condor /var/lib/condor-ce/spool
  mkdir /var/lib/condor-ce/execute && chown condor:condor /var/lib/condor-ce/execute
fi
chown condor:condor /var/lib/condor-ce

if [ -n "/home/condor" ]; then
  mkdir /home/condor && chown condor:condor /home/condor
fi

# List of all supported users
groupadd -g 3002 icecube && useradd -u 3002 -g 3002 -s /bin/bash icecube


cat > /etc/condor/namespace_map << EOF
# user namespace
* icecube default
EOF


