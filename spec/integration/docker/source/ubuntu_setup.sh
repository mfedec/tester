#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
apt -y update

# Create `tester` user that can sudo without a password
apt-get -y install sudo
adduser --disabled-password tester < /dev/null
echo "tester:topsecret" | chpasswd
echo "tester ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

mkdir /home/tester/.ssh && ln -s /shared/ssh/id_rsa.pub /home/tester/.ssh/authorized_keys
chown -R tester: /home/tester/.ssh

# Install and configure sshd
apt-get -y install openssh-server
{
  echo "Port 22"
  echo "PasswordAuthentication yes"
  echo "ChallengeResponseAuthentication no"
} >> /etc/ssh/sshd_config

mkdir /var/run/sshd
chmod 0755 /var/run/sshd
