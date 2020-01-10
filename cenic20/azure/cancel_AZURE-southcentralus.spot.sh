#!/bin/bash
az vmss scale  --no-wait --resource-group test-net --name prp-condor-wn-ussouthcentral  --new-capacity 0
