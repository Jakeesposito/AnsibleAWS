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
