#!/bin/env python

import os,sys,string

# gpu flop32s
gflops={}
rtime={}

# just a wild guess...
gflops['undefined']= 4.75
gflops['No devices were found'] = 0.0

rtime['undefined']= 1000
rtime['No devices were found'] = 1000


gflops['Tesla P100-PCIE-12GB']= 9.3
gflops['Tesla P100-PCIE-16GB']= 9.3

rtime['Tesla P100-PCIE-12GB']= 2100
rtime['Tesla P100-PCIE-16GB']= 2100

gflops['Tesla T4']= 8.1
gflops['Tesla P40']= 11.8

rtime['Tesla T4']= 2300
rtime['Tesla P40']= 2000

gflops['Tesla V100-PCIE-16GB']= 14.0
gflops['Tesla V100-SXM2-16GB']= 14.9
gflops['Tesla V100-SXM2-32GB']= 14.9

rtime['Tesla V100-PCIE-16GB']= 1800
rtime['Tesla V100-SXM2-16GB']= 1800
rtime['Tesla V100-SXM2-32GB']= 1800

osize= 2500.0

# read from stdline and write out to stdout

lines=sys.stdin.readlines()
for line in lines:
 if line[0]=="#":
   sys.stdout.write("# Timestamp Count   Fresh Actv Prov GEO    Region    CPUs GPUs Mbps TFLOP32s GPUType\n")
 else:
   larr=line.split(" ",9)

   cnt=int(larr[1])*int(larr[8])
   gtypestr=larr[9].strip()
   gtype=gtypestr.split(",")[0] # just in case there is a list

   if cnt>0:
     if gtype in gflops.keys():
       flop=gflops[gtype]
     else:
       sys.stderr.write("WARNING: Unknown GPU type '%s'\n"%gtype)
       flop=4.65 # another wild guess
     if gtype in rtime.keys():
       mbps=osize/rtime[gtype]
     else:
       sys.stderr.write("WARNING: Unknown GPU type '%s'\n"%gtype)
       mbps= osize/2000 # another wild guess
   else:
     flop=0.0
     mbps=0.0

   nline=string.join(larr[:9]," ")+(" %.1f %.1f %s"%(mbps*cnt,flop*cnt,gtype))
   sys.stdout.write("%s\n"%nline)

