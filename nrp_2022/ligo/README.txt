Create configmap
================
kubectl create configmap ligo-nrp-script -n isfiligoi --from-file=run_test.sh

Run test
========
kubectl create -n isfiligoi -f ligo_nrp.yaml

Retrieve results
================
kubectl get pods -n isfiligoi -o wide |grep ligo-nrp
kubectl logs -n isfiligoi <ligo-nrp-*>
