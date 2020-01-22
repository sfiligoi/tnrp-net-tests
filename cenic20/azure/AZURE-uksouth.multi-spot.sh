#!/bin/bash
az vmss scale  --resource-group test-net --name prp-condor-wn-euuk  --new-capacity "$1"
