#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker ec2-user

# Run Server
docker run -d -p 25565:25565 --name mc itzg/minecraft-server

