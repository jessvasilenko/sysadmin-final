# sysadmin-final
CS312 - Course Project Part 2

## Background

For this assignment, I worked on deploying a Minecraft server on AWS EC2 using Terraform and a custom bash script. These scripts will remove the need to manually enter or configure in the AWS EC2 console, accomplishing Infrastructure as Code.

## Requirements 

- AWS Learner Lab credentials
- Terraform installed
- AWS CLI v2 installed and configured
- Git and GitHub access
- An SSH key-pair downloaded from AWS
- Docker access
- WSL or Linux shell access

## Project Diagram: 
Setup AWS Creds -> Setup repo -> Setup terraform infrastructure -> Transfer setup script -> Connect to Instance -> Install minecraft via Docker -> Confirm server is up and running :)

## Part 1: Setup AWS Credentials

Open your terminal and set the AWS credentials:

```bash
aws configure
# When prompted:
# AWS Access Key ID [None]: <Your Access Key>
# AWS Secret Access Key [None]: <Your Secret Access Key>
# Default region name [None]: <Your AWS region>
# Default output format [None]: <default>

export AWS_ACCESS_KEY_ID=<Your Access Key>
export AWS_SECRET_ACCESS_KEY=<Your Secret Access Key>
export AWS_SESSION_TOKEN=<Your Session Token>
```

## Part 2: Clone Repository

```bash
git clone https://github.com/jessvasilenko/sysadmin-final.git
cd sysadmin-final
```

## Part 3: Terraform Infrastructure Setup

```bash
cd terraform
terraform init
terraform apply
# Type "yes" to approve changes
```

After provisioning, Terraform will output the public IP of the instance. Save this.

## Part 4: Transfer Setup Script and Connect via SSH

```bash
chmod 400 minecraft-final.pem
scp -i minecraft-final.pem install-minecraft.sh ubuntu@<instance_ip>:~
ssh -i minecraft-final.pem ubuntu@<instance_ip>
```

## Part 5: Install Minecraft with Docker

On the EC2 instance:

```bash
sudo ./install-minecraft.sh
```

The script installs Docker, sets up the Minecraft server container, and enables the service.

## Part 6: Confirm Server is Running

From your local terminal:

```bash
nmap -Pn -p 25565 <instance_ip>
```

If port 25565 is open, the Minecraft server is successfully running.

## Part 7: Cleanup (Optional)

To destroy your infrastructure:

```bash
cd terraform
terraform destroy
```
