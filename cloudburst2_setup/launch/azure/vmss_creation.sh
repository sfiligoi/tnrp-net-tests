#!/bin/bash

export AZ_SSH="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIi6sHuPqcx4J0pLiXSnLGRSlnILReeaff9gGCm0zKiqHVeZ6RPo2gbYKDBzVgDJcqOftjp/Mcg30YIDX1ei42W2WRHx/ewuK+09qejjAuo389ySByS6mI/emu2HhdvYMb07nhycdyK45xXYM6wla6hfQIrNccAKfPCWGdlc/FNxW5ffBFrm7AM9yMCXc95XkuRBto1oaySTYEr3FGYw2U8FfRmmnL/U7xI7zKR4OeWRn8KlaQyABybQ8h5a6T6ISjxmUoSL1MIWPlfNuxZ5djEoCIrtuhPeXW5dxlPrJCdSiBHQcAhsqQD1oyCIz60QCj9xJOjdx4ENXqlkFLPBw9 isfiligoi@wireless-169-228-82-29.ucsd.edu"

export AZ_SUB=/subscriptions/1b46e70e-9c7a-463d-8bce-6450c0cd15a3/resourceGroups/exa/providers/Microsoft

export AZ_STD_ARGS="--admin-username centos --authentication-type ssh --ssh-key-values \"${AZ_SSH}\"
                   --priority spot --public-ip-per-vm --upgrade-policy-mode manual --lb \"\"
                   --disable-overprovision --eviction-policy delete 
                   --assign-identity ${AZ_SUB}.ManagedIdentity/userAssignedIdentities/blob-writer
                   --image ${AZ_SUB}.Compute/galleries/galery_uswest2/images/wn-wgpu-v8"

eval az vmss create --resource-group exa --name exa-v8-westeurope-p40 \
               --location westeurope \
               --vm-sku "Standard_ND6s" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/eu-west-all \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-eu-west-64k/subnets/subnet-eu-west-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0 # no zones

eval az vmss create --resource-group exa --name exa-v8-westeurope-v100 \
               --location westeurope \
               --vm-sku "Standard_NC6s_v3" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/eu-west-all \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-eu-west-64k/subnets/subnet-eu-west-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0 # no zones


eval az vmss create --resource-group exa --name exa-v8-eastus-p40 \
               --location eastus \
               --vm-sku "Standard_ND6s" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/us-east1-all-in \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-us-east1-64k/subnets/subnet-us-east1-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0 # no zones

eval az vmss create --resource-group exa --name exa-v8-eastus-v100 \
               --location eastus \
               --vm-sku "Standard_NC6s_v3" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/us-east1-all-in \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-us-east1-64k/subnets/subnet-us-east1-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0 # no zones

eval az vmss create --resource-group exa --name exa-v8-southeastasia-p40 \
               --location southeastasia \
               --vm-sku "Standard_ND6s" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/ap-se-all \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-ap-se-64k/subnets/subnet-ap-se-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0 # no zones

eval az vmss create --resource-group exa --name exa-v8-southeastasia-v100 \
               --location southeastasia \
               --vm-sku "Standard_NC6s_v3" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/ap-se-all \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-ap-se-64k/subnets/subnet-ap-se-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0 # no zones

eval az vmss create --resource-group exa --name exa-v8-westus2-p40  \
               --location westus2 \
               --vm-sku "Standard_ND6s" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/us-west2-all-in \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-us-west2-64k/subnets/subnet-us-west2-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0 # nozones

eval az vmss create --resource-group exa --name exa-v8-westus2-v100  \
               --location westus2 \
               --vm-sku "Standard_NC6s_v3" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/us-west2-all-in \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-us-west2-64k/subnets/subnet-us-west2-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0 # nozones

eval az vmss create --resource-group exa --name exa-v8-southcentralus-v100 \
               --location southcentralus \
               --vm-sku "Standard_NC6s_v3" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/nc-sc-all \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-us-sc-64k/subnets/subnet-us-sc-64k \
               ${AZ_STD_ARGS} --instance-count 0 # no zones

eval az vmss create --resource-group exa --name exa-v8-uksouth-v100 \
               --location uksouth \
               --vm-sku "Standard_NC6s_v3" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/uk-south-all \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-uk-south-64k/subnets/subnet-uk-south-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0

eval az vmss create --resource-group exa --name exa-v8-japaneast-v100 \
               --location japaneast \
               --vm-sku "Standard_NC6s_v3" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/ap-jp-all \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-ap-jp-64k/subnets/subnet-ap-jp-64k \
               --single-placement-group false \
               ${AZ_STD_ARGS} --instance-count 0

eval az vmss create --resource-group exa --name exa-v8-australiaeast-v100 \
               --location australiaeast \
               --vm-sku "Standard_NC6s_v3" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/ap-au-all \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-ap-au-64k/subnets/subnet-ap-au-64k \
               ${AZ_STD_ARGS} --instance-count 0 # no zones

eval az vmss create --resource-group exa --name exa-v8-CanadaCentral-v100 \
               --location canadacentral \
               --vm-sku "Standard_NC6s_v3" \
               --nsg ${AZ_SUB}.Network/networkSecurityGroups/canada-all \
               --subnet ${AZ_SUB}.Network/virtualNetworks/net-canada-64k/subnets/subnet-canada-64k \
               ${AZ_STD_ARGS} --instance-count 0 # no zones

