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
echo ${mag}Installing Amazon Web Services CLI...${end}
sudo apt-get -y install awscli > /dev/null
sleep 3
echo ${grn}[COMPLETE]${end}
sleep 3
echo ${mag}Installing jq...${end}
sudo apt-get -y install jq > /dev/null
echo ${grn}[COMPLETE]${end}
sleep 3

# Install Azure CLI
echo ${mag}Installing Azure CLI 2.0...${end}
AZ_REPO=$(lsb_release -cs)
echo ${mag}Version ${grn}${AZ_REPO}${end}
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list > /dev/null
curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - > /dev/null
sudo apt-get install apt-transport-https > /dev/null
sudo apt-get update && sudo apt-get install azure-cli
sleep 3
echo ${grn}[COMPLETE]${end}
sleep 3

# Authenticate into Azure
echo Authenticating into Azure...
sleep 3
az login | jq .[] | jq '.tenantId' | tr -d '"'

# Authenticate into AWS
echo ${mag}Enter Access Keys Below...${red}
aws configure
echo ${mag}Testing AWS Connection...${end}
sleep 3
aws sts get-caller-identity | jq
sleep 3


echo ${mag}...........................................................${end}
echo ${mag}...........................................................${end}
echo ${mag}............${grn}Amazon Web Services Setup Complete${mag}.............${end}
echo ${mag}...........................................................${end}
echo ${mag}...........................................................${end}
sleep 1
