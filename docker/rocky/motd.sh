#!/bin/sh
# Rocky Linux MOTD generator
# Generates /etc/motd at container startup for sshd PrintMotd to display
fastfetch --pipe false > /etc/motd 2>/dev/null || true
