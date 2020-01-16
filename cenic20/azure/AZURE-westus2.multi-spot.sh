#!/bin/bash
az vmss scale --resource-group test-net --name prp-condor-wn-uswest2  --new-capacity "$1"
