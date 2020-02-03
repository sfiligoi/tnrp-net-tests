#!/bin/bash
for n in exa-v8-westeurope-p40 exa-v8-westeurope-v100 exa-v8-eastus-p40 exa-v8-eastus-v100 exa-v8-southeastasia-p40 exa-v8-southeastasia-v100 exa-v8-westus2-p40 exa-v8-westus2-v100 exa-v8-southcentralus-v100 exa-v8-uksouth-v100 exa-v8-japaneast-v100 exa-v8-australiaeast-v100 exa-v8-CanadaCentral-v100; do 
  az vmss scale  --resource-group exa --no-wait --name $n --new-capacity="$1"
done
