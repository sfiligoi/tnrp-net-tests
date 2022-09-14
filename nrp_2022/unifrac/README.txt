Create configmap
================
kubectl create configmap unifrac-nrp-script -n isfiligoi --from-file=run_50k.sh --from-file=run_50k_wn.sh --from-file=run_300k.sh --from-file=run_300k_2.sh

Run test
========
kubectl create -n isfiligoi -f unifrac_nrp_50k.yaml
kubectl create -n isfiligoi -f unifrac_nrp_300k.yaml
# optional
kubectl create -n isfiligoi -f unifrac_nrp_50k_wn.yaml
kubectl create -n isfiligoi -f unifrac_nrp_300k_2.yaml

Retrieve results
================
kubectl get pods -n isfiligoi -o wide |grep unifrac-nrp
kubectl logs -n isfiligoi <icecube-nrp-*>
