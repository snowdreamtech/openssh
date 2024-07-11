#!/bin/sh
set -e

# ssh-keygen -A
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ];then
  ssh-keygen -A > /dev/null 2>&1
fi

# fastfetch from https://github.com/fastfetch-cli/fastfetch
fastfetch --pipe false > /etc/motd 2>&1

# change the password for root
echo "root:$SSH_ROOT_PASSWORD" | chpasswd > /dev/null 2>&1

# generate ssh keys
if [ ! -d "/root/.ssh" ];then
  ssh-keygen -t ed25519 -C "user@example.com" -f $HOME/.ssh/id_ed25519 -q -N ""
  ssh-keygen -t rsa -b 4096 -C "user@example.com" -f $HOME/.ssh/id_rsa -q -N ""
  ssh-keygen -t ecdsa -b 521 -C "user@example.com" -f $HOME/.ssh/id_ecdsa -q -N ""
  ssh-keygen -t dsa  -C "user@example.com" -f $HOME/.ssh/id_dsa -q -N ""
fi

# start sshd
/usr/sbin/sshd -D

# exec commands
exec "$@"