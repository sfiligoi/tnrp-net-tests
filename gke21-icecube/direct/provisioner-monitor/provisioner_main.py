#
#  Monitor the gke pool
#  Reuse the python script name for ease of use
#

import sys,time
import kubernetes

kubernetes.config.load_incluster_config()
k8s = kubernetes.client.CoreV1Api()

def get_nodes():
  cntn = 0  # number of nodes
  cntg = 0  # number of gpus
  nlist = k8s.list_node(label_selector="osgclass=gpu")
  cntn = len(nlist.items)
  for i in range(cntn):
    try:
      cntg += int(nlist.items[i].status.capacity['nvidia.com/gpu'])
    except:
       pass # no gpu?
  return (cntn, cntg)

def get_pods():
  cntr = 0 # number of running
  cntp = 0 # number of pending
  plist = k8s.list_namespaced_pod(namespace="gke-icecube",label_selector="prp-htcondor-portal=wn")
  nels = len(plist.items)
  for i in range(nels):
     phase = plist.items[i].status.phase
     if phase == "Pending":
       cntp += 1
     elif phase=="Running":
       cntr += 1
  return (cntr, cntp)

while True:
  try:
    (cntn, cntg) = get_nodes()
    (cntr, cntp) = get_pods()

    with open("/var/log/provisioner/logs/monitor/gke.log."+time.strftime("%Y%m%d"),"a") as fd:
      fd.write("%s (%i) Nodes: %i (gpus: %i ) Pods running: %i pending: %i\n"%(time.ctime(), time.time(), cntn, cntg, cntr, cntp))
  except:
    print("Moonitoring excpetion!")
  # sleep a bit
  time.sleep(60)

