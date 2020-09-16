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

# if not already present
useradd centos

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

# Azure: Edit file, add to After and Requires
#vi /usr/lib/systemd/system/condor.service
#
#[Unit]
#Description=Condor Distributed High-Throughput-Computing
#After=network-online.target sshd.service waagent.service nslcd.service ypbind.service time-sync.target nfs.client.target autofs.service
#Wants=network-online.target
#Requires=sshd.service waagent.service

download /usr/lib/systemd/system/cvmfs-region-setup.service from <cloud>/

mkdir -p /usr/lib/systemd/system/autofs.service.wants
mkdir -p /usr/lib/systemd/system/condor.service.wants

ln -s /usr/lib/systemd/system/cvmfs-region-setup.service /usr/lib/systemd/system/autofs.service.wants/cvmfs-region-setup.service
ln -s /usr/lib/systemd/system/cvmfs-region-setup.service /usr/lib/systemd/system/condor.service.wants/cvmfs-region-setup.service
ln -s /usr/lib/systemd/system/autofs.service /usr/lib/systemd/system/condor.service.wants/autofs.service


mkdir -p /etc/condor/regions
mkdir -p /etc/condor/scripts

download /etc/condor/passwords.d/POOL
download /etc/condor/scripts/*.sh
download /etc/condor/scripts/*.sh from <cloud>/

download /etc/condor/regions/*.config from <cloud>/regions/

download /etc/condor/config.d/*.config
download /etc/condor/config.d/*.config from <cloud>/


systemctl daemon-reload

systemctl enable autofs

systemctl enable condor

# if enabled in the Cloud image
systemctl disable firewalld

reboot

