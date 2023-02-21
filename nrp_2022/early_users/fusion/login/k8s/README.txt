Interactive use
===============

Each of the two yaml can be used to launch a interactive/login pod in the NRP.
e.g.
kubectl create -f login-small.yaml

Usage
=====

1) Discover the actual pod name:
kubectl get pods -n fusion-psfc -o wide

2) Log into the node with
kubectl exec -n fusion-psfc  -it login-<whatever> -- /bin/bash

3) Inside the pod, switch to the right user and setup the environment
su - nrpuser
source /opt/fusion/software/cgyro/setup_ga.sh 

4) CGYRO is now in the path

5) The persistent area is available under
/data/nrpuser

The area is group owned, and each user should create its own name.

Note that the persistent disk area is relatively slow, and should not be used as the main work area.

