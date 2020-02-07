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

#
# Client tools
#

yum install -y python2-pip && pip install awscli

# Update YUM with Cloud SDK repo information:
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

# The indentation for the 2nd line of gpgkey is important.

# Install the Cloud SDK
sudo yum install google-cloud-sdk

