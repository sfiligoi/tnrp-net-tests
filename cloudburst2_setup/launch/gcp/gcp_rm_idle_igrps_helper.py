#
# Helper script for shutting down empty google vms
#

import sys,os,string,time

igliststr=sys.argv[1]
idleliststr=sys.argv[2]

iglist=igliststr.split()
idlelist=idleliststr.split()

outlist={}

for i in idlelist:
  iarr=i.rsplit("-",1)
  
  iid=iarr[0]

  found=False
  # simple double loop fo simplicity, should be fast enough
  for g in iglist:
    if g.startswith(iid):
      found=True
      break

  if not found:
    # ignore this enty
    #print("#INFO: Ignoring %s"%i)
    continue

  if g not in outlist.keys():
    outlist[g]=[]

  outlist[g].append(i)

now=time.time()
for k in outlist.keys():
  print "# found idle %s"%k

  region=string.join(k.split("-")[1:3],"-")


  if len(outlist[k])>50:
    print("# Truncating from %i to 50"%len(outlist[k]))
    outlist[k]=outlist[k][:50]
  cmd="gcloud compute instance-groups managed delete-instances %s --region=%s --instances=%s >> /opt/gcp_cmds/tmp/log_del_%s.log"%(k,region,string.join(outlist[k],","),k)
  print(cmd)
  os.system(cmd)

#print(outlist)

    

