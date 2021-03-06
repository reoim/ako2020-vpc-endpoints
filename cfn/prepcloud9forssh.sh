#!/bin/sh
# aws configure get region
aws --region us-east-1  ssm get-parameter --name "lab" --with-decryption --output text --query Parameter.Value > ~/environment/lab.pem
#add proper carriage returns
sed -i 's/\\n/\n/g' ~/environment/lab.pem
#correct perms
sudo chmod 400 ~/environment/lab.pem
#add an /etc/hosts entries for convenient SSH 
salesappip=`aws ssm get-parameter --name salesappip --output text --query Parameter.Value`
reportsengineip=`aws ssm get-parameter --name reportsengineip --output text --query Parameter.Value`
echo " "
echo "SSH key configured:"
ls -lart ~/environment/lab.pem
echo " "
echo -e "\e[1;35m Adding entries in /etc/hosts for convenient SSH: \e[0m"
echo " $salesappip     salesapp" | sudo tee -a /etc/hosts
echo " $reportsengineip     reportsengine" | sudo tee -a /etc/hosts
echo " "
# echo the ssh string to connect to Sales App
echo -e " "
echo -e "\e[1;31m  Connect to the Sales Application EC2 host using: \e[0m"
echo "ssh ec2-user@salesapp -i lab.pem"
# echo the ssh string to connect to Reports Engine
echo " "
echo -e "\e[1;33m  Connect to the Reports Engine EC2 host using: \e[0m"
echo "ssh ec2-user@reportsengine -i lab.pem"
echo " "
echo " "