#!/bin/bash -x

# US east
#z1
gcloud compute --project=exa-demo instance-groups managed create ig-exa3-us-central-1-t4 \
               --base-instance-name=ig-exa3-us-central-1-t4 --template=it-exa3-us-central-1-t4-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3-us-central-1-v100 \
               --base-instance-name=ig-exa3-us-central-1-v100 --template=it-exa3-us-central-1-v100-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-c,us-central1-f --instance-redistribution-type=NONE

#z2
gcloud compute --project=exa-demo instance-groups managed create ig-exa3b-us-central-1-t4 \
               --base-instance-name=ig-exa3b-us-central-1-t4 --template=it-exa3b-us-central-1-t4-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3b-us-central-1-v100 \
               --base-instance-name=ig-exa3b-us-central-1-v100 --template=it-exa3b-us-central-1-v100-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-c,us-central1-f --instance-redistribution-type=NONE


#z3

gcloud compute --project=exa-demo instance-groups managed create ig-exa3c-us-central-1-t4 \
               --base-instance-name=ig-exa3c-us-central-1-t4 --template=it-exa3c-us-central-1-t4-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-f --instance-redistribution-type=NONE

gcloud compute --project=exa-demo instance-groups managed create ig-exa3c-us-central-1-v100 \
               --base-instance-name=ig-exa3c-us-central-1-v100 --template=it-exa3c-us-central-1-v100-v2 --size=0 \
               --zones=us-central1-a,us-central1-b,us-central1-c,us-central1-f --instance-redistribution-type=NONE


# US West
for z in a b; do
    gcloud compute --project=exa-demo instance-groups managed create ig-exa3-us-west1-${z}-t4 \
                   --base-instance-name=ig-exa3-us-west1-${z}-t4 --template=it-exa3-us-west-1-t4-v2 --size=0 \
                   --zones=us-west1-${z} --instance-redistribution-type=NONE
done


#for z in c d; do
#    gcloud beta compute --project=exa-demo instance-groups managed create ig-us-east1-${z}-t4-v8 \
#                        --base-instance-name=ig-us-east1-${z}-t4 --template=it-us-t4-v8-a3 --size=0 \
#                        --zones=us-east1-${z} --instance-redistribution-type=NONE
#done

#
#
#


#for z in a b c f; do
#    gcloud beta compute --project=exa-demo instance-groups managed create ig-us-central1-${z}-v100-v8 \
#                        --base-instance-name=ig-us-central1-${z}-v100 --template=it-us-v100-v8-a2 --size=0 \
#                        --zones=us-central1-${z} --instance-redistribution-type=NONE
#done

for z in a b; do
    gcloud compute --project=exa-demo instance-groups managed create ig-exa3-us-west1-${z}-v100 \
                   --base-instance-name=ig-exa3-us-west1-${z}-v100 --template=it-exa3-us-west-1-v100-v2 --size=0 \
                   --zones=us-west1-${z} --instance-redistribution-type=NONE
done

