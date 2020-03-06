yum update
reboot
groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor
yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities
yum -y install condor
yum -y install frontier-squid

#condor_store_cred -f /etc/condor/passwords.d/POOL
download /etc/condor/passwords.d/POOL
download /etc/condor/config.d/20-ccb-tune.config
download /etc/condor/config.d/90-security.config	
download /etc/condor/config.d/98-ccb-multi.config

# adjust as needed
echo "TCP_FORWARDING_HOST = <IP>" > /etc/condor/config.d/90_nat.config

download /etc/squid/customize.sh
chmod a+x /etc/squid/customize.sh

systemctl enable frontier-squid

systemctl enable condor
reboot
