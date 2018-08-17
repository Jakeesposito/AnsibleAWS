#! /bin/bash

# Environment Variables
# - colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
# - Complete
complete=$(echo ${grn}[--COMPLETE--]${mag})


# Create VPC
echo ${cyn}
echo Creating VPC...
sleep 3
vpc_info=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --output json)
vpc_id=$(echo $vpc_info | jq '.Vpc.VpcId' | tr -d '"')
aws ec2 create-tags --resources "$vpc_id" --tags Key=Name,Value=Demo_VPC
aws ec2 modify-vpc-attribute --vpc-id "$vpc_id" --enable-dns-support "{\"Value\":true}"
aws ec2 modify-vpc-attribute --vpc-id "$vpc_id" --enable-dns-hostnames "{\"Value\":true}"
echo VPC ${grn}Demo_VPC${mag} Created with ID ${grn}$vpc_id${cyn}
sleep 3 

# Create & Attach Internet Gateway
echo Creating Internet Gateway...
sleep 3
igw_id=$(aws ec2 create-internet-gateway | jq '.InternetGateway.InternetGatewayId' | tr -d '"')
aws ec2 create-tags --resources "$igw_id" --tags Key=Name,Value=Demo_IGW
echo Internet Gateway ${grn}Demo_IGW${cyn} Created with ID ${grn}$igw_id${cyn}
sleep 3
aws ec2 attach-internet-gateway --internet-gateway-id ${igw_id} --vpc-id ${vpc_id} --region us-east-2 > /dev/null
echo Internet Gateway ${grn}Demo_IGW${cyn} Attached to VPC ${grn}Demo_VPC${cyn}
sleep 3

# Create Client Subnet
echo Creating Client Subnet...
sleep 3
c_subnet=$(aws ec2 create-subnet --vpc-id ${vpc_id} --cidr-block 10.0.1.0/24 | jq '.Subnet.SubnetId' | -d '"')
echo Client Subnet ${grn}10.0.1.0/24${cyn} Created with ID ${grn}$c_subnet${cyn}
sleep 3
printf "\n"
echo Creating Server Subnet...
sleep 3
s_subnet=$(aws ec2 create-subnet --vpc-id ${vpc_id} --cidr-block 10.0.2.0/24 | jq '.Subnet.SubnetId' | -d '"')
echo Server Subnet ${grn}10.0.2.0/24${cyn} Created with ID ${grn}${s_subnet}${cyn}
sleep 3
printf "\n"
echo Creating Management Subnet...
m_subnet=$(aws ec2 create-subnet --vpc-id ${vpc_id} --cidr-block 10.0.2.0/24 | jq '.Subnet.SubnetId' | -d '"')
echo Management Subnet ${grn}10.0.3.0/24${cyn} Created with ID ${grn}${m_subnet}${cyn}
sleep 3
printf "\n"
