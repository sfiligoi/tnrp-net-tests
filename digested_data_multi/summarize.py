#!/usr/bin/env python

import sys,os


max_only=False
if len(sys.argv)>1:
   if sys.argv[1]=='-max':
     max_only = True
   else:
     print("ERROR: Unknown option, only -max supported")
     sys.exit(1)

def parse_digested(outlist, fname):
   with open(fname,"r") as fd:
     lines = fd.readlines()

   for line in lines:
     if line.startswith("#"):
       continue # ignore comments

     sarr=line.split()
     if len(sarr)<2:
       print("WARN: cound not split (%s)"%line)
       continue

     outlist.append(float(sarr[1] ))

data={}
for topdir in os.listdir("."):
   if not os.path.isdir(topdir):
     continue # we just look for dirs

   dirdata={}

   for subdir in os.listdir(topdir):
      dname="%s/%s/digested_max.out"%(topdir,subdir)
      if not os.path.isfile(dname):
        continue # not a digested dir

      sdarr = subdir.rsplit("_",1)
      sdgrp=sdarr[0]
      sdval=sdarr[1]

      if sdgrp not in dirdata.keys():
        dirdata[sdgrp] = []

      parse_digested(dirdata[sdgrp],dname)


   if len(dirdata.keys())==0:
      continue # ignore empty top dirs

   data[topdir] = dirdata


#print(data)

if (max_only):
       print("%-16s %-16s : %s"%("# Source_Dest","Test","Number of 1 GB files per second, averaged over 5s, max per test"))
else:
       print("%-16s %-16s : %s"%("# Source_Dest","Test","Number of 1 GB files per second, averaged over 5s, all trials"))


tds = list(data.keys())
tds.sort()
for topdir in tds:
   dirdata=data[topdir]
   sdgs=list(dirdata.keys())
   sdgs.sort()
   for sgroup in sdgs:
     els = dirdata[sgroup]
     els.sort(reverse=True)

     if (max_only):
       print("%-16s %-16s : %8.3f"%(topdir, sgroup, els[0]))
     else:
       print("%-16s %-16s : %s"%(topdir, sgroup, els))

