#!/bin/bash -x

gcloud compute --project=exa-demo instance-groups managed create ig-exa4-v4-usc1 \
               --base-instance-name=ig-usc1 --template=it-exa4-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa4-v4-usw1 \
               --base-instance-name=ig-usw1 --template=it-exa4-v2 --size=0 \
               --zones=us-west1-a,us-west1-b --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa4-v4-use1 \
               --base-instance-name=ig-use1 --template=it-exa4-v2 --size=0 \
               --zones=us-east1-c,us-east1-d --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa4-v4-use4 \
               --base-instance-name=ig-use4 --template=it-exa4-v2 --size=0 \
               --zones=us-east4-b --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa4-v4-euw4 \
               --base-instance-name=ig-euw4 --template=it-exa4-v2-eu --size=0 \
               --zones=europe-west4-b,europe-west4-c --instance-redistribution-type=NONE

