#! /bin/bash

# Color Variables
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Create VPC and Extract VPCID
echo ${mag}Creating Virtual Private Cloud 10.0.0.0/16...${end}
sleep 5
aws ec2 create-vpc --cidr-block 10.0.0.0/16 > /dev/null
echo ${grn}[COMPLETE]${end}
sleep 2
echo ${mag}Extracting VPC ID...${end}
sleep 10
VPCID=$(aws ec2 describe-vpcs --query 'Vpcs[1].{VPCID:VpcId}' --output text) > /dev/null
echo ${mag}VPC ${red}10.0.0.0/16${end} ${mag}created with VPC ID ${red}$VPCID${end}
sleep 2

# Create & Attach Internet Gateway
sleep 3
echo ${mag}Creating Internet Gateway...${end}
sleep 1
aws ec2 create-internet-gateway | jq
sleep 3
IGWID=$(aws ec2 describe-internet-gateways --query 'InternetGateways[1].{IGWID:InternetGatewayId}' --output text) > /dev/null
echo ${grn}[COMPLETE]${end}
sleep 3
echo ${mag}Attaching Internet Gateway ${red}$IGWID${mag} to VPC ${red}$VPCID${mag}...
aws ec2 attach-internet-gateway --internet-gateway-id ${IGWID} --vpc-id ${VPCID} --region us-east-2 > /dev/null
sleep 3
echo ${mag}Attaching Internet Gateway ${red}$IGWID${mag} to VPC ${red}$VPCID{mag}
echo ${grn}[COMPLETE]${end}
sleep 3

# Create Subnets in VPC
echo ${mag}Creating VPC Client Subnet...${end}
sleep 3
aws ec2 create-subnet --vpc-id ${VPCID} --cidr-block 10.0.1.0/24 | jq
sleep 3
echo ${grn}[COMPLETE]${end}
sleep 3
echo ${mag}Creating VPC Server Subnet...${end}
sleep 3
aws ec2 create-subnet --vpc-id ${VPCID} --cidr-block 10.0.2.0/24 | jq
sleep 3
echo ${grn}[COMPLETE]${end}
sleep 3
echo ${mag}Creating VPC Management Subnet...${end}
sleep 3
aws ec2 create-subnet --vpc-id ${VPCID} --cidr-block 10.0.3.0/24 | jq
sleep 3
echo ${grn}[COMPLETE]${end}
sleep 3

# Create Route Table
echo ${mag}Creating a Custom Route Table...${end}
aws ec2 create-route-table --vpc-id ${VPCID} | jq
sleep 5
RTID=$(aws ec2 describe-route-tables --query 'RouteTables[2].{RTID:RouteTableId}' --output text)
echo ${mag}Creating a Custom Route Table...${grn}[COMPLETE]${end}
sleep 1
echo ${mag}Route Table ID = ${red}$RTID${end}
sleep 3

# Attach Subnets to Route Tables
# aws ec2 associate-route-table --route-table-id ${RTID} --subnet-id ??



# Script Completion
echo ${mag}...........................................................${end}
echo ${mag}...........................................................${end}
echo ${mag}.....${grn}Client, Server, and Management Networks Created${mag}.......${end}
echo ${mag}...........................................................${end}
echo ${mag}...........................................................${end}
sleep 1
