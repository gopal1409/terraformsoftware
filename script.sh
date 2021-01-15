#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install nginx
yum update -y
yum install  install -y httpd

# make sure nginx is started
service httpd start
