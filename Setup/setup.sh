#! /bin/bash

# Color Variables
grn=$'\e[1;32m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
yel=$'\e[1;33m'
end=$'\e[0m'

#Install AWS CLI, Jq for json, and pwgen
sudo apt-get update > /dev/null
echo ${mag}Installing Amazon Web Services CLI...${end}
sudo apt-get -y install awscli > /dev/null
echo ${grn}[COMPLETE]${end}
echo ${mag}Installing jq...${end}
sudo apt-get -y install jq > /dev/null
echo ${grn}[COMPLETE]${end}
echo ${mag}Installing Password Generator...${end}
sudo apt-get install pwgen > /dev/null
echo ${grn}[COMPLETE]${end}


# Install Azure CLI
AZ_REPO=$(lsb_release -cs)
echo ${mag}Installing Azure CLI 2.0 For Ubuntu ${AZ_REPO}...${end}
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list > /dev/null 2>&1
curl -L -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - > /dev/null 2>&1
sudo apt-get install apt-transport-https > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install azure-cli > /dev/null
echo ${grn}[COMPLETE]${end}


# Authenticate into Azure
echo ${mag}Authenticating into Azure...${end}
ten_id=$(az login | jq .[] | jq '.tenantId' | tr -d '"')
echo ${grn}[COMPLETE]${end}
echo ${mag}Creating Service Principal Account...${end}
az group create -n 'AnsibleResourceGroup' -l 'eastus' > /dev/null
az provider register -n Microsoft.KeyVault &> /dev/null
echo ${grn}[COMPLETE]${end}
echo ${mag}Registering...${end}
reg_state=$(az provider show -n Microsoft.KeyVault | jq '.registrationState' | tr -d '"')

# Wait for Registration
while [ "$reg_state" != "Registered" ]
do
echo ${red}$reg_state${end}
reg_state=$(az provider show -n Microsoft.KeyVault | jq '.registrationState' | tr -d '"')
done
echo ${grn}[COMPLETE]${end}

# Create Key Vault
echo ${mag}Creating Unique Key Vault...${end}
vault_name=$(pwgen -n -B 12 1)
az keyvault create --resource-group AnsibleResourceGroup --name ${vault_name} --location 'eastus' > /dev/null
echo ${grn}[COMPLETE]${end}

# Create Service Principal Account
az ad sp create-for-rbac --name AnsibleServiceAccount --password Citrix123! 
echo ${grn}[AZURE CONFIGURATION COMPLETE]${end}
printf "\n"

# Authenticate into AWS
echo ${mag}Enter AWS Access Keys Below...
aws configure
printf "\n"
echo ${mag}Testing AWS Connection...${end}
echo ${grn}[COMPLETE]
echo ${grn}[AMAZON WEB SERVICES CONFIGURATION COMPLETE]${end}
sleep 1
printf "\n"
echo ${grn}[SCRIPT COMPLETE]${end}
printf "\n"
printf "\n"
printf "\n"
