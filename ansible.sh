#!/bin/bash

#Text Color Variables
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

#Update Ubuntu & Install Ansible PPA
echo Updating Ubuntu Distribution...
sudo apt-get update > /dev/null 2>&1
echo Updating Ubuntu Distribution...${grn}[COMPLETE]${end}
sleep 3
echo Installing Required Dependencies...
sudo apt-get install software-properties-common > /dev/null 2>&1
echo Installing Required Dependencies...${grn}[COMPLETE]${end}
sleep 3
echo Adding Ansible Repository...
echo | sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1
echo | sudo apt-get-update > /dev/null 2>&1
echo Adding Ansible Repository...${grn}[COMPLETE]${end}
sleep 3
echo Updating Ansible Repository...
sudo apt-get update > /dev/null 2>&1
echo Updating Ansible Repository...${grn}[COMPLETE]${end}
sleep 3
echo Installing Ansible...
sudo apt-get install ansible > /dev/null 2>&1
echo Installing Ansible...${grn}[COMPLETE]${end}
sleep 3
echo Finalizing...
sleep .5
echo .
sleep .5
echo .
sleep .5
echo .
sudo apt-get update > /dev/null 2>&1
sleep 3
echo ${mag}ANSIBLE INSTALLATION AND CONFIGURATION COMPLETE${end}
