.PHONY: secret_s3

all: 

secret_s3:
	#kubectl delete secret exa-s3-ko -n isfiligoi
	kubectl create secret generic exa-s3-ko -n isfiligoi --from-file=.s3cfg --from-file=prp_local.config
