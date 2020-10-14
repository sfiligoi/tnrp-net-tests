#!/bin/bash -x

#vpc-ucsd3-west-1
aws --region us-west-1 ec2 create-vpc --cidr-block 192.168.132.0/23  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-ucsd3-west-1},{Key=ClouddConnect,Value=True}]"
VPC=vpc-02575491655ea3447
IPel=132
for z in b c ; do
  aws --region us-west-1 ec2 create-subnet --vpc-id=${VPC} --cidr-block=192.168.${IPel}.0/24 --availability-zone=us-west-1${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-ucsd3-west-1${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+1
done


#vpc-ucsd3-west-2
aws --region us-west-2 ec2 create-vpc --cidr-block 192.168.128.0/22  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-ucsd3-west-2},{Key=ClouddConnect,Value=True}]"
VPC=vpc-070a4ef55d33b3852
IPel=128
for z in a b c d ; do 
  aws --region us-west-2 ec2 create-subnet --vpc-id=${VPC} --cidr-block=192.168.${IPel}.0/24 --availability-zone=us-west-2${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-ucsd3-west-2${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+1
done

