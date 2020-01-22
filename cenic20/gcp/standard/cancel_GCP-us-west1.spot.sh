#!/bin/bash
gcloud compute instance-groups managed resize tnrp-condor-wn-us-west1-regnet --region=us-west1 --size=0 -q
