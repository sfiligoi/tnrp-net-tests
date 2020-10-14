yum update
reboot
groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor
yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities
yum -y install condor
yum install -y osg-wn-client aria2
yum install -y osg-oasis
yum install -y git

download /etc/condor/passwords.d/POOL
download /etc/condor/config.d/90-*.config

HEADIP=34.123.93.167
echo "CONDOR_HOST = ${HEADIP}" > /etc/condor/config.d/90_head_address.config

# adjust as needed
EXTIP=<MYIP>
echo "TCP_FORWARDING_HOST = ${EXIP}" > /etc/condor/config.d/90_nat.config

# CVMFS setup
echo '/cvmfs /etc/auto.cvmfs' > /etc/auto.master.d/cvmfs.autofs
echo 'CVMFS_REPOSITORIES="`echo $((echo oasis.opensciencegrid.org;echo cms.cern.ch;ls /cvmfs)|sort -u)|tr ' ' ,`"' > /etc/cvmfs/default.local
echo 'CVMFS_QUOTA_LIMIT=10000' >> /etc/cvmfs/default.local
# change as needed
echo CVMFS_HTTP_PROXY="127.0.0.1:3128" >> /etc/cvmfs/default.local
chmod a+r /etc/cvmfs/default.local


systemctl enable condor
systemctl enable autofs

# if enabled in the Cloud image
systemctl disable firewalld

reboot
