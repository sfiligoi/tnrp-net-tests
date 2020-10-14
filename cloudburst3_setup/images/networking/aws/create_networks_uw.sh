#!/bin/bash -x


#vpc-exa3-east-1
aws --region us-east-1 ec2 create-vpc --cidr-block 10.250.0.0/19  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3-east-1},{Key=ClouddConnect,Value=True}]"
VPC=vpc-0b3474d2377951990
IPel=0
for z in a b c d e f ; do 
  aws --region us-east-1 ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.250.${IPel}.0/22 --availability-zone=us-east-1${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3-east-1${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+4
done

#vpc-exa3b-east-1
aws --region us-east-1 ec2 create-vpc --cidr-block 10.250.32.0/19  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3b-east-1},{Key=ClouddConnect,Value=True}]"
VPC=vpc-0698ae5de81f47d2e
IPel=32
for z in a b c d e f ; do
  aws --region us-east-1 ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.250.${IPel}.0/22 --availability-zone=us-east-1${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3b-east-1${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+4
done

#vpc-exa3-east-2
aws --region us-east-2 ec2 create-vpc --cidr-block 10.250.64.0/20  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3-east-2},{Key=ClouddConnect,Value=True}]"
VPC=vpc-0f7643aae771bfcb6
IPel=64
for z in a b c ; do
  aws --region us-east-2 ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.250.${IPel}.0/22 --availability-zone=us-east-2${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3-east-2${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+4
done

#vpc-exa3b-east-2
aws --region us-east-2 ec2 create-vpc --cidr-block 10.250.80.0/20  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3b-east-2},{Key=ClouddConnect,Value=True}]"
VPC=???
IPel=80
for z in a b c ; do
  aws --region us-east-2 ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.250.${IPel}.0/22 --availability-zone=us-east-2${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3b-east-2${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+4
done


