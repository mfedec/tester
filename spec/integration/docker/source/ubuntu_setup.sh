#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
apt -y update

# Install and configure sshd
apt-get -y install openssh-server
{
  echo "Port 22"
  echo "PasswordAuthentication yes"
  echo "ChallengeResponseAuthentication no"
} >> /etc/ssh/sshd_config

mkdir /var/run/sshd
chmod 0755 /var/run/sshd
