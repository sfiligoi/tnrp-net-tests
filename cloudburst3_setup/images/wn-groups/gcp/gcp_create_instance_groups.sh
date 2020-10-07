#!/bin/bash -x

#for z in a b f; do
#    gcloud beta compute --project=exa-demo instance-groups managed create ig-us-central1-${z}-t4-v8 \
#                        --base-instance-name=ig-us-central1-${z}-t4 --template=it-us-t4-v8-a2 --size=0 \
#                        --zones=us-central1-${z} --instance-redistribution-type=NONE
#done


for z in a b; do
    gcloud compute --project=exa-demo instance-groups managed create ig-exa3-us-west1-${z}-t4 \
                   --base-instance-name=ig-exa3-us-west1-${z}-t4 --template=it-exa3-us-west-1-t4-v1 --size=0 \
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
                   --base-instance-name=ig-exa3-us-west1-${z}-v100 --template=it-exa3-us-west-1-v100-v1 --size=0 \
                   --zones=us-west1-${z} --instance-redistribution-type=NONE
done

