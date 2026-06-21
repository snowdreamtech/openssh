# Base Image (Rocky Variant)
# Extends snowdreamtech/rocky with additional tooling and configuration.

FROM snowdreamtech/rocky:10.2.0

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    KEEPALIVE=0 \
    CAP_NET_BIND_SERVICE=0 \
    LANG=C.UTF-8 \
    UMASK=022 \
    DEBUG=false \
    PASSWORDLESS_SUDO=false \
    PGID=0 \
    PUID=0 \
    USER=root \
    WORKDIR=/root \
    OPENSSH_VERSION=9.9p1-23.el10_2.rocky.0.1

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="OpenSSH Image Based On Rocky" \
    org.opencontainers.image.description="Docker Images for OpenSSH on Rocky. (amd64, arm64, ppc64le, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/openssh" \
    org.opencontainers.image.base.name="snowdreamtech/rocky:10.2.0" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/openssh" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/openssh"

# x-release-please-start-version
LABEL org.opencontainers.image.version="${VERSION:-9.9.1}"
# x-release-please-end

# Runtime Environment Configuration
ENV KEEPALIVE=${KEEPALIVE} \
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PASSWORDLESS_SUDO=${PASSWORDLESS_SUDO} \
    PGID=${PGID} \
    PUID=${PUID} \
    USER=${USER} \
    WORKDIR=${WORKDIR} \
    OPENSSH_VERSION=${OPENSSH_VERSION}

# Additional tooling and configuration for Base image
RUN set -eux \
    && dnf -y --allowerasing update \
    && dnf -y --allowerasing install epel-release \
    && dnf -y --allowerasing install \
    fastfetch \
    xauth \
    openssh-server=${OPENSSH_VERSION} \
    openssh-clients=${OPENSSH_VERSION} \
    && ssh-keygen -A \
    && sed -i -E "s/^[# \t]*PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*(PasswordAuthentication.*)/\1/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*(PermitEmptyPasswords.*)/\1/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*(HostKey.*)/\1/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*(PubkeyAuthentication.*)/\1/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*(IgnoreRhosts.*)/\1/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*(StrictModes.*)/\1/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*MaxAuthTries.*/MaxAuthTries 7/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*MaxSessions.*/MaxSessions 10/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*ClientAliveInterval.*/ClientAliveInterval 900/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*ClientAliveCountMax.*/ClientAliveCountMax 0/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*Subsystem.*/Subsystem\tsftp\tinternal-sftp/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*AllowAgentForwarding.*/AllowAgentForwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*AllowTcpForwarding.*/AllowTcpForwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*GatewayPorts.*/GatewayPorts yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*X11Forwarding.*/X11Forwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*X11DisplayOffset.*/X11DisplayOffset 10/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*X11UseLocalhost.*/X11UseLocalhost yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*PermitTTY.*/PermitTTY yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/^[# \t]*PrintMotd.*/PrintMotd yes/g" /etc/ssh/sshd_config \
    && dnf -y --allowerasing autoremove \
    && dnf -y --allowerasing clean all \
    && rm -rf /var/cache/dnf \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Container Orchestration Files
COPY motd.sh /usr/local/bin/motd.sh
COPY entrypoint.d /usr/local/bin/entrypoint.d

RUN chmod +x /usr/local/bin/motd.sh \
    && chmod +x /usr/local/bin/entrypoint.d/*

# Standard Healthcheck (Verification of core system responsiveness)
HEALTHCHECK NONE

# Process Execution
EXPOSE 22
USER root
WORKDIR /root
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
