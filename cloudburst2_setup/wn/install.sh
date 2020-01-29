# Optional
# yum update
# reboot
#

# Azure needs LIS installed
wget https://aka.ms/lis
tar xvzf lis
cd LISISO
./install.sh
reboot
# end azure

# check if nouveau enabled (e.g. on AWS)
lsmod | grep nouveau

#disable nuveou, if it was enabled
cat >/etc/modprobe.d/blacklist-nouveau.conf << EOF
blacklist nouveau
options nouveau modeset=0
EOF

# use only in extreme cases
#dracut --force

reboot
# end disable noveou

#disable selinux
vi /etc/selinux/config

groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor

yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities

# get the right kernel rpms in place

yum install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
yum install yum-utils

yum-config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo
yum clean all

yum -y install nvidia-driver-latest-dkms cuda
yum -y install cuda-drivers

reboot


yum -y install clinfo

yum install -y condor
yum install -y osg-wn-client aria2

yum install -y osg-oasis

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
mkdir -p /opt/exa_cloud
mkdir -p /etc/exa_cloud/regions

download /opt/exa_scripts/exa* from exa_cloud/
download /opt/exa_scripts/exa* from exa_cloud/<cloud>/

ln -s /opt/exa_scripts/exa_cloud_mangle          /usr/bin/exa_cloud_mangle
ln -s /opt/exa_scripts/exa_cloud_mangle_download /usr/bin/exa_cloud_mangle_download

ln -s /opt/exa_scripts/exa_cloud_download        /usr/bin/exa_cloud_download
ln -s /opt/exa_scripts/exa_cloud_upload          /usr/bin/exa_cloud_upload
ln -s /opt/exa_scripts/exa_cloud_download_local  /usr/bin/exa_cloud_download_local

mkdir -p /etc/condor/regions
mkdir -p /etc/condor/scripts

download /etc/condor/passwords.d/POOL
download /etc/condor/scripts/*.config.sh
download /etc/condor/scripts/*.config.sh from <cloud>/

download /etc/condor/regions/*local.config from <cloud>/regions/

download /etc/condor/config.d/*.config
download /etc/condor/config.d/*.config from <cloud>/

download /opt/exa_cloud/exa_region_setup.sh from <cloud>/
download /usr/lib/systemd/system/exa-region-setup.service

mkdir -p /usr/lib/systemd/system/autofs.service.wants
mkdir -p /usr/lib/systemd/system/condor.service.wants

ln -s /usr/lib/systemd/system/exa-region-setup.service /usr/lib/systemd/system/autofs.service.wants/exa-region-setup.service
ln -s /usr/lib/systemd/system/exa-region-setup.service /usr/lib/systemd/system/condor.service.wants/exa-region-setup.service
ln -s /usr/lib/systemd/system/autofs.service /usr/lib/systemd/system/condor.service.wants/autofs.service

systemctl daemon-reload

systemctl enable autofs


systemctl enable condor
reboot

