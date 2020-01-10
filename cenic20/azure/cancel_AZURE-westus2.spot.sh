#!/bin/bash
az vmss scale  --no-wait --resource-group test-net --name prp-condor-wn-uswest2  --new-capacity 0
