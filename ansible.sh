#!/bin/bash
echo Updating Ubuntu Distribution...
sudo apt-get update > /dev/null 2>&1
echo Updating Ubuntu Distribution...[COMPLETE]
sleep 3
echo Installing Required Dependencies...
sudo apt-get install software-properties-common > /dev/null 2>&1
echo Installing Required Dependencies...[COMPLETE]
sleep 3
echo Adding Ansible Repository...
echo | sudo apt-add-repository ppa:ansible/ansible > /dev/null 2>&1
echo | sudo apt-get-update > /dev/null 2>&1
echo Adding Ansible Repository...[COMPLETE]
sleep 3
echo Updating Ansible Repository...
sudo apt-get update > /dev/null 2>&1
echo Updating Ansible Repository...[COMPLETE]
sleep 3
echo Installing Ansible...
sudo apt-get install ansible > /dev/null 2>&1
echo Installing Ansible...[COMPLETE]
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
echo ANSIBLE INSTALLATION AND CONFIGURATION COMPLETE
