#!/bin/bash
az vmss scale  --no-wait --resource-group test-net --name prp-condor-wn-euuk  --new-capacity 0
