#!/bin/bash

rm -f /root/.ssh/known_hosts

ssh-keyscan -H source >> /root/.ssh/known_hosts
