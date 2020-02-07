yum update -y
# disble selinux
vi /etc/selinux/config
reboot
yum install -y epel-release yum-plugin-priorities
yum install -y https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum clean all
yum install -y condor
yum install -y docker

yum install -y wget aria2

# must be the same as on condor-head
download /etc/condor/passwords.d/POOL


download /etc/condor/config.d/90-security.config
download /etc/condor/config.d/90-myself.config

download /etc/condor/config.d/80-autodiscover.config
download /etc/condor/scripts/autodiscover.config.sh

systemctl enable docker
systemctl start docker


systemctl enable condor
systemctl start condor
