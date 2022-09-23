Create configmap
================
kubectl create configmap unifrac-nrp-script -n isfiligoi --from-file=run_50k.sh --from-file=run_50k_wn.sh --from-file=run_300k.sh --from-file=run_300k_8.sh --from-file=run_300k_support.sh --from-file=run_300k_small.sh --from-file=run_300k_small_8.sh

Run test
========
kubectl create -n isfiligoi -f unifrac_nrp_50k.yaml
kubectl create -n isfiligoi -f unifrac_nrp_300k_serial.yaml
kubectl create -n isfiligoi -f unifrac_nrp_300k_8.yaml
# optional
kubectl create -n isfiligoi -f unifrac_nrp_50k_wn.yaml
kubectl create -n isfiligoi -f unifrac_nrp_300k_8.yaml

Retrieve results
================
kubectl get pods -n isfiligoi -o wide |grep unifrac-nrp
kubectl logs -n isfiligoi <icecube-nrp-*>
