yum update -y
reboot
yum install -y epel-release yum-plugin-priorities
yum install -y https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum clean all
yum install -y condor

condor_store_cred -f /etc/condor/passwords.d/POOL
# store it for use on wns
# or download it, if you aready have it

# if we ever change the ip, update
echo "TCP_FORWARDING_HOST = 44.231.60.224" > /etc/condor/config.d/90_nat.config


download /etc/condor/config.d/90-security.config
download /etc/condor/config.d/90-myself.config

systemctl enable condor
systemctl start condor
