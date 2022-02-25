# V100
gcloud beta container node-pools create pv100 --cluster=icecube --zone us-central1-c --node-taints=osglimit=gpu:PreferNoSchedule --node-labels=osgclass=gpu,gputype=v100 --machine-type "n1-standard-4" --accelerator "type=nvidia-tesla-v100,count=1" --num-nodes=1 --spot
# T4
gcloud beta container node-pools create pt4 --cluster=icecube --zone us-central1-c --node-taints=osglimit=gpu:PreferNoSchedule --node-labels=osgclass=gpu,gputype=t4 --machine-type "n1-standard-4" --accelerator "type=nvidia-tesla-t4,count=1" --num-nodes=1 --spot
