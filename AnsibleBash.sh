#! /bin/bash
# 
# |||---METADATA---|||
# version 1.0
# Created July 2018
#
# ||---INFORMATION---|||
# 1. Update the EC2 Ubuntu Server Image 
# 2. Install 'software-properties-common'
# 3. Add Ansible Repository
# 4. Update Ansible Repository
# 5. Install Ansible on Ubuntu Server


echo Updating Ubuntu Distribution...
sudo apt-get update
echo Updating Ubuntu Distribution...[COMPLETE]
sleep 1
echo Installing Required Dependencies...
sudo apt-get install software-properties-common
echo Installing Required Dependencies...[COMPLETE]
sleep 1
echo Adding Ansible Repository...
sudo apt-add-repository ppa:ansible/ansible
echo Adding Ansible Repository...[COMPLETE]
sleep 1
echo Updating Ansible Repository...
sudo apt-get update
echo Updating Ansible Repository...[COMPLETE]
sleep 1
echo Installing Ansible...
sudo apt-get install ansible
echo Installing Ansible...[COMPLETE]
sleep 1
echo ---Ansible has been successfully installed on the machine---
sleep .5
