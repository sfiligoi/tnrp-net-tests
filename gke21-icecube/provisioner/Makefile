.PHONY: configmap 

all: configmap

configmap:
	-kubectl delete configmap osg-provisioner-config 
	kubectl create configmap osg-provisioner-config --from-file=provisioner_startup.sh=provisioner_startup.sh --from-file=provisioner_k8s.py=provisioner_k8s.py

