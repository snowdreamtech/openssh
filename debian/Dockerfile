FROM snowdreamtech/debian:12.7.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="OpenSSH Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for OpenSSH on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/openssh" \
    org.opencontainers.image.base.name="snowdreamtech/openssh:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/openssh" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="12.7" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/openssh"

# keep the docker container running
ENV KEEPALIVE=1 \
    OPENSSH_VERSION=1:9.8p1-8 \
    SSH_ROOT_PASSWORD=

RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install --no-install-recommends \ 
    -t trixie \
    fastfetch \
    openssh-server=${OPENSSH_VERSION} \ 
    openssh-sftp-server=${OPENSSH_VERSION} \ 
    openssh-client=${OPENSSH_VERSION} \
    && mkdir -p /run/sshd \ 
    && sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#PermitEmptyPasswords/PermitEmptyPasswords/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#HostKey/HostKey/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#PubkeyAuthentication/PubkeyAuthentication/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#IgnoreRhosts/IgnoreRhosts/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#StrictModes/StrictModes/g" /etc/ssh/sshd_config \ 
    && sed -i "s/#MaxAuthTries.*/MaxAuthTries 7/g" /etc/ssh/sshd_config \ 
    && sed -i "s/#MaxSessions.*/MaxSessions 10/g" /etc/ssh/sshd_config \ 
    && sed -i "s/#ClientAliveInterval.*/ClientAliveInterval 900/g" /etc/ssh/sshd_config \ 
    && sed -i "s/#ClientAliveCountMax.*/ClientAliveCountMax 0/g" /etc/ssh/sshd_config \ 
    && sed -i "s/Subsystem.*/Subsystem\tsftp\tinternal-sftp/g" /etc/ssh/sshd_config \    
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]