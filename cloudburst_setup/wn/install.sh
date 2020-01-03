# Optional on AWS, stay with CentOS 7.6 for Azure
yum update
reboot
#

# Azure needs LIS installed
wget https://aka.ms/lis
tar xvzf lis
cd LISISO
./install.sh
reboot
# end azure

groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor

yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities

# check if nouveau enabled (e.g. on AWS)
lsmod | grep nouveau

#disable nuveou, was enabled
cat >/etc/modprobe.d/blacklist-nouveau.conf << EOF
blacklist nouveau
options nouveau modeset=0
EOF

dracut --force
reboot
# end disable noveou

# get the right kernel rpms in place
# Note: On Azure, stick with CentOS7.6, so get them from
#  http://mirrors.usc.edu/pub/linux/distributions/centos/7.6.1810/updates/x86_64/Packages/
yum install kernel-devel-$(uname -r) kernel-headers-$(uname -r)

curl -o nvidia-driver-local-repo-rhel7-418.87.01-1.0-1.x86_64.rpm 'http://us.download.nvidia.com/tesla/418.87/nvidia-driver-local-repo-rhel7-418.87.01-1.0-1.x86_64.rpm'
yum -y localinstall nvidia-driver-local-repo-rhel7-418.87.01-1.0-1.x86_64.rpm
yum clean all
yum -y install nvidia-driver-latest-dkms
yum -y install cuda-drivers

reboot

yum -y install clinfo

yum install -y condor
yum install -y osg-wn-client aria2

# IceCube Dependencies
yum -y groupinstall "Compatibility Libraries" \
                        "Development Tools" \
                        "Scientific Support"
yum install -y freetype

# AWS
#yum install -y python2-pip && pip install awscli

# Azure
# wget https://aka.ms/downloadazcopy-v10-linux && tar -xvzf downloadazcopy-v10-linux && mv azcopy_linux_amd64_*/azcopy /usr/bin/

# Azure: Edit file, add to After and Requires
#vi /usr/lib/systemd/system/condor.service
#
#[Unit]
#Description=Condor Distributed High-Throughput-Computing
#After=network-online.target sshd.service waagent.service nslcd.service ypbind.service time-sync.target nfs.client.target autofs.service
#Wants=network-online.target
#Requires=sshd.service waagent.service

mkdir -p /opt/exa_scripts/
mkdir -p /etc/exa_cloud/regions

download /opt/exa_scripts/exa* from exa_cloud/
download /opt/exa_scripts/exa* from exa_cloud/<cloud>/

ln -s /opt/exa_scripts/exa_cloud_mangle          /usr/bin/exa_cloud_mangle
ln -s /opt/exa_scripts/exa_cloud_mangle_download /usr/bin/exa_cloud_mangle_download

ln -s /opt/exa_scripts/exa_cloud_download        /usr/bin/exa_cloud_download
ln -s /opt/exa_scripts/exa_cloud_upload          /usr/bin/exa_cloud_upload
ln -s /opt/exa_scripts/exa_cloud_download_local  /usr/bin/exa_cloud_download_local

# for Azure only
ln -s /opt/exa_scripts/exa_cloud_replica_path               /usr/bin/exa_cloud_replica_path
ln -s /opt/exa_scripts/exa_cloud_upload_replicated          /usr/bin/exa_cloud_upload_replicated
ln -s /opt/exa_scripts/exa_cloud_download_local_replicated  /usr/bin/exa_cloud_download_local_replicated
# end Azure

mkdir -p /etc/condor/regions
mkdir -p /etc/condor/scripts

# will /dev/shm/cvmfs will be created at condor startup
ln -s /dev/shm/cvmfs /cvmfs

download /etc/condor/passwords.d/POOL
download /etc/condor/scripts/*.config.sh
download /etc/condor/scripts/*.config.sh from <cloud>/

download /etc/condor/regions/*local.config from <cloud>/regions/

download /etc/condor/config.d/*.config
download /etc/condor/config.d/*.config from <cloud>/


# if upgrading remove
# rm /etc/condor/config.d/90_cloud_head.config /etc/condor/config.d/90_cloud_id.config /etc/condor/config.d/95_cloud_domain.config

# Follow instructions in
#   exa_cloud/install.sh


systemctl enable condor
reboot

