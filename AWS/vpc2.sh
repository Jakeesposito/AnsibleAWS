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
echo VPC ${grn}Demo_VPC${cyn} Created with ID ${grn}$vpc_id${cyn}
sleep 3
printf "\n"

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
printf "\n"

# Create Client Subnet
echo Creating Client Subnet...
sleep 3
c_subnet_id=$(aws ec2 create-subnet --vpc-id ${vpc_id} --cidr-block 10.0.1.0/24 | jq '.Subnet.SubnetId' | tr -d '"')
aws ec2 create-tags --resources "$c_subnet_id" --tags Key=Name,Value=Client_Subnet
echo Client Subnet ${grn}10.0.1.0/24${cyn} Created with ID ${grn}${c_subnet_id}${cyn}
sleep 3
printf "\n"

# Create Server Subnet
echo Creating Server Subnet...
sleep 3
s_subnet_id=$(aws ec2 create-subnet --vpc-id ${vpc_id} --cidr-block 10.0.2.0/24 | jq '.Subnet.SubnetId' | tr -d '"')
aws ec2 create-tags --resources "$s_subnet_id" --tags Key=Name,Value=Server_Subnet
echo Server Subnet ${grn}10.0.2.0/24${cyn} Created with ID ${grn}${s_subnet_id}${cyn}
sleep 3
printf "\n"

# Create Management Subnet
echo Creating Management Subnet...
m_subnet_id=$(aws ec2 create-subnet --vpc-id ${vpc_id} --cidr-block 10.0.3.0/24 | jq '.Subnet.SubnetId' | tr -d '"')
aws ec2 create-tags --resources "$m_subnet_id" --tags Key=Name,Value=Management_Subnet
echo Management Subnet ${grn}10.0.3.0/24${cyn} Created with ID ${grn}${m_subnet_id}${cyn}
sleep 3
printf "\n"

# Create Route Table
echo Creating Route Table...
sleep 3
rt_id=$(aws ec2 create-route-table --vpc-id ${vpc_id} | jq '.RouteTable.RouteTableId' | tr -d '"')
aws ec2 create-tags --resources "$rt_id" --tags Key=Name,Value=Client_RouteTable
echo Attaching Route Table to Client Subnet...
sleep 3
aws ec2 associate-route-table --route-table-id ${rt_id} --subnet-id ${c_subnet_id} > /dev/null
echo Attaching Route Table to Management Subnet...
sleep 3
aws ec2 associate-route-table --route-table-id ${rt_id} --subnet-id ${m_subnet_id} > /dev/null
echo Route Table ${grn}Client_RouteTable${cyn} Created with ID ${grn}${rt_id}${cyn}
echo Route Table ${grn}Client_RouteTable${cyn} Attached to Client & Management Subnets
sleep 3
printf "\n"

# Create Routes
echo Adding Internet Gateway as Default Route for Public Subnet...
aws ec2 create-route --route-table-id ${rt_id} --destination-cidr-block 0.0.0.0/0 --gateway-id ${igw_id} > /dev/null
echo ${complete}
sleep 3
printf "\n"

# Deploying VM for Ansible Control Machine
echo Deploying VM for Ansible Control Machine...
ans_instance_id=$(aws ec2 run-instances --image-id ami-5e8bb23b --count 1 --instance-type t2.micro --key-name AWSPrivateKey --subnet-id ${m_subnet_id} --associate-public-ip-address | jq '.Instances' | jq .[] | jq'.InstanceId' | tr -d '"')
aws ec2 create-tags --resources "$ans_instance_id" --tags Key=Name,Value=Ansible_ControlMachine
echo EC2 Instance ${grn}Ansible_ControlMachine${cyn}
sleep 3
printf "\n"
echo ${end}
