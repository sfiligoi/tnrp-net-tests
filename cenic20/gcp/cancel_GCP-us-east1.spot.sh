#!/bin/bash
gcloud compute instance-groups managed resize tnrp-condor-wn-us-east1 --region=us-east1 --size=0 -q
