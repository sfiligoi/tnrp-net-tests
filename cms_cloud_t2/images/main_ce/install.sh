yum update
# disable selinux
vi /etc/selinux/config
reboot
groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor

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
yum -y install osg-ca-certs
yum -y install osg-ca-certs-updater

yum -y install osg-ce-condor

# if enabled in the Cloud image
systemctl disable firewalld

# get cert
yum install certbot
certbot certonly -d cms-cloud-ce.t2.ucsd.edu

cp /etc/letsencrypt/live/cms-cloud-ce.t2.ucsd.edu/cert.pem /etc/grid-security/hostcert.pem
cp /etc/letsencrypt/live/cms-cloud-ce.t2.ucsd.edu/privkey.pem /etc/grid-security/hostkey.pem

#condor_store_cred -f /etc/condor/passwords.d/POOL
download /etc/condor/passwords.d/POOL
download /etc/condor/config.d/*.config
download /etc/osg/config.d/*.ini

# adjust as needed
EXTIP=20.83.225.201
echo "TCP_FORWARDING_HOST = ${EXTIP}" > /etc/condor/config.d/90_nat.config
echo 'HOST_ALIAS = cms-cloud-ce.t2.ucsd.edu' >> /etc/condor/config.d/90_nat.config

echo "TCP_FORWARDING_HOST = ${EXTIP}" > /etc/condor-ce/config.d/90_nat.config
echo 'HOST_ALIAS = cms-cloud-ce.t2.ucsd.edu' >> /etc/condor-ce/config.d/90_nat.config

echo "CONDOR_HOST = 20.83.210.204" > /etc/condor/config.d/90_head_address.config


osg-configure -v
osg-configure -c
systemctl enable fetch-crl-boot
systemctl enable fetch-crl-cron
systemctl enable gratia-probes-cron
systemctl enable condor
systemctl enable condor-ce
systemctl enable osg-ca-certs-updater-cron

reboot
