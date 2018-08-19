#!/bin/bash

#Text Color Variables
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;36m'
cyn=$'\e[1;36m'
end=$'\e[0m'

#Update Ubuntu & Install Ansible PPA
echo ${mag}Updating Ubuntu Distribution...${end}
sudo apt-get update > /dev/null 2>&1
echo ${mag}Updating Ubuntu Distribution...${grn}[COMPLETE]${end}
sleep 3
echo ${mag}Installing Required Dependencies...${end}
sudo apt-get install software-properties-common > /dev/null 2>&1
echo ${mag}Installing Required Dependencies...${grn}[COMPLETE]${end}
sleep 3
echo ${mag}Adding Ansible Repository...${end}
echo | sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1
echo | sudo apt-get-update > /dev/null 2>&1
echo ${mag}Adding Ansible Repository...${grn}[COMPLETE]${end}
sleep 3
echo ${mag}Updating Ansible Repository...${end}
sudo apt-get update > /dev/null 2>&1
echo ${mag}Updating Ansible Repository...${grn}[COMPLETE]${end}
sleep 3
echo ${mag}Installing Ansible...${end}
sudo apt-get install ansible > /dev/null 2>&1
echo ${mag}Installing Ansible...${grn}[COMPLETE]${end}
sleep 3
echo ${mag}Finalizing...
echo .${end}
sudo apt-get update > /dev/null 2>&1
sleep 3
echo ${grn}ANSIBLE INSTALLATION AND CONFIGURATION COMPLETE${end}
sleep 1
