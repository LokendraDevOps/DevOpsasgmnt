#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo su
echo "assignmnet 5 is done" > /var/www/html/index.html
