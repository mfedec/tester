#!/bin/bash

cd /tester && gem build tester.gemspec -o /tmp/tester.gem && gem install /tmp/tester.gem

mkdir -p /app

rm -f /root/.ssh/known_hosts

ssh-keyscan -H source >> /root/.ssh/known_hosts
