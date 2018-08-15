#!/bin/bash
PRF="--profile sv"
AMI=ami-456b493a
MNGTP=t2.large
WEBTP=t2.medium
BOSTP=t2.medium
RSTP=t2.medium
NGHTTP=t2.large
AWS_DEFAULT_REGION=us-east-1
SBNT=subnet-d32b3bef
#mongo
MONGOID=$(aws $PRF ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bd8244cd sg-ffdc328f --user-data file://mongo-config.txt --instance-type $MNGTP --subnet-id $SBNT --block-device-mappings file://mongomappings.json --count 1 --associate-public-ip-address)
MONGOID=$(echo $ID | cut -f10 -d' ')
aws $PRF ec2 create-tags --resources $MONGOID --tags "Key=env,Value=prod,Key=Name,Value=MongoDB"
# web
WEBID=$(aws $PRF ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bd8244cd sg-ea3ad49a --user-data file://web-config.txt --instance-type $WEBTP --subnet-id $SBNT --block-device-mappings file://webmappings.json --count 1 --associate-public-ip-address)
WEBID=$(echo $ID | cut -f10 -d' ')
aws $PRF ec2 create-tags --resources $WEBID --tags "Key=env,Value=prod,Key=Name,Value=Web"
# bos
BOSID=$(aws $PRF ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bd8244cd sg-2e3ad45e --user-data file://bos-config.txt --instance-type $BOSTP --subnet-id $SBNT --block-device-mappings file://bosmappings.json --count 1 --associate-public-ip-address)
BOSID=$(echo $ID | cut -f10 -d' ')
aws $PRF ec2 create-tags --resources $BOSID --tags "Key=env,Value=prod,Key=Name,Value=BOS"
# RapidScreen
RSID=$(aws $PRF ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bd8244cd sg-ea3ad49a --user-data file://rs-config.txt --instance-type $RSTP --subnet-id $SBNT --block-device-mappings file://rsmappings.json --count 1 --associate-public-ip-address)
RSID=$(echo $ID | cut -f10 -d' ')
aws $PRF ec2 create-tags --resources $RSID --tags "Key=env,Value=prod,Key=Name,Value=RadidScreen"
# Nightly
NGHTID=$(aws $PRF ec2 run-instances --image-id $AMI --key-name dbg-pub --security-group-ids sg-bd8244cd sg-2e3ad45e --user-data file://nightly-config.txt --instance-type $NGHTTP --subnet-id $SBNT --block-device-mappings file://nightlymappings.json --count 1 --associate-public-ip-address)
NGHTID=$(echo $ID | cut -f10 -d' ')
aws $PRF ec2 create-tags --resources $NGHTID --tags "Key=env,Value=prod,Key=Name,Value=Nightly"

echo Mongo $MONGOID
echo Web $WEBID
echo Bos $BOSID
echo RapidScreen $RSID
echo Nightly $NGHTID
