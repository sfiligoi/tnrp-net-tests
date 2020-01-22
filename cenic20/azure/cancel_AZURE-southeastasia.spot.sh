#!/bin/bash
az vmss scale  --no-wait --resource-group test-net --name prp-condor-wn-apse  --new-capacity 0
