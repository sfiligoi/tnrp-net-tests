yum update
reboot
groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor
yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities
yum -y install condor
yum -y install frontier-squid

download /etc/condor/passwords.d/POOL
download /etc/condor/config.d/*.config

HEADIP=34.123.93.167
echo "CONDOR_HOST = ${HEADIP}" > /etc/condor/config.d/90_head_address.config

# adjust as needed
EXTIP=<MYIP>
echo "TCP_FORWARDING_HOST = ${EXTIP}" > /etc/condor/config.d/90_nat.config

download /etc/squid/customize.sh
chmod a+x /etc/squid/customize.sh

systemctl enable frontier-squid

systemctl enable condor

# if enabled in the Cloud image
systemctl disable firewalld

reboot
