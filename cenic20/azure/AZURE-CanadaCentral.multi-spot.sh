#!/bin/bash
az vmss scale --resource-group test-net --name prp-condor-wn-ca  --new-capacity "$1"
