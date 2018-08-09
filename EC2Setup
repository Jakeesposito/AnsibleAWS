#! /bin/bash
echo Installing Amazon Web Services CLI...
sudo apt-get install awscli > /dev/null
echo Installing Amazon Web Services CLI...[COMPLETE]
sleep 1
echo Installing jq...
sudo apt-get install jq > /dev/null
echo Installing jq...[COMPLETE]
sleep 1
echo Enter Access Keys Below...
aws configure
echo Testing AWS Connection...
sleep 3
aws sts get-caller-identity

