# Running Ansible on AWS to Deploy Hybrid/Multi-Cloud Environments

## Create IAM User in AWS
1. Login to https://www.aws.amazon.com.
2. Navigate to IAM groups and click *Create New Group*.
3. Name the group and select the *AdministratorAccess* policy.
4. Navigate to IAM users and click *Add User*.
5. Name the user, select *Programmatic Access*, and add user to the newly created group.
6. Click to download .CSV or write down *Access Key ID* and *Secret Access Key*. These credentials will be needed for CLI access.

## Launch Ubuntu Server VM
1. Navigate to AWS EC2
2. Click *Launch Instance* 
