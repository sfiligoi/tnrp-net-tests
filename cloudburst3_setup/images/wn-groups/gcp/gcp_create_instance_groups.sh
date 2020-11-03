#!/bin/bash -x

# US central
#z1
gcloud compute --project=exa-demo instance-groups managed create ig-exa3-us-central-1-t4 \
               --base-instance-name=ig-exa3-us-central-1-t4 --template=it-exa3-us-central-1-t4-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3-us-central-1-v100 \
               --base-instance-name=ig-exa3-us-central-1-v100 --template=it-exa3-us-central-1-v100-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-c,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3-us-central-1-p100 \
               --base-instance-name=ig-exa3-us-central-1-p100 --template=it-exa3-us-central-1-p100-v2 --size=0 \
               --zones=us-central1-c,us-central1-f --instance-redistribution-type=NONE

#z2
gcloud compute --project=exa-demo instance-groups managed create ig-exa3b-us-central-1-t4 \
               --base-instance-name=ig-exa3b-us-central-1-t4 --template=it-exa3b-us-central-1-t4-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3b-us-central-1-v100 \
               --base-instance-name=ig-exa3b-us-central-1-v100 --template=it-exa3b-us-central-1-v100-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-c,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3b-us-central-1-p100 \
               --base-instance-name=ig-exa3b-us-central-1-p100 --template=it-exa3b-us-central-1-p100-v2 --size=0 \
               --zones=us-central1-c,us-central1-f --instance-redistribution-type=NONE

#z3

gcloud compute --project=exa-demo instance-groups managed create ig-exa3c-us-central-1-t4 \
               --base-instance-name=ig-exa3c-us-central-1-t4 --template=it-exa3c-us-central-1-t4-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3c-us-central-1-v100 \
               --base-instance-name=ig-exa3c-us-central-1-v100 --template=it-exa3c-us-central-1-v100-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-c,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3c-us-central-1-p100 \
               --base-instance-name=ig-exa3c-us-central-1-p100 --template=it-exa3c-us-central-1-p100-v2 --size=0 \
               --zones=us-central1-c,us-central1-f --instance-redistribution-type=NONE

#z4

gcloud compute --project=exa-demo instance-groups managed create ig-exa3d-us-central-1-t4 \
               --base-instance-name=ig-exa3d-us-central-1-t4 --template=it-exa3d-us-central-1-t4-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3d-us-central-1-v100 \
               --base-instance-name=ig-exa3d-us-central-1-v100 --template=it-exa3d-us-central-1-v100-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-c,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3d-us-central-1-p100 \
               --base-instance-name=ig-exa3d-us-central-1-p100 --template=it-exa3d-us-central-1-p100-v2 --size=0 \
               --zones=us-central1-c,us-central1-f --instance-redistribution-type=NONE


# US West

for zone in exa3 exa3b exa3c exa3d; do
 for g in t4 p100 v100; do
   gcloud compute --project=exa-demo instance-groups managed create ig-${zone}-us-west-1-${g} \
                  --base-instance-name=ig-${zone}-us-west-1-${g} --template=it-${zone}-us-west-1-${g}-v2 --size=0 \
                  --zones=us-west1-a,us-west1-b --instance-redistribution-type=NONE
  done
done

# US East

for zone in exa3 exa3b exa3c exa3d; do
  gcloud compute --project=exa-demo instance-groups managed create ig-${zone}-us-east-1-t4 \
                 --base-instance-name=ig-${zone}-us-east-1-t4 --template=it-${zone}-us-east-1-t4-v3 --size=0 \
                 --zones=us-east1-c,us-east1-d --instance-redistribution-type=NONE

  gcloud compute --project=exa-demo instance-groups managed create ig-${zone}-us-east-1-v100 \
                 --base-instance-name=ig-${zone}-us-east-1-v100 --template=it-${zone}-us-east-1-v100-v3 --size=0 \
                 --zones=us-east1-c --instance-redistribution-type=NONE

  gcloud compute --project=exa-demo instance-groups managed create ig-${zone}-us-east-1-p100 \
                 --base-instance-name=ig-${zone}-us-east-1-p100 --template=it-${zone}-us-east-1-p100-v3 --size=0 \
                 --zones=us-east1-b,us-east1-c --instance-redistribution-type=NONE
done
