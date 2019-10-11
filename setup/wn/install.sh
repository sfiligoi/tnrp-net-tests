yum update
reboot

groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor

yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
yum -y install epel-release yum-plugin-priorities
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
# wget https://aka.ms/downloadazcopy-v10-linux && tar -xvzf downloadazcopy-v10-linux && mv azcopy_linux_amd64_10.2.1/azcopy /usr/bin/

download /etc/condor/passwords.d/POOL
download /etc/condor/config.d/*.config
download /etc/condor/scripts/*.config.sh

# AWS
# Download config and stripts from aws subdir

# Azure
# Download config and stripts from azure subdir

# Customize as appropriate
echo "CLOUD_HEAD = <IP>" > /etc/condor/config.d/90_cloud_head.config
echo -e 'CLOUD_Provider = "AWS/Azure/Google"\nCLOUD_Region = "AWSUSEast1"\nGEO_Region ="USEast"' > /etc/condor/config.d/90_cloud_id.config
echo "DEFAULT_DOMAIN_NAME = us-west-2.azure" > /etc/condor/config.d/95_cloud_domain.config

# Azure: Edit file, add to After and Requires
#vi /usr/lib/systemd/system/condor.service
#
#[Unit]
#Description=Condor Distributed High-Throughput-Computing
#After=network-online.target sshd.service waagent.service nslcd.service ypbind.service time-sync.target nfs.client.target autofs.service
#Wants=network-online.target
#Requires=sshd.service waagent.service

# Follow instructions in
#   exa_cloud/install.sh


systemctl enable condor
reboot

