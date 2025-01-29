#!/bin/bash

mkdir -p /app/tester1

cat <<EOF > /app/tester1/tester1.yml
sample:
  app: tester1
  version: 1.0.0
  description: This is a sample app
EOF

cat <<EOF > /app/tester1/README.md
# tester1

## Some random markdown content

This is a sample app
EOF
