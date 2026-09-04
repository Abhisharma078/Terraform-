#!/bin/bash
apt update -y
apt upgrade-y
apt install nginx -y
systemctl start nginx
systemctl enable ginx

