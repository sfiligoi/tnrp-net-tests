#!/bin/bash
gcloud compute instance-groups managed resize tnrp-condor-wn-us-central --region=us-central1 --size=0 -q
