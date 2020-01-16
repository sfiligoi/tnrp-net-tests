#!/bin/bash
az vmss scale  --resource-group test-net --name prp-condor-wn-ussouthcentral  --new-capacity $1
