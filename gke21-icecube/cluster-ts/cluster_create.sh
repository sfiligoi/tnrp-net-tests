gcloud beta container clusters create "icecube-ts" --zone "us-central1-c" --cluster-version "1.23.2-gke.300" --release-channel "rapid" --spot

# this will be needed by the gpu nodes
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/container-engine-accelerators/master/nvidia-driver-installer/cos/daemonset-preloaded.yaml


# 1.23.2 deprecated, use the updated version
gcloud beta container clusters create "icecube-ts-2" --zone "us-central1-c" --cluster-version "1.23.3-gke.1100" --release-channel "rapid" --spot
kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/container-engine-accelerators/master/nvidia-driver-installer/cos/daemonset-preloaded.yaml

