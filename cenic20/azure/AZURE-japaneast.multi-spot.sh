#!/bin/bash
az vmss scale  --resource-group test-net --name prp-condor-wn-apjp  --new-capacity "$1"
