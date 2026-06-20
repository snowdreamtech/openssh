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

