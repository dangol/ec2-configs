#!/bin/bash
AMI=ami-9f086de0
MNGTP=m5.2xlarge
WEBTP=t2.medium
BOSTP=t2.medium
RSTP=t2.medium
NGHTTP=t2.large
# mongo
MONGOID=$(aws ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bf37d9c7  --user-data file://~/github/sv-ansible/aws/mongo-config.txt --instance-type $MNGTP --subnet-id subnet-b12be39b --block-device-mappings file://mongomappings.json --count 1 --associate-public-ip-address)
MONGOID=$(echo $ID | cut -f10 -d' ')
aws ec2 create-tags --resources $THISID --tags "Key=env,Value=prod,Key=Name,Value=MongoDB"
# web
WEBID=$(aws ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bf37d9c7  --user-data file://~/github/sv-ansible/aws/web-config.txt --instance-type $WEBTP --subnet-id subnet-b12be39b --block-device-mappings file://webmappings.json --count 1 --associate-public-ip-address)
WEBID=$(echo $ID | cut -f10 -d' ')
aws ec2 create-tags --resources $THISID --tags "Key=env,Value=prod,Key=Name,Value=Web"
# bos
BOSID=$(aws ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bf37d9c7  --user-data file://~/github/sv-ansible/aws/bos-config.txt --instance-type $BOSTP --subnet-id subnet-b12be39b --block-device-mappings file://bosmappings.json --count 1 --associate-public-ip-address)
WEBID=$(echo $ID | cut -f10 -d' ')
aws ec2 create-tags --resources $THISID --tags "Key=env,Value=prod,Key=Name,Value=BOS"
# RapidScreen
RSID=$(aws ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bf37d9c7  --user-data file://~/github/sv-ansible/aws/rs-config.txt --instance-type $RSTP --subnet-id subnet-b12be39b --block-device-mappings file://rsmappings.json --count 1 --associate-public-ip-address)
RSID=$(echo $ID | cut -f10 -d' ')
aws ec2 create-tags --resources $THISID --tags "Key=env,Value=prod,Key=Name,Value=RadidScreen"
# Nightly
NGHTID=$(aws ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bf37d9c7  --user-data file://~/github/sv-ansible/aws/nightly-config.txt --instance-type $NGHTTP --subnet-id subnet-b12be39b --block-device-mappings file://nightlymappings.json --count 1 --associate-public-ip-address)
RSID=$(echo $ID | cut -f10 -d' ')
aws ec2 create-tags --resources $THISID --tags "Key=env,Value=prod,Key=Name,Value=Nightly"

echo Mongo $MONGOID
echo Web $WEBID
echo Bos $BOSID
echo RapidScreen $RSID
echo Nightly $NGHTID