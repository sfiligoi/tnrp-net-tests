FROM centos:centos7

RUN groupadd -g 2000 gridftp && useradd -u 2000 -g 2000 -s /bin/bash gridftp

RUN yum -y install https://repo.opensciencegrid.org/osg/3.4/osg-3.4-el7-release-latest.rpm && \
    yum -y install epel-release \
                   yum-plugin-priorities && \
    yum -y install  osg-gridftp \
                    osg-wn-client \
                   redhat-lsb-core && \
    yum -y install supervisor


RUN yum clean all

ADD gridftp.conf /etc/gridftp.conf

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisord.conf
ADD supervisord.d/gridftp.conf /etc/supervisord.d/gridftp.conf

CMD ["/usr/bin/supervisord" ,"-c" ,"/etc/supervisord.conf"]
