#!/bin/bash
sudo apt-get update -y
sudo apt-get install openjdk-17-jre -y
sudo apt-get install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
