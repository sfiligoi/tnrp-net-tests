.PHONY: secret_pool secret_s3

all: 

secret_pool:
	#kubectl delete secret exa-pool-secret -n isfiligoi
	kubectl create secret generic exa-pool-secret -n isfiligoi --from-file=POOL


secret_s3:
	#kubectl delete secret exa-s3 -n isfiligoi
	kubectl create secret generic exa-s3 -n isfiligoi --from-file=.s3cfg
