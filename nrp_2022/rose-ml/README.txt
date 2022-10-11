Create configmap
================
kubectl create configmap rose-nrp-script -n isfiligoi --from-file=run_test.sh

Run test
========
kubectl create -n isfiligoi -f ml_nrp_8.yaml
kubectl create -n isfiligoi -f ml_nrp_4.yaml

Retrieve results
================
kubectl get pods -n isfiligoi -o wide |grep rose-ml-nrp
kubectl logs -n isfiligoi <rose-ml-nrp-*>
