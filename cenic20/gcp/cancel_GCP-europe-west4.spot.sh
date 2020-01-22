#!/bin/bash
gcloud compute instance-groups managed resize  tnrp-condor-wn-eu-west4 --region=europe-west4 --size=0 -q
