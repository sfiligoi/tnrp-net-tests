FROM centos:centos7

RUN yum update -y

RUN groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor

RUN yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
RUN yum -y install epel-release yum-plugin-priorities
RUN yum install -y condor
RUN yum install -y osg-wn-client aria2 openssh-clients
RUN yum -y install supervisor

RUN yum clean all

RUN groupadd -g 3000 cuser && useradd -u 3000 -g 3000 -s /bin/bash cuser


ADD condor_config.d/* /etc/condor/config.d/

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisord.conf
ADD supervisord.d/condor.conf /etc/supervisord.d/condor.conf

CMD ["/usr/bin/supervisord" ,"-c" ,"/etc/supervisord.conf"]
