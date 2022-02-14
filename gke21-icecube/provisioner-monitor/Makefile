.PHONY: configmap

all: configmap

configmap:
	-kubectl delete configmap gke-monitor-config
	kubectl create configmap gke-monitor-config --from-file=provisioner_main.py=provisioner_main.py

