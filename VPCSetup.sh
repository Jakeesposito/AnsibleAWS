#! /bin/bash
echo Creating Virtual Private Cloud 10.0.0.0/16...
aws ec2 create-vpc --cidr-block 10.0.0.0/16 > /dev/null
sleep 3
echo Creating Virtual Private Cloud 10.0.0.0/16...[COMPLETE]
sleep 2
echo Extracting VPC ID...
VPCID=$(aws ec2 describe-vpcs --query 'Vpcs[1].{VPCID:VpcId}' --output text) > /dev/null
sleep 3
echo VPC 10.0.0.0/16 created with VPC ID $VPCID
