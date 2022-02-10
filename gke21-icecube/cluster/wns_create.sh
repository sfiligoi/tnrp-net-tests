# 7x MIG
gcloud beta container node-pools create pa100m7 --cluster=icecube --zone us-central1-c --node-taints=osglimit=gpu:PreferNoSchedule --node-labels=osgclass=gpu,gputype=a100 --accelerator type=nvidia-tesla-a100,count=1,gpu-partition-size=1g.5gb --machine-type=a2-highgpu-1g --num-nodes=1 --spot
# 3x MIG
gcloud beta container node-pools create pa100m3 --cluster=icecube --zone us-central1-c --node-taints=osglimit=gpu:PreferNoSchedule --node-labels=osgclass=gpu,gputype=a100 --accelerator type=nvidia-tesla-a100,count=1,gpu-partition-size=2g.10gb --machine-type=a2-highgpu-1g --num-nodes=1 --spot
# 2x MIG
gcloud beta container node-pools create pa100m2 --cluster=icecube --zone us-central1-c --node-taints=osglimit=gpu:PreferNoSchedule --node-labels=osgclass=gpu,gputype=a100 --accelerator type=nvidia-tesla-a100,count=1,gpu-partition-size=3g.20gb --machine-type=a2-highgpu-1g --num-nodes=1 --spot
# whole A100 (1x MIG)
gcloud beta container node-pools create pa100m1 --cluster=icecube --zone us-central1-c --node-taints=osglimit=gpu:PreferNoSchedule --node-labels=osgclass=gpu,gputype=a100 --accelerator type=nvidia-tesla-a100,count=1,gpu-partition-size=7g.40gb --machine-type=a2-highgpu-1g --num-nodes=1 --spot
