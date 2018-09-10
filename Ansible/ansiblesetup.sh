#!/bin/bash

#Text Color Variables
red=$'\e[1;31m'
grn=$'\e[1;32m'
grn2=$'\e[1;93m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Install AWS CLI, jq,
sudo apt-get update > /dev/null
echo ${mag}Installing Amazon Web Services CLI...${end}
sudo apt-get -y install awscli > /dev/null
echo ${grn}[COMPLETE]${end}
echo ${mag}Installing jq...${end}
sudo apt-get -y install jq > /dev/null
echo ${grn}[COMPLETE]${end}

# Install Azure CLI
AZ_REPO=$(lsb_release -cs)
echo ${mag}Installing Azure CLI 2.0...${end}
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list > /dev/null 2>&1
curl -L -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - > /dev/null 2>&1
sudo apt-get install apt-transport-https > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install azure-cli > /dev/null
echo ${grn}[COMPLETE]${end}

# Deploying VM for Ansible Control Machine
echo ${mag}Deploying VM for Ansible Control Machine...

ans_instance_id=$(aws ec2 run-instances --image-id ami-5e8bb23b --count 1 --instance-type t2.micro --security-group-ids ${sg_id} --key-name AWSPrivateKey --subnet-id ${m_subnet_id} --associate-public-ip-address | jq '.Instances' | jq .[] | jq '.InstanceId' | tr -d '"')
aws ec2 create-tags --resources "$ans_instance_id" --tags Key=Name,Value=Ansible_ControlMachine
echo ${cyn}EC2 Instance ${grn}Ansible_ControlMachine${cyn} Created
printf "\n"
echo ${mag}Waiting for Public DNS...
ans_dns=$(aws ec2 describe-instances --instance-ids ${ans_instance_id} | jq .[] | jq .[] | jq '.Instances' | jq .[] | jq '.PublicDnsName' | tr -d '"')
echo ${grn}[COMPLETE]${mag}
printf "\n"
printf "\n"
echo ${mag}Ansible Control Machine can be Accessed via ssh at 
printf "\n"
echo ${grn2}${ans_dns}${mag}
printf "\n"
printf "\n"
echo ${grn}[SCRIPT COMPLETE]${end}
printf "\n"
printf "\n"
