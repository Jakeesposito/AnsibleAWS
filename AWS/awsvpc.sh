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
complete=$(echo ${grn}[COMPLETE]${mag})

# Create VPC
echo ${mag}
echo Creating VPC...
vpc_info=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --output json)
vpc_id=$(echo $vpc_info | jq '.Vpc.VpcId' | tr -d '"')
aws ec2 create-tags --resources "$vpc_id" --tags Key=Name,Value=Demo_VPC
aws ec2 modify-vpc-attribute --vpc-id "$vpc_id" --enable-dns-support "{\"Value\":true}"
aws ec2 modify-vpc-attribute --vpc-id "$vpc_id" --enable-dns-hostnames "{\"Value\":true}"
echo ${cyn}VPC ${grn}Demo_VPC${cyn} Created with ID ${grn}$vpc_id${mag}
echo ${complete}
printf "\n"

# Create & Attach Internet Gateway
echo Creating Internet Gateway...
igw_id=$(aws ec2 create-internet-gateway | jq '.InternetGateway.InternetGatewayId' | tr -d '"')
aws ec2 create-tags --resources "$igw_id" --tags Key=Name,Value=Demo_IGW
echo ${cyn}Internet Gateway ${grn}Demo_IGW${cyn} Created with ID ${grn}$igw_id${cyn}
aws ec2 attach-internet-gateway --internet-gateway-id ${igw_id} --vpc-id ${vpc_id} --region us-east-2 > /dev/null
echo Internet Gateway ${grn}Demo_IGW${cyn} Attached to VPC ${grn}Demo_VPC${mag}
echo ${complete}
printf "\n"

# Create Client Subnet
echo Creating Client Subnet...
c_subnet_id=$(aws ec2 create-subnet --vpc-id ${vpc_id} --cidr-block 10.0.1.0/24 | jq '.Subnet.SubnetId' | tr -d '"')
aws ec2 create-tags --resources "$c_subnet_id" --tags Key=Name,Value=Client_Subnet
echo ${cyn}Client Subnet ${grn}10.0.1.0/24${cyn} Created with ID ${grn}${c_subnet_id}${cyn}
echo ${complete}
printf "\n"

# Create Server Subnet
echo ${mag}Creating Server Subnet...
s_subnet_id=$(aws ec2 create-subnet --vpc-id ${vpc_id} --cidr-block 10.0.2.0/24 | jq '.Subnet.SubnetId' | tr -d '"')
aws ec2 create-tags --resources "$s_subnet_id" --tags Key=Name,Value=Server_Subnet
echo ${cyn}Server Subnet ${grn}10.0.2.0/24${cyn} Created with ID ${grn}${s_subnet_id}${mag}
echo ${complete}
printf "\n"

# Create Management Subnet
echo Creating Management Subnet...
m_subnet_id=$(aws ec2 create-subnet --vpc-id ${vpc_id} --cidr-block 10.0.3.0/24 | jq '.Subnet.SubnetId' | tr -d '"')
aws ec2 create-tags --resources "$m_subnet_id" --tags Key=Name,Value=Management_Subnet
echo ${cyn}Management Subnet ${grn}10.0.3.0/24${cyn} Created with ID ${grn}${m_subnet_id}${cyn}
echo ${complete}
printf "\n"

# Create Route Table
echo ${mag}Creating Route Table...
rt_id=$(aws ec2 create-route-table --vpc-id ${vpc_id} | jq '.RouteTable.RouteTableId' | tr -d '"')
aws ec2 create-tags --resources "$rt_id" --tags Key=Name,Value=Client_RouteTable
aws ec2 associate-route-table --route-table-id ${rt_id} --subnet-id ${c_subnet_id} > /dev/null
aws ec2 associate-route-table --route-table-id ${rt_id} --subnet-id ${m_subnet_id} > /dev/null
echo ${cyn}Route Table ${grn}Client_RouteTable${cyn} Created with ID ${grn}${rt_id}${cyn}
echo ${cyn}Route Table ${grn}Client_RouteTable${cyn} Attached to Client and Management Subnets
echo ${complete}
printf "\n"

# Create Routes
echo ${mag}Adding Internet Gateway as Default Route for Public Subnet...
aws ec2 create-route --route-table-id ${rt_id} --destination-cidr-block 0.0.0.0/0 --gateway-id ${igw_id} > /dev/null
echo ${complete}
printf "\n"

# Create Security Group and Enable SSH
echo Creating Security Group...
sg_id=$(aws ec2 create-security-group --group-name ssh_sg --vpc-id ${vpc_id} --description "allow ssh" | jq '.GroupId' | tr -d '"')
aws ec2 create-tags --resources ${sg_id} --tags Key=Name,Value=ssh_sg
aws ec2 authorize-security-group-ingress --group-id ${sg_id} --protocol tcp --port 22 --cidr 0.0.0.0/0
echo ${complete}
printf "\n"

# Deploying VM for Ansible Control Machine
echo Deploying VM for Ansible Control Machine...
ans_instance_id=$(aws ec2 run-instances --image-id ami-5e8bb23b --count 1 --instance-type t2.micro --security-group-ids ${sg_id} --key-name AWSPrivateKey --subnet-id ${m_subnet_id} --associate-public-ip-address | jq '.Instances' | jq .[] | jq '.InstanceId' | tr -d '"')
aws ec2 create-tags --resources "$ans_instance_id" --tags Key=Name,Value=Ansible_ControlMachine
echo ${cyn}EC2 Instance ${grn}Ansible_ControlMachine${cyn} Created
sleep 3
printf "\n"
echo ${mag}Waiting for Public DNS...
sleep 3
ans_dns=$(aws ec2 describe-instances --instance-ids ${ans_instance_id} | jq .[] | jq .[] | jq '.Instances' | jq .[] | jq '.PublicDnsName' | tr -d '"')
printf "\n"
echo Ansible Control Machine can be Accessed via ssh at 
printf "\n"
echo ${mag}${ans_dns}${cyn}


