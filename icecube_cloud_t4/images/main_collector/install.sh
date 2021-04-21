yum update
reboot
groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor
yum -y install https://repo.opensciencegrid.org/osg/3.6/osg-3.6-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities
yum -y install condor

#condor_store_cred -f /etc/condor/passwords.d/POOL
download /etc/condor/passwords.d/POOL
download /etc/condor/config.d/90-*.config

# adjust as needed
EXTIP=34.94.222.156
echo "TCP_FORWARDING_HOST = ${EXTIP}" > /etc/condor/config.d/90_nat.config
echo "CONDOR_HOST = ${EXTIP}" > /etc/condor/config.d/90_head_address.config

systemctl enable condor

# if enabled in the Cloud image
systemctl disable firewalld

reboot
