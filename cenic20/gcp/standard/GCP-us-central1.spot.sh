#!/bin/bash
gcloud compute instance-groups managed resize tnrp-condor-wn-us-central-regnet --region=us-central1 --size=1 -q
