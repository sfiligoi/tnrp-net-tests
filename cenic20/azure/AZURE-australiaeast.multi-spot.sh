#!/bin/bash
az vmss scale  --resource-group test-net --name prp-condor-wn-apau  --new-capacity "$1"
