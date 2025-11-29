FROM snowdreamtech/debian:13.1.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="OpenSSH Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for OpenSSH on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/openssh" \
    org.opencontainers.image.base.name="snowdreamtech/openssh:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/openssh" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="9.2" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/openssh"

# Switch to the user
USER root

# Set the workdir
WORKDIR /root

# keep the docker container running
ARG DEBIAN_FRONTEND=noninteractive \
    KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=0 \
    # Ensure the container exec commands handle range of utf8 characters based of
    # default locales in base image (https://github.com/docker-library/docs/tree/master/debian#locales)
    LANG=C.UTF-8\
    UMASK=022 \
    DEBUG=false \
    PGID=0 \
    PUID=0  \
    USER=root \
    WORKDIR=/root 

ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND} \
    # keep the docker container running
    KEEPALIVE=${KEEPALIVE} \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    # Ensure the container exec commands handle range of utf8 characters based of
    # default locales in base image (https://github.com/docker-library/docs/tree/master/debian#locales)
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PGID=${PGID} \
    PUID=${PUID}  \
    USER=${USER} \
    WORKDIR=${WORKDIR} 

ENV OPENSSH_VERSION=1:9.2p1-2+deb12u5 \
    SSH_ROOT_PASSWORD=

# Create a user with PUID and PGID
RUN if [ "${USER}" != "root" ] && [ ! -d "/home/${USER}" ] && [ "${PUID}" -ne 0 ] && [ "${PGID}" -ne 0 ]; then \
    addgroup --gid ${PGID} ${USER}; \
    adduser --home /home/${USER} --uid ${PUID} --gid ${PGID} --gecos ${USER} --shell /bin/bash --disabled-password ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi
    
RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install --no-install-recommends \ 
    fastfetch \
    xauth \
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
    && sed -i -E "s/#?AllowAgentForwarding.*/AllowAgentForwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?AllowTcpForwarding.*/AllowTcpForwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?AllowTcpForwarding.*/AllowTcpForwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?GatewayPorts.*/GatewayPorts yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?X11Forwarding.*/X11Forwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?X11DisplayOffset.*/X11DisplayOffset 10/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?X11UseLocalhost.*/X11UseLocalhost yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?PermitTTY.*/PermitTTY yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?PrintMotd.*/PrintMotd no/g" /etc/ssh/sshd_config \ 
    && sed -i -E "s/#?PrintLastLog.*/PrintLastLog yes/g" /etc/ssh/sshd_config \
    && echo '#!/bin/sh' | tee /etc/update-motd.d/20-fastfetch \
    && echo 'fastfetch --pipe false' | tee -a /etc/update-motd.d/20-fastfetch \
    && chmod +x /etc/update-motd.d/20-fastfetch \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Enable CAP_NET_BIND_SERVICE
# RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
#     # setcap 'cap_net_bind_service=+ep' `which nginx`; \
#     fi

EXPOSE 22

COPY entrypoint.d /usr/local/bin/entrypoint.d

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.d/*

ENTRYPOINT ["docker-entrypoint.sh"]