# Optional
# yum update
# reboot
#

# check if nouveau enabled (e.g. on AWS)
lsmod | grep nouveau

#disable nuveou, if it was enabled
cat >/etc/modprobe.d/blacklist-nouveau.conf << EOF
blacklist nouveau
options nouveau modeset=0
EOF

reboot
# end disable noveou

#disable selinux
vi /etc/selinux/config

groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor

# if not already present
groupadd -g 3001 osg && useradd -u 3001 -g 3001 -s /usr/bin/bash osg
groupadd -g 3002 icecube && useradd -u 3002 -g 3002 -s /usr/bin/bash icecube

# if needed
yum -y update

yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities

# get the right kernel rpms in place

yum install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
yum install -y gcc-c++
yum install yum-utils

yum-config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo
yum clean all

yum -y install nvidia-driver-latest-dkms cuda
yum -y install cuda-drivers

reboot


yum -y install clinfo

yum install -y condor
yum install -y osg-wn-client

yum install -y osg-oasis
echo "/cvmfs /etc/auto.cvmfs"> /etc/auto.master.d/cvmfs.autofs

yum install -y singularity

# Azure: Edit file, add to After and Requires
#vi /usr/lib/systemd/system/condor.service
#
#[Unit]
#Description=Condor Distributed High-Throughput-Computing
#After=network-online.target sshd.service waagent.service nslcd.service ypbind.service time-sync.target nfs.client.target autofs.service
#Wants=network-online.target
#Requires=sshd.service waagent.service

systemctl daemon-reload


download /etc/condor/passwords.d/POOL

download /etc/condor/config.d/*.config

download /etc/cvmfs/default.local

echo "CONDOR_HOST = 34.94.222.156" > /etc/condor/config.d/90_head_address.config

echo 'CLOUD_PROVIDER = "AWS/GCP/AZURE"' > /etc/condor/config.d/80_provider.config
echo "STARTD_EXPRS = \$(STARTD_EXPRS) CLOUD_PROVIDER" >> /etc/condor/config.d/80_provider.config

# on AWS all T4 VMs some with NVMe scratch, but must be mounted
chown root:root mount_scratch.s*
mv mount_scratch.sh /usr/sbin/
mv mount_scratch.service /usr/lib/systemd/system/
systemctl daemon-reload
systemctl enable mount_scratch
rmdir /var/lib/condor/execute 
ln -s /scratch/execute /var/lib/condor/execute 
rm -fr /var/lib/cvmfs
ln -s /scratch/cvmfs_cache /var/lib/cvmfs
# end AWS

# on Azure all T4 VMs some with NVMe scratch, but must be mounted
chown root:root mount_scratch.s*
mv mount_scratch.sh /usr/sbin/
mv mount_scratch.service /usr/lib/systemd/system/
systemctl daemon-reload
systemctl enable mount_scratch
rmdir /var/lib/condor/execute
ln -s /mnt/resource/execute /var/lib/condor/execute
rm -fr /var/lib/cvmfs
ln -s /mnt/resource/cvmfs_cache /var/lib/cvmfs
# end Azure


systemctl enable fetch-crl-boot
systemctl enable fetch-crl-cron
systemctl enable autofs

systemctl enable condor

# if enabled in the Cloud image
systemctl disable firewalld

reboot

