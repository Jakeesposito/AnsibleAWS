# Running Ansible on AWS to Deploy Hybrid/Multi-Cloud Environments


### Create IAM User in AWS
1. Login to [AWS Console](https://www.aws.amazon.com).
2. Navigate to IAM groups and click *Create New Group*.
3. Name the group and select the *AdministratorAccess* policy.
4. Navigate to IAM users and click *Add User*.
5. Name the user, select *Programmatic Access*, and add user to the newly created group.
6. Click to download .CSV or write down *Access Key ID* and *Secret Access Key*. These credentials will be needed for CLI access.


### Launch Ubuntu Server VM
1. Navigate to AWS EC2.
2. Click *Launch Instance*.
3. Find *Ubuntu Server 16.04 LTS (HVM)* and launch VM on a *t2.micro* instance.
4. Select *Create a New Key Pair* and enter the name *AWSPrivateKey*. Download the key pair .PEM file.


### SSH to Ubuntu Server with PuTTY
This section requires PuTTY and PuTTYgen which can be downloaded on their [website](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html). Note that most package installations of PuTTY also include PuTTYgen.
1. Open *PuTTYgen* on your machine and click *Load*.
2. Navigate to the saved AWS .PEM file and click *Open*.
3. Click *Save private key* to save the converted .PPK file.
4. Open *PuTTY*.
5. Enter your public IPv4 host name (ex. `ec2-18-222-152-136.us-east-2.compute.amazonaws.com`).
6. Navigate to *Connection*-->*SSH*-->*Auth* and click *Browse* to find your .PPK file.
7. Click *Open* to launch the session and login with username *ubuntu*.


### Download Script Files
1. Update the Ubuntu Server instance. ```sudo apt-get update```
2. Navigate to the local *bin* directory. ```cd /usr/local/bin```
3. Copy Git repository locally. ```sudo git clone https://www.github.com/jakeesposito/multicloudgslb```
4. Ensure the directory *multicloudgslb* has been copied. `ls`
5. Navigate into the AWS directory. `cd multicloudgslb/Setup`
6. Make scripts executable. `sudo chmod +x *.sh`


### Running the Cloud Setup Script
1. Navigate into the Setup directory. `cd multicloudgslb/Setup`
2. Make scripts executable. `sudo chmod +x *.sh`
3. Run the cloud setup script. `./setup.sh`

>Actions:
>- Install AWS command line interface
>- Install Azure command line interface
>- Install jq
>- Install pwgen
>- Authenticate into AWS account
>- Authenticate into Azure account


### Running the VPC Script
1. Navigate to AWS directory. `cd /usr/local/bin/multicloudgslb/AWS`
2. Make scripts executable. `sudo chmod +x *.sh`
3. Run the VPC setup script. `./awsvpc.sh`

>Actions:
>- Create VPC 10.0.0.0/16
>- Create client subnet 10.0.1.0/24
>- Create server subnet 10.0.2.0/24
>- Create management subnet 10.0.3.0/24
>- Create route tables
>- Create security groups


### Running the Ansible Setup Script
1. Navigate to Ansible directory. `cd /usr/local/bin/multicloudgslb/Ansible`
2. Make scripts executable. `sudo chmod +x *.sh`
3. Run the VPC setup script. `./setup.sh`

>Actions:
>- Launch EC2 Ubuntu Server instance in management subnet
>- Download Ansible dependencies
>- Add Ansible repositories
>- Download Ansible





