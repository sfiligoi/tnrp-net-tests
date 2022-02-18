#!/bin/bash

# Point to the collector
# The value is porpagated in the environment by the osg_collecto service
echo "CONDOR_HOST = ${OSG_COLLECTOR_SERVICE_HOST}" > /etc/condor/config.d/99_condor_host.config

# basic setup
/opt/provisioner/setup_k8s_creds.sh

mkdir -p /var/log/provisioner/logs
chown provisioner:provisioner /var/log/provisioner/logs

cp /etc/condor/secret/pool_password /etc/condor/secret/pool_password.provisioner
chown provisioner:provisioner /etc/condor/secret/pool_password.provisioner
chmod go-rwx /etc/condor/secret/pool_password.provisioner

if [ "x${K8S_NAMESPACE}" == "x" ]; then
  echo "Missing K8S_NAMESPACE"
  sleep 15
  exit 1
fi

if [ "x${CVMFS_MOUNTS}" == "x" ]; then
  echo "Missing CVMFS_MOUNTS"
  sleep 15
  exit 1
fi

trap 'echo signal received!; kill $(jobs -p); wait' SIGINT SIGTERM

echo "`date` Starting provisioner_main.py"
su provisioner -c "cd /home/provisioner && python3 provisioner_main.py /var/log/provisioner/logs/provisioner.log ${K8S_NAMESPACE} ${CVMFS_MOUNTS}" &
wait
rc=$?
echo "`date` End of provisioner_main.py, rc=${rc}"

