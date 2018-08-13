#! /bin/bash

# Color Variables
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Create VPC and Extract VPCID
echo ${blu}Creating Virtual Private Cloud 10.0.0.0/16...${end}
aws ec2 create-vpc --cidr-block 10.0.0.0/16 > /dev/null
sleep 3
echo ${blu}Creating Virtual Private Cloud 10.0.0.0/16...${end}${grn}[COMPLETE]${end}
sleep 2
echo ${blu}Extracting VPC ID...${end}
VPCID=$(aws ec2 describe-vpcs --query 'Vpcs[1].{VPCID:VpcId}' --output text) > /dev/null
sleep 3
echo ${blu}VPC ${mag}10.0.0.0/16${end} ${blu}created with VPC ID ${mag}$VPCID${end}

# Create Subnets in VPC
echo ${blu}Creating VPC Client Subnet...${end}
sleep 3
aws ec2 create-subnet --vpc-id ${VPCID} --cidr-block 10.0.1.0/24 | jq
sleep 3
echo ${blu}Creating VPC Client Subnet...${grn}[COMPLETE]${end}
sleep 3
echo ${blu}Creating VPC Server Subnet...${end}
sleep 3
aws ec2 create-subnet --vpc-id ${VPCID} --cidr-block 10.0.2.0/24 | jq
sleep 3
echo ${blu}Creating VPC Server Subnet...${grn}[COMPLETE]${end}
sleep 3
echo ${blu}Creating VPC Management Subnet...${end}
sleep 3
aws ec2 create-subnet --vpc-id ${VPCID} --cidr-block 10.0.3.0/24 | jq
sleep 3
echo ${blu}Creating VPC Management Subnet...${grn}[COMPLETE]${end}
sleep 3
echo ${mag}.${end}
echo ${mag}Client, Server, and Management Networks Created${end}
echo ${mag}.${end}
sleep 1
