#!/bin/bash

# install some missing packages
apt-get update
apt-get install --yes python less

# add the expected users
useradd -s /bin/bash -m cgyro
useradd -s /bin/bash -m nrpuser

# add missing NVIDIA tools
cd /root
apt-get download nvidia-compute-utils-515
dpkg --force-all -i nvidia-compute-utils-515_515.76+really.515.65.01-0ubuntu0.20.04.1_amd64.deb

