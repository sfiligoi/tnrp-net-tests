Create configmap
================
kubectl create configmap setup-scripts -n fusion-psfc --from-file=setup_node.sh
kubectl create configmap batch-scripts -n fusion-psfc --from-file=batch_run_8.sh

Create PVCs
===========
kubectl create -f pvc_sw.yaml 
kubectl create -f pvc_data.yaml 
