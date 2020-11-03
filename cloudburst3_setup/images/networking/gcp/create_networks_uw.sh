#!/bin/bash

# exa3
gcloud compute networks create exa3 --project=exa-demo "--description=Network for exa3 cloudburst" --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create exa3-us-central-1 --project=exa-demo --range=10.249.0.0/20 --network=exa3 --region=us-central1
gcloud compute networks subnets create exa3-us-east1 --project=exa-demo --range=10.249.64.0/20 --network=exa3 --region=us-east1
gcloud compute networks subnets create exa3-us-west1 --project=exa-demo --range=10.249.128.0/20 --network=exa3 --region=us-west1

gcloud compute firewall-rules create exa3-all-in --network exa3 --allow tcp:1024-65535,udp:1024-65535,icmp --source-ranges 0.0.0.0/0
gcloud compute firewall-rules create exa3-ssh --network exa3 --allow tcp:22 --source-ranges 0.0.0.0/0

# exa3b
gcloud compute networks create exa3b --project=exa-demo "--description=Network for exa3 CloudBurst Partition B" --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create exa3b-us-central-1 --project=exa-demo --range=10.249.16.0/20 --network=exa3b --region=us-central1
gcloud compute networks subnets create exa3b-us-east1 --project=exa-demo --range=10.249.80.0/20 --network=exa3b --region=us-east1
gcloud compute networks subnets create exa3b-us-west1 --project=exa-demo --range=10.249.144.0/20 --network=exa3b --region=us-west1

gcloud compute firewall-rules create exa3b-all-in --network exa3b --allow tcp:1024-65535,udp:1024-65535,icmp --source-ranges 0.0.0.0/0
gcloud compute firewall-rules create exa3b-ssh --network exa3b --allow tcp:22 --source-ranges 0.0.0.0/0


# exa3c
gcloud compute networks create exa3c --project=exa-demo "--description=Exa3 instance 3 (c)" --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create exa3c-us-central-1 --project=exa-demo --range=10.249.32.0/20 --network=exa3c --region=us-central1
gcloud compute networks subnets create exa3c-us-east1 --project=exa-demo --range=10.249.96.0/20 --network=exa3c --region=us-east1
gcloud compute networks subnets create exa3c-us-west1 --project=exa-demo --range=10.249.160.0/20 --network=exa3c --region=us-west1

gcloud compute firewall-rules create exa3c-all-in --network exa3c --allow tcp:1024-65535,udp:1024-65535,icmp --source-ranges 0.0.0.0/0
gcloud compute firewall-rules create exa3c-ssh --network exa3c --allow tcp:22 --source-ranges 0.0.0.0/0

# exa3d
gcloud compute networks create exa3d --project=exa-demo "--description=Exa3 instance 4" --subnet-mode=custom --mtu=1460 --bgp-routing-mode=global

gcloud compute networks subnets create exa3d-us-central-1 --project=exa-demo --range=10.249.48.0/20 --network=exa3d --region=us-central1
gcloud compute networks subnets create exa3d-us-east1 --project=exa-demo --range=10.249.112.0/20 --network=exa3d --region=us-east1
gcloud compute networks subnets create exa3d-us-west1 --project=exa-demo --range=10.249.176.0/20 --network=exa3d --region=us-west1

gcloud compute firewall-rules create exa3d-all-in --network exa3d --allow tcp:1024-65535,udp:1024-65535,icmp --source-ranges 0.0.0.0/0
gcloud compute firewall-rules create exa3d-ssh --network exa3d --allow tcp:22 --source-ranges 0.0.0.0/0

# VPC network peering between default and the above netowrks created by hand
