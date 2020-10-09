#!/bin/bash -x


#vpc-exa3-east-1
aws ec2 create-vpc --cidr-block 10.150.0.0/19  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3-east-1},{Key=ClouddConnect,Value=True}]"
VPC=vpc-0b3474d2377951990
IPel=0
for z in a b c d e f ; do 
  aws ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.150.${IPel}.0/22 --availability-zone=us-east-1${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3-east-1${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+4
done

#vpc-exa3b-east-1
aws ec2 create-vpc --cidr-block 10.150.32.0/19  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3b-east-1},{Key=ClouddConnect,Value=True}]"
VPC=vpc-0698ae5de81f47d2e
IPel=32
for z in a b c d e f ; do
  aws ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.150.${IPel}.0/22 --availability-zone=us-east-1${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3b-east-1${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+4
done

