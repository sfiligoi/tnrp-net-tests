#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Wrong number of arguments ($#)" 1>&2
  echo "Usage:" 1>&2
  echo " batch_run_8.sh basedir chyro_case"
  exit 1
fi

/root/setup_node.sh

su -l nrpuser -c "source /opt/fusion/software/cgyro/setup_ga.sh; cd \"$1\" && cgyro -p . -e \"$2\" -n 8 -nomp 16"

