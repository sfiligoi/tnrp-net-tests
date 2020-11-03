#!/bin/bash -x


#vpc-exa3-east-1
aws --region us-east-1 ec2 create-vpc --cidr-block 10.250.0.0/19  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3-east-1},{Key=ClouddConnect,Value=True}]"
VPC=vpc-0fc9ab2b10bb9eba6
IPel=0
for z in a b c d e f ; do 
  aws --region us-east-1 ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.250.${IPel}.0/22 --availability-zone=us-east-1${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3-east-1${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+4
done

#vpc-exa3b-east-1
aws --region us-east-1 ec2 create-vpc --cidr-block 10.250.32.0/19  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3b-east-1},{Key=ClouddConnect,Value=True}]"
VPC=vpc-0aef4762503d2348c
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
VPC=vpc-049981127d8ae6336
IPel=80
for z in a b c ; do
  aws --region us-east-2 ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.250.${IPel}.0/22 --availability-zone=us-east-2${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3b-east-2${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+4
done

#vpc-exa3c-east-2
aws --region us-east-2 ec2 create-vpc --cidr-block 10.250.112.0/20  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3c-east-2},{Key=ClouddConnect,Value=True}]"
VPC=vpc-0d9a008073d6c662d
IPel=112
for z in a b c ; do
  aws --region us-east-2 ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.250.${IPel}.0/22 --availability-zone=us-east-2${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3c-east-2${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+4
done



#vpc-ucsd3-west-1
aws --region us-west-1 ec2 create-vpc --cidr-block 10.250.96.0/20  "--tag-specifications=ResourceType=vpc,Tags=[{Key=Name,Value=vpc-exa3-west-1},{Key=ClouddConnect,Value=True}]"
VPC=vpc-0f78bed8b0c47c1c1
IPel=96
for z in b c ; do
  aws --region us-west-1 ec2 create-subnet --vpc-id=${VPC} --cidr-block=10.250.${IPel}.0/21 --availability-zone=us-west-1${z} "--tag-specifications=ResourceType=subnet,Tags=[{Key=Name,Value=sn-exa3-west-1${z}},{Key=ClouddConnect,Value=True}]"
  let IPel=IPel+8
done


# manually create 
#   internet gateways
#   virtual private gateways
#   peering with defalult
#   routes

