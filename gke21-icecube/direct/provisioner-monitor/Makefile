.PHONY: configmap

all: configmap

configmap:
	-kubectl delete configmap -n gke-icecube gke-monitor-config
	kubectl create configmap -n gke-icecube gke-monitor-config --from-file=provisioner_main.py=provisioner_main.py

