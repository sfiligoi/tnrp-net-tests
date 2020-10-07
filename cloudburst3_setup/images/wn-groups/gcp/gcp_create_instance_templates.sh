#!/bin/bash -x

IMAGE='--image-project=exa-demo --image=wn-er-us-v1 --boot-disk-size=30GB --boot-disk-type=pd-standard --machine-type=n1-standard-4 --no-restart-on-failure --maintenance-policy=TERMINATE --preemptible --network-tier=STANDARD'

SSHKEY=--metadata=ssh-keys=centos:ssh-rsa\ AAAAB3NzaC1yc2EAAAADAQABAAABAQDIi6sHuPqcx4J0pLiXSnLGRSlnILReeaff9gGCm0zKiqHVeZ6RPo2gbYKDBzVgDJcqOftjp/Mcg30YIDX1ei42W2WRHx/ewuK\+09qejjAuo389ySByS6mI/emu2HhdvYMb07nhycdyK45xXYM6wla6hfQIrNccAKfPCWGdlc/FNxW5ffBFrm7AM9yMCXc95XkuRBto1oaySTYEr3FGYw2U8FfRmmnL/U7xI7zKR4OeWRn8KlaQyABybQ8h5a6T6ISjxmUoSL1MIWPlfNuxZ5djEoCIrtuhPeXW5dxlPrJCdSiBHQcAhsqQD1oyCIz60QCj9xJOjdx4ENXqlkFLPBw9\ centos

gcloud compute --project=exa-demo instance-templates create it-exa3-us-west-1-t4-v1 $IMAGE "$SSHKEY" \
    --min-cpu-platform="Intel Broadwell" \
    --region=us-west1 --subnet=projects/exa-demo/regions/us-west1/subnetworks/exa3-us-west1 \
    --accelerator=type=nvidia-tesla-t4,count=1 

gcloud compute --project=exa-demo instance-templates create it-exa3-us-west-1-v100-v1 $IMAGE "$SSHKEY" \
    --min-cpu-platform="Intel Broadwell" \
    --region=us-west1 --subnet=projects/exa-demo/regions/us-west1/subnetworks/exa3-us-west1 \
    --accelerator=type=nvidia-tesla-v100,count=1

