Create configmap
================
kubectl create configmap setup-scripts -n fusion-psfc --from-file=setup_node.sh

Create PVCs
===========
kubectl create -f pvc_sw.yaml 
kubectl create -f pvc_data.yaml 
