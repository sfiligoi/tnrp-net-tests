#!/bin/bash
gcloud compute instance-groups managed resize  tnrp-condor-wn-ap-ne1 --region=asia-northeast1 --size=1 -q
