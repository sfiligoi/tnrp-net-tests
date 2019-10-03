FROM centos:centos7

RUN yum update -y

RUN groupadd -g 2000 condor && useradd -u 2000 -g 2000 -s /sbin/nologin condor
RUN groupadd -g 3000 cuser && useradd -u 3000 -g 3000 -s /sbin/nologin cuser
RUN for n in 1 2 3 4 5 6 7 8 9; do useradd -u 300${n} -g 3000 -s /sbin/nologin cuser${n}; done
RUN for n in 0 1 2 3 4 5 6 7 8 9; do useradd -u 301${n} -g 3000 -s /sbin/nologin cuser1${n}; done

RUN yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm
RUN yum -y install epel-release yum-plugin-priorities
RUN yum install -y condor
RUN yum install -y osg-wn-client aria2
RUN yum -y install supervisor

RUN yum clean all

ADD condor_config.d/* /etc/condor/config.d/

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisord.conf
ADD supervisord.d/condor.conf /etc/supervisord.d/condor.conf

CMD ["/usr/bin/supervisord" ,"-c" ,"/etc/supervisord.conf"]
