#! /bin/bash

# Color Variables
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Create VPC and Extract VPCID
echo Creating Virtual Private Cloud 10.0.0.0/16...
aws ec2 create-vpc --cidr-block 10.0.0.0/16 > /dev/null
sleep 3
echo Creating Virtual Private Cloud 10.0.0.0/16...${grn}[COMPLETE]${end}
sleep 2
echo Extracting VPC ID...
VPCID=$(aws ec2 describe-vpcs --query 'Vpcs[1].{VPCID:VpcId}' --output text) > /dev/null
sleep 3
echo VPC ${mag}10.0.0.0/16${end} created with VPC ID ${mag}$VPCID${end}

# Create Subnets in VPC
echo Creating VPC Client Subnet...
sleep 3
aws ec2 create-subnet --vpc-id ${VPCID} --cidr-block 10.0.1.0/24 | jq
sleep 3
echo Creating VPC Client Subnet...${grn}[COMPLETE]${end}
sleep 3
echo Creating VPC Server Subnet...
sleep 3
aws ec2 create-subnet --vpc-id ${VPCID} --cidr-block 10.0.2.0/24 | jq
sleep 3
echo Creating VPC Server Subnet...${grn}[COMPLETE]${end}
sleep 3
echo Creating VPC Management Subnet...
sleep 3
aws ec2 create-subnet --vpc-id ${VPCID} --cidr-block 10.0.3.0/24 | jq
sleep 3
echo Creating VPC Management Subnet...${grn}[COMPLETE]${end}
sleep 3
echo .
echo ${mag}Client, Server, and Management Networks Created${end}
echo .
sleep 1
