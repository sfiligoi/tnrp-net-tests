# 7x A100 time share
gcloud beta container node-pools create pa100t7 --impersonate-service-account "${SA_FULL_NAME?}" --cluster=icecube-ts --zone us-central1-c --node-taints=osglimit=gpu:PreferNoSchedule --node-labels=osgclass=gpu,gputype=a100 --accelerator type=nvidia-tesla-a100,count=1,max-time-shared-clients-per-gpu=7 --machine-type=a2-highgpu-1g --num-nodes=1 --spot
# 3x V100 time share
gcloud beta container node-pools create pv100t3 --impersonate-service-account "${SA_FULL_NAME?}" --cluster=icecube-ts-2 --zone us-central1-c --node-taints=osglimit=gpu:PreferNoSchedule --node-labels=osgclass=gpu,gputype=v100 --machine-type "n1-standard-8" --accelerator "type=nvidia-tesla-v100,count=1,max-time-shared-clients-per-gpu=3" --num-nodes=1 --spot
# 3x T4 time share
gcloud beta container node-pools create pt4t3 --impersonate-service-account "${SA_FULL_NAME?}" --cluster=icecube-ts-2 --zone us-central1-c --node-taints=osglimit=gpu:PreferNoSchedule --node-labels=osgclass=gpu,gputype=t4 --machine-type "n1-standard-8" --accelerator "type=nvidia-tesla-t4,count=1,max-time-shared-clients-per-gpu=3" --num-nodes=1 --spot

