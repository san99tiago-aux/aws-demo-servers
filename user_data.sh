#!/bin/bash

# Enable extra logging
set -x

# Refresh environment variables
source /etc/profile

# Update OS and install Java
echo "----- Updating OS -----"
sudo yum update -y

# Install and Initialize SSM Agent
echo "----- Initializing SSM Agent -----"
sudo yum install -y https://s3.region.amazonaws.com/amazon-ssm-region/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

# Install Instance Connect
echo "----- Initializing EC2 Instance Connect Agent -----"
sudo yum install -y ec2-instance-connect

# Install Amazon CloudWatch Agent
echo "----- Initializing CloudWatch Agent -----"
sudo yum install -y amazon-cloudwatch-agent

# Install git
yum install -y git

# Create the necessary folders and permissions
mkdir /home/app
sudo chmod 775 /home/app

# Clone the CTFd source code
cd /home/app/
git clone https://github.com/san99tiago-aux/aws-demo-servers
cd aws-demo-servers

# Run server (demo)
bash run_public_server.sh
