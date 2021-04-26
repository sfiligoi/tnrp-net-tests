yum update
#disable selinux
vi /etc/selinux/config

reboot
groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor
yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities
yum -y install condor

#condor_store_cred -f /etc/condor/passwords.d/POOL
download /etc/condor/passwords.d/POOL
download /etc/condor/config.d/90-*.config

# adjust as needed
EXTIP=20.83.210.204
echo "TCP_FORWARDING_HOST = ${EXTIP}" > /etc/condor/config.d/90_nat.config
echo "CONDOR_HOST = ${EXTIP}" > /etc/condor/config.d/90_head_address.config

# Azure: Edit file, add to After and Requires
#vi /usr/lib/systemd/system/condor.service
#
#[Unit]
#Description=Condor Distributed High-Throughput-Computing
#After=network-online.target sshd.service waagent.service nslcd.service ypbind.service time-sync.target nfs.client.target autofs.service
#Wants=network-online.target
#Requires=sshd.service waagent.service


systemctl enable condor

# if enabled in the Cloud image
systemctl disable firewalld

reboot
