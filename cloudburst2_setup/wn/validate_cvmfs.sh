#!/bin/bash

set -e

ls -l /cvmfs/icecube.opensciencegrid.org/data/corsika/corsika-76900g/bin/corsika76900gLinux_SIBYLL_gheisha|grep 8513432

ls /cvmfs/icecube.opensciencegrid.org/py2-v3.0.1/RHEL_7_x86_64/metaprojects/simulation/V06-01-02|grep env-shell.sh

eval $(/cvmfs/icecube.opensciencegrid.org/iceprod/master/setup.sh)
python -m iceprod.core.i3exec -h

echo "CVMFS OK"
