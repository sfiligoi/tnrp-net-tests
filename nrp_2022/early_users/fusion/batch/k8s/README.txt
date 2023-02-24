Batch use
=========

This folder contains an example batch yaml file.
It will run/resume a test simulation that lasts a few minutes.

Actual user steps
=================

1)
Using one of the login yamls, create the input files in the /data/nrpuser/... area.
Make sure the area is owned by "nrpuser" .

2)
Make a copy of the example batch yaml and
a) change the name to something unique,
b) update the command line arguments to point to the directory containing the input files

3)
Create the batch job using
kubectl create -f <filename>


Job monitoring
==============

The stdout and stderr are available using
kubectl logs -n fusion-psfc <pod name>

Once the pod starts, you can
kubectl exec -n fusion-psfc <pod name> -it -- /bin/bash
into it.

After the pod terminates, you need to start a login pod to inspect the data.

Killing the job
===============

In case of troubles, you can kill the job by using
kubectl delete -f <filename>

