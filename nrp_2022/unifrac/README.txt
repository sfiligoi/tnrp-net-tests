Create configmap
================
kubectl create configmap unifrac-nrp-script -n isfiligoi --from-file=run_50k.sh --from-file=run_50k_wn.sh

Run test
========
kubectl create -n isfiligoi -f unifrac_nrp_50k.yaml
# optional
kubectl create -n isfiligoi -f unifrac_nrp_50k_wn.yaml

Retrieve results
================
kubectl get pods -n isfiligoi -o wide |grep unifrac-nrp
kubectl logs -n isfiligoi <icecube-nrp-*>
