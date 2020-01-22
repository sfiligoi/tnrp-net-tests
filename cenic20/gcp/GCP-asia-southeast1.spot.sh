#!/bin/bash
gcloud compute instance-groups managed resize  tnrp-condor-wn-ap-se1 --region=asia-southeast1 --size=1 -q
