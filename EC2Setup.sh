#! /bin/bash
sudo apt-get update
echo Installing Amazon Web Services CLI...
sudo apt-get install awscli > /dev/null
sleep 3
echo Installing Amazon Web Services CLI...[COMPLETE]
sleep 3
echo Installing jq...
sudo apt-get install jq > /dev/null
echo Installing jq...[COMPLETE]
sleep 3
echo Enter Access Keys Below...
aws configure
echo Testing AWS Connection...
sleep 3
aws sts get-caller-identity

