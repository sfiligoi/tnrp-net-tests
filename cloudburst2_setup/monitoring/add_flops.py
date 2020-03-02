#!/bin/env python

import os,sys,string

# gpu flop32s
gflops={}

# just a wild guess...
gflops['undefined']= 4.75
gflops['No devices were found'] = 0.0


gflops['GeForce GTX 1070']= 6.0
gflops['GeForce GTX 1080']= 8.2
gflops['GeForce GTX 1080 Ti']= 10.6
gflops['GeForce RTX 2080 Ti']= 11.8
gflops['GeForce GTX 980']= 4.6

gflops['TITAN Xp']= 10.8
gflops['TITAN X (Pascal)']= gflops['TITAN Xp']
gflops['GeForce GTX TITAN']= 6.1

gflops['Tesla K20m']= 3.5
gflops['Tesla K40m']= 5.0
gflops['Tesla K40c']= 5.0
gflops['Tesla P100-PCIE-12GB']= 9.3

gflops['Tesla T4']= 8.1
gflops['Tesla P40']= 11.8
gflops['Tesla V100-PCIE-16GB']= 14.0
gflops['Tesla V100-SXM2-16GB']= 14.9
gflops['Tesla V100-SXM2-32GB']= 14.9


gflops['Tesla K80']= 4.3
gflops['Tesla M60']= 4.8
gflops['Tesla P100-PCIE-16GB']= 9.3
gflops['Tesla P4'] =5.4

# read from stdline and write out to stdout

lines=sys.stdin.readlines()
for line in lines:
 if line[0]=="#":
   sys.stdout.write("# Timestamp Count   Fresh Actv Prov GEO    Region    DataRegion  CPUs GPUs TFLOP32s GPUType\n")
 else:
   larr=line.split(" ",10)

   cnt=int(larr[1])*int(larr[9])
   gtypestr=larr[10].strip()
   gtype=gtypestr.split(",")[0] # just in case there is a list

   if cnt>0:
     if gtype in gflops.keys():
       flop=gflops[gtype]
     else:
       sys.stderr.write("WARNING: Unknown GPU type '%s'\n"%gtype)
       flop=4.65 # another wild guess
   else:
     flop=0 # do not count cpus

   nline=string.join(larr[:10]," ")+(" %.1f %s"%(flop*cnt,gtype))
   sys.stdout.write("%s\n"%nline)

