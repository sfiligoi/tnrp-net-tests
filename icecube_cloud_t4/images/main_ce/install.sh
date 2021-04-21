yum update
reboot
groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor
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
certbot certonly -d icecube-cloud-t4-ce.t2.ucsd.edu

cp /etc/letsencrypt/live/icecube-cloud-t4-ce.t2.ucsd.edu/cert.pem /etc/grid-security/hostcert.pem
cp /etc/letsencrypt/live/icecube-cloud-t4-ce.t2.ucsd.edu/privkey.pem /etc/grid-security/hostkey.pem

#condor_store_cred -f /etc/condor/passwords.d/POOL
download /etc/condor/passwords.d/POOL
download /etc/condor/config.d/*.config
download /etc/osg/config.d/*.ini

# adjust as needed
EXTIP=35.236.48.231
echo "TCP_FORWARDING_HOST = ${EXTIP}" > /etc/condor/config.d/90_nat.config
echo 'HOST_ALIAS = icecube-cloud-t4-ce.t2.ucsd.edu' >> /etc/condor/config.d/90_nat.config

echo "TCP_FORWARDING_HOST = ${EXTIP}" > /etc/condor-ce/config.d/90_nat.config
echo 'HOST_ALIAS = icecube-cloud-t4-ce.t2.ucsd.edu' >> /etc/condor-ce/config.d/90_nat.config

echo "CONDOR_HOST = 34.94.222.156" > /etc/condor/config.d/90_head_address.config

groupadd -g 3001 osg && useradd -u 3001 -g 3001 -s /usr/bin/bash osg
groupadd -g 3002 icecube && useradd -u 3002 -g 3002 -s /usr/bin/bash icecube


osg-configure -v
osg-configure -c
systemctl enable fetch-crl-boot
systemctl enable fetch-crl-cron
systemctl enable gratia-probes-cron
systemctl enable condor
systemctl enable condor-ce
systemctl enable osg-ca-certs-updater-cron

reboot
