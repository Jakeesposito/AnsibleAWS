#! /bin/bash

# Color Variables
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

#Install AWS CLI and jq
sudo apt-get update > /dev/null
echo Installing Amazon Web Services CLI...
sudo apt-get -y install awscli > /dev/null
sleep 3
echo Installing Amazon Web Services CLI...${grn}[COMPLETE]${end}
sleep 3
echo Installing jq...
sudo apt-get -y install jq > /dev/null
echo Installing jq...${grn}[COMPLETE]${end}
sleep 3

# Authenticate into AWS
echo Enter Access Keys Below...
aws configure
echo Testing AWS Connection...
sleep 3
aws sts get-caller-identity | jq

