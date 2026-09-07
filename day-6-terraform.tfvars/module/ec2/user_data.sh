#!/bin/bash
apt update -y
apt install nginx -y
apt start nginx
apt enable nginx
