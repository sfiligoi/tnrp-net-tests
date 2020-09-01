.PHONY: configmap

configmap:
	-kubectl delete secret gftp -n isfiligoi
	kubectl create secret generic gftp -n isfiligoi \
          --from-file=hostcert.pem \
          --from-file=hostkey.pem \
          --from-file=grid-mapfile \
          --from-file=80_pod_init.sh
	# kubectl create secret generic gftp -n isfiligoi \
          --from-file=hostcert.pem \
          --from-file=hostkey.pem \
          --from-file=grid-mapfile \
          --from-file=80_pod_init.sh \
          -o yaml --dry-run |kubectl replace -f -
