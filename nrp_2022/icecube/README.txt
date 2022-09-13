Create configmap
================
kubectl create configmap icecube-nrp-script -n osg-icecube --from-file=run_test.sh --from-file=run_benchmark.sh

Run test
========
kubectl create -n osg-icecube -f icecube_nrp.yaml
# optional
kubectl create -n osg-icecube -f icecube_nrp_benchmark.yaml

Retrieve results
================
kubectl get pods -n osg-icecube -o wide |grep icecube-nrp
kubectl logs -n osg-icecube <icecube-nrp-*>
