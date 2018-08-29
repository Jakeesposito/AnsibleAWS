#!/bin/bash

#Text Color Variables
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;36m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Deploying VM for Ansible Control Machine
echo Deploying VM for Ansible Control Machine...
echo TEST ${sg_id}
echo TEST ${m_subnet_id}
ans_instance_id=$(aws ec2 run-instances --image-id ami-5e8bb23b --count 1 --instance-type t2.micro --security-group-ids ${sg_id} --key-name AWSPrivateKey --subnet-id ${m_subnet_id} --associate-public-ip-address | jq '.Instances' | jq .[] | jq '.InstanceId' | tr -d '"')
aws ec2 create-tags --resources "$ans_instance_id" --tags Key=Name,Value=Ansible_ControlMachine
echo ${cyn}EC2 Instance ${grn}Ansible_ControlMachine${cyn} Created
printf "\n"
echo ${mag}Waiting for Public DNS...
ans_dns=$(aws ec2 describe-instances --instance-ids ${ans_instance_id} | jq .[] | jq .[] | jq '.Instances' | jq .[] | jq '.PublicDnsName' | tr -d '"')
echo Ansible Control Machine can be Accessed via ssh at 
printf "\n"
echo ${mag}${ans_dns}${cyn}

#Update Ubuntu & Install Ansible PPA
#echo ${mag}Updating Ubuntu Distribution...${end}
#sudo apt-get update > /dev/null 2>&1
#echo ${mag}Updating Ubuntu Distribution...${grn}[COMPLETE]${end}
#echo ${mag}Installing Required Dependencies...${end}
#sudo apt-get install software-properties-common > /dev/null 2>&1
#echo ${mag}Installing Required Dependencies...${grn}[COMPLETE]${end}
#echo ${mag}Adding Ansible Repository...${end}
#echo | sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1
#echo | sudo apt-get-update > /dev/null 2>&1
#echo ${mag}Adding Ansible Repository...${grn}[COMPLETE]${end}
#echo ${mag}Updating Ansible Repository...${end}
#sudo apt-get update > /dev/null 2>&1
#echo ${mag}Updating Ansible Repository...${grn}[COMPLETE]${end}
#echo ${mag}Installing Ansible...${end}
#sudo apt-get install ansible > /dev/null 2>&1
#echo ${mag}Installing Ansible...${grn}[COMPLETE]${end}
#echo ${mag}Finalizing...
#echo .${end}
#sudo apt-get update > /dev/null 2>&1
#echo ${grn}[COMPLETE]${end}
#sleep 1

