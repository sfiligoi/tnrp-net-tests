#!/bin/bash
gcloud compute instance-groups managed resize tnrp-condor-wn-us-east1-regnet --region=us-east1 --size=0 -q
