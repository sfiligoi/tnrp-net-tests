#!/bin/bash
az vmss scale --resource-group test-net --name prp-condor-wn-euwest  --new-capacity "$1"
