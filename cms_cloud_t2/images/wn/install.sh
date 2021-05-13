:um update
#disable selinux
vi /etc/selinux/config

reboot
groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor
groupadd -g 2001 squid && useradd -u 2001 -g 2001 -s /sbin/nologin squid

groupadd -g 3001 osg && useradd -u 3001 -g 3001 -s /usr/bin/bash osg
groupadd -g 3006 fermigli && useradd -u 3006 -g 3006 -s /usr/bin/bash fermigli

groupadd -g 3010 cms
useradd -u 3011 -g 3010 -s /usr/bin/bash cmsuser
useradd -u 3012 -g 3010 -s /usr/bin/bash cmspilot
useradd -u 3013 -g 3010 -s /usr/bin/bash uscmslocal
useradd -u 3014 -g 3010 -s /usr/bin/bash cmslocal
useradd -u 3015 -g 3010 -s /usr/bin/bash cmsprod


yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities
yum clean all
yum -y install condor
yum -y install frontier-squid
yum install -y osg-wn-client
yum install -y osg-ca-certs-updater

yum install -y osg-oasis
echo "/cvmfs /etc/auto.cvmfs"> /etc/auto.master.d/cvmfs.autofs

yum install -y singularity


# Azure: Edit file, add to After and Requires
#vi /usr/lib/systemd/system/condor.service
#
#[Unit]
#Description=Condor Distributed High-Throughput-Computing
#After=network-online.target sshd.service waagent.service nslcd.service ypbind.service time-sync.target nfs.client.target autofs.service
#Wants=network-online.target
#Requires=sshd.service waagent.service

systemctl daemon-reload

chown squid:squid customize.sh 
chmod a+x customize.sh
download /etc/squid/customize.sh

rmdir /var/log/squid
ln -s /mnt/resource/squid/log /var/log/squid
rmdir /var/cache/squid
ln -s /mnt/resource/squid/cache /var/cache/squid

rmdir /var/lib/condor/execute
ln -s /mnt/resource/execute /var/lib/condor/execute
rm -fr /var/lib/cvmfs
ln -s /mnt/resource/cvmfs_cache /var/lib/cvmfs

chown root:root mount_scratch.s*
mv mount_scratch.sh /usr/sbin/
mv mount_scratch.service /usr/lib/systemd/system/

chown root:root set_local_squid.s*
mv set_local_squid.sh /usr/sbin/
mv set_local_squid.service /usr/lib/systemd/system/

systemctl daemon-reload
systemctl enable mount_scratch
systemctl enable set_local_squid

download /etc/condor/passwords.d/POOL

download /etc/condor/config.d/*.config

download /etc/cvmfs/default.local
download /etc/cvmfs/config.d/cms.cern.ch.local

echo "CONDOR_HOST = 20.83.210.204" > /etc/condor/config.d/90_head_address.config

systemctl enable fetch-crl-boot
systemctl enable fetch-crl-cron
systemctl enable autofs
systemctl enable frontier-squid
reboot

mkdir -p /etc/cvmfs/SITECONF/T3_US_SDSC
(cd /cvmfs/cms.cern.ch/SITECONF/T3_US_SDSC && tar -cf - .) | (cd /etc/cvmfs/SITECONF/T3_US_SDSC && tar -xf -)

#vi /etc/cvmfs/SITECONF/T3_US_SDSC/JobConfig/site-local-config.xml
# replace
#     <frontier-connect>
#       <proxy url="http://127.0.0.1:3128"/>


systemctl enable osg-ca-certs-updater-cron
systemctl enable condor

# if enabled in the Cloud image
systemctl disable firewalld

reboot
