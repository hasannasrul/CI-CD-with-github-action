#!/bin/bash
sudo apt-get update
sudo apt-get install docker.io -y
sudo systemctl start docker && sudo systemctl enable docker
sudo usermod -aG docker ubuntu
