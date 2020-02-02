FROM nvidia/cuda:10.0-runtime-centos7

# Needed to get the recently deprecated libcudart.so symlink in place
RUN yum -y install cuda-cudart-dev-10-0

# OSG RPMs

RUN groupadd -g 1000 centos && useradd -u 1000 -g 1000 -s /usr/bin/bash centos
RUN groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor

RUN yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
RUN yum -y install epel-release yum-plugin-priorities

# Enable OpenCL
# As suggested by https://github.com/WIPACrepo/pyglidein/blob/master/Dockerfile
RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

RUN yum -y install clinfo

# Condor does not pick up the system libraries
ADD docker/cudalib.sh /etc/profile.d/


RUN yum install -y condor
RUN yum install -y osg-wn-client aria2 

# client tool to access PRP S3
RUN yum install -y s3cmd

# icecube dependencies
RUN yum -y groupinstall "Compatibility Libraries" "Development Tools" "Scientific Support"
RUN yum install -y freetype

RUN yum -y install supervisor

RUN yum clean all


# Add IceCube cvmfs from tarball
RUN cd / && wget https://s3.nautilus.optiputer.net/isfiligoi/exa-us-west/setup/cvmfs.tar.gz && tar -xzf cvmfs.tar.gz && rm -f cvmfs.tar.gz


#
# Configure condor
#

RUN mkdir -p /opt/exa_scripts
RUN mkdir -p /opt/exa_cloud
RUN mkdir -p /etc/exa_cloud/regions

ADD prp/regions/*_storage.conf /etc/exa_cloud/regions/

RUN echo "prp" > /etc/exa_cloud/region.config
RUN chmod a+r /etc/exa_cloud/region.config

ADD exa_cloud/exa_* /opt/exa_scripts/
ADD exa_cloud/prp/exa_* /opt/exa_scripts/


RUN ln -s /opt/exa_scripts/exa_cloud_mangle          /usr/bin/exa_cloud_mangle && \
    ln -s /opt/exa_scripts/exa_cloud_mangle_download /usr/bin/exa_cloud_mangle_download && \
    ln -s /opt/exa_scripts/exa_cloud_download        /usr/bin/exa_cloud_download && \
    ln -s /opt/exa_scripts/exa_cloud_upload          /usr/bin/exa_cloud_upload && \
    ln -s /opt/exa_scripts/exa_cloud_download_local  /usr/bin/exa_cloud_download_local

RUN mkdir -p /etc/condor/regions
RUN mkdir -p /etc/condor/scripts

#will need at runtime /etc/condor/passwords.d/POOL
ADD *.config.sh /etc/condor/scripts/
ADD prp/*.config.sh /etc/condor/scripts/
ADD validate_cvmfs.sh /etc/condor/scripts/

ADD prp/regions/*_local.config /etc/condor/regions/

ADD *.config /etc/condor/config.d/
ADD prp/*.config /etc/condor/config.d/


#
#Supervisor section that replaces systemd
#

ADD docker/supervisord.conf /etc/

RUN mkdir -p /var/log/supervisor 

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

