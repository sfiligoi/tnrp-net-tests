#!/bin/bash
az vmss scale  --resource-group test-net --name prp-condor-wn-apse  --new-capacity $1
