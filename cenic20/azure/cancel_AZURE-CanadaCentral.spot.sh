#!/bin/bash
az vmss scale  --no-wait --resource-group test-net --name prp-condor-wn-ca  --new-capacity 0
