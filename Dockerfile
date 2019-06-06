FROM centos:centos7
MAINTAINER Steven Leung <stvleung@gmail.com>

RUN /usr/bin/yum install -y epel-release https://centos7.iuscommunity.org/ius-release.rpm && \
    /usr/bin/yum install -y openssh-server git2u && \
    /usr/bin/yum clean all && \
    sed -ri /etc/pam.d/sshd \
        -e 's/(session    required     pam_loginuid.so)/#\1/' && \
    sed -ri /etc/ssh/sshd_config \
        -e 's/^#(AllowAgentForwarding)/\1/' \
        -e 's/^#(AllowTcpForwarding)/\1/' && \
    source /etc/sysconfig/sshd && \
    /usr/sbin/sshd-keygen

ENV UID 1000
ENV GID 1000

COPY entry.sh /usr/local/bin/entry.sh
ENTRYPOINT ["/usr/local/bin/entry.sh"]

CMD ["/usr/sbin/sshd", "-D"]
