#!/bin/bash
az vmss scale  --resource-group test-net --name prp-condor-wn-useast  --new-capacity "$1"
