Create configmap
================
kubectl create configmap icecube-nrp-script -n osg-icecube --from-file=run_test.sh

Run test
========
kubectl create -n osg-icecube -f icecube_nrp.yaml

Retrieve results
================
kubectl get pods -n osg-icecube -o wide |grep nrp-test
kubectl logs -n osg-icecube <icecube-nrp-*>
