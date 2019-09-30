#!/usr/bin/env python

import sys, os

if len(sys.argv) != 2:
   print("Usage: digest_one.py <dir>")
   sys.exit(1)

dname=sys.argv[1]
if not os.path.isdir(dname):
   print("ERROR: %s is not a dir"%dname)
   sys.exit(1)

# First find all the files
jobs={}
for f in os.listdir("%s/err"%dname):
  if (not f.startswith("data.")) or (not f.endswith(".err")):
     print("INFO: Skipping %s"%f)
     continue
  farr=f.split(".")
  if len(farr)!=4:
     print("WARN: Unexpected %s (%i)"%(f,len(farr)))
     continue

  cluster=int(farr[1])
  process=int(farr[2])

  if not os.path.isfile("%s/out/data.%i.%i.out"%(dname, cluster, process)):
     print("WARN: Missing %s/out/data.%i.%i.out"%(dname, cluster, process))
     continue

  if cluster not in jobs.keys():
      jobs[cluster]=[]

  jobs[cluster].append(process)

digested={}
for cluster in jobs.keys():
   digested[cluster]={}

   processes = jobs[cluster]

   for process in processes:
      with open("%s/out/data.%i.%i.out"%(dname, cluster, process),"r") as fd:
         lines=fd.readlines()
      nlines=len(lines)
      nl=0
      tprev=0
      rcprev=1
      while (nl<nlines):
         # first look for start date
         line = lines[nl]
         nl = nl + 1
         if line.find("centos")>=0:
            #print("DEBUG: Skipping, ls %s"%line)
            continue # ls output
         linearr=line.split(":")
         if (len(linearr)!=3):
            #print("DEBUG: Skipping, not date %s"%line)
            continue # not a date
        
         h=int(linearr[0].rsplit(" ",1)[-1])
         m=int(linearr[1])
         s=int(linearr[2].split(" ",1)[0])
         t=(h*60+m)*60+s
         #print("DEBUG: Date %i:%i:%i"%(h,m,s))


         if tprev>0:
           dt=t-tprev + 1 # rounding up
           if dt<0: # wraparound
             dt = dt + (24*3600) 
           if (rcprev==0):
              # contributed an equal fraction to each second
              dtb=1.0/dt
              for it in range(t-dt+1,t+1):
                 if it not in digested[cluster].keys():
                    digested[cluster][it] = dtb
                 else:
                    digested[cluster][it] = digested[cluster][it]  + dtb

         tprev = t

         if nl==nlines:
            break # end of file
         line = lines[nl]
         if not line.startswith("RC "):
            print("WARN: Found date not followed by RC")
            rcprev=1
            continue

         if line != "RC 0\n":
            print("INFO: Skipping bad RC (%s)"%line)
            rcprev=1
            continue
         rcprev=0

# average over 5s
digested5={}
for cluster in digested.keys():
   tdata = digested[cluster]
   tdata5={}
   digested5[cluster] = tdata5
   for t in tdata.keys():
     t5 = int(t / 5) * 5
     v5 = tdata[t] / 5.0
     if t5 not in tdata5.keys():
        tdata5[t5] = v5
     else:
        tdata5[t5] = tdata5[t5] + v5

#
# DEBUG
#clusters = list(digested5.keys())
#clusters.sort()
#for cluster in clusters:
#   print("Cluster %i"%cluster)
#   tdata = digested5[cluster]
#   ts=list(tdata.keys())
#   ts.sort()
#   for t in ts:
#      print("   %i: %.1f"%(t,tdata[t]))

#print(digested)

for cluster in digested5.keys():
   with open("digested.%i.out"%cluster,"w") as fd:
     fd.write("# Number of 1 GB files per second, averaged over 5s, over time\n")
     tdata = digested5[cluster]
     ts=list(tdata.keys())
     ts.sort() 
     for t in ts:
        fd.write("%.3f\n"%tdata[t])
     fd.write("# max: %0.3f\n"%max(tdata.values()))

with open("digested_max.out","w") as fd:
   fd.write("# Number of 1 GB files per second, averaged over 5s, max per trial\n")
   clusters = list(digested5.keys())
   clusters.sort()
   for cluster in clusters:
      tdata = digested5[cluster]
      fd.write("%i: %0.3f\n"%(cluster,max(tdata.values())))

