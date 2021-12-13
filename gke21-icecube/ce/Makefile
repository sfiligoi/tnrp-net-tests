.PHONY: secret_pool configmap 

all: configmap

secret_pool: pool_password
	#kubectl delete secret osg-pool-config
	kubectl create secret generic osg-pool-config --from-file=pool_password

configmap:
	-kubectl delete configmap osg-ce-config 
	kubectl create configmap osg-ce-config --from-file=01-squid.ini=config/01-squid.ini --from-file=10-storage.ini=config/10-storage.ini --from-file=20-condor.ini=config/20-condor.ini \
            --from-file=30-gip.ini=config/30-gip.ini --from-file=35-pilot.ini=config/35-pilot.ini --from-file=40-siteinfo.ini=config/40-siteinfo.ini \
            --from-file=80_pod_init.sh=80_pod_init.sh

