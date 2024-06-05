#!/bin/sh
set -e


if [ ! -f "ssh_host_rsa_key" ];then
  ssh-keygen -A
fi

# fastfetch from https://github.com/fastfetch-cli/fastfetch
fastfetch --pipe false > /etc/motd 2>&1

# change the password for root
echo "root:$SSH_ROOT_PASSWORD" | chpasswd > /dev/null 2>&1

# start sshd
/usr/sbin/sshd -D

# wait
wait