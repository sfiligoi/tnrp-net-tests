#!/bin/bash
gcloud compute instance-groups managed resize  tnrp-condor-wn-ap-east1 --region=asia-east1 --size=1 -q
