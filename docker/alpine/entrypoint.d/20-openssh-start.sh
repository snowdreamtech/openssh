#!/bin/sh
set -e

# Generate a random password for root if not provided
if [ -z "${SSH_ROOT_CRED}" ]; then
    SSH_ROOT_CRED=$(openssl rand -base64 33)
    echo "Generate random ssh root password: ${SSH_ROOT_CRED}"
fi

# Change the password for root
echo "root:$SSH_ROOT_CRED" | chpasswd >/dev/null 2>&1

# Generate host keys if not present
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
  ssh-keygen -A >/dev/null 2>&1
fi

# Generate ssh client keys
if [ ! -d "/root/.ssh" ]; then
  mkdir -p /root/.ssh
  chmod 700 /root/.ssh
  ssh-keygen -t ed25519 -C "user@example.com" -f /root/.ssh/id_ed25519 -q -N ""
  ssh-keygen -t rsa -b 4096 -C "user@example.com" -f /root/.ssh/id_rsa -q -N ""
  ssh-keygen -t ecdsa -b 521 -C "user@example.com" -f /root/.ssh/id_ecdsa -q -N ""
fi

# Generate motd and update it periodically in background
(
    while true; do
        /usr/local/bin/motd.sh >/dev/null 2>&1
        sleep 180
    done
) &
