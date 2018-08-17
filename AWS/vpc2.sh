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
${mag}
echo Creating VPC...
sleep 2
vpc_info=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --output json)
vpc_id=$(echo $vpc_info | jq '.Vpc.VpcId' | tr -d '"')
aws ec2 create-tags --resources "$vpc_id" --tags Key=Name,Value=Demo_VPC
aws ec2 modify-vpc-attribute --vpc-id "$vpc_id" --enable-dns-support "{\"Value\":true}"
aws ec2 modify-vpc-attribute --vpc-id "$vpc_id" --enable-dns-hostnames "{\"Value\":true}"
echo VPC ${grn}Demo_VPC${mag} Created with ID= ${grn}$vpc_id${mag}
sleep 2
echo $complete
