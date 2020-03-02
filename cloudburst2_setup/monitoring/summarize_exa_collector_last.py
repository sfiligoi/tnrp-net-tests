#!/bin/env python

import sys,os,string

lines=sys.stdin.readlines()

lastl=lines[-1]
lastt=lastl.split()[0]

data={'Total':{'true Busy':{'cnt':0,'flops':0.0}}}

for line in lines:
  if not line.startswith(lastt):
    continue # keep only last timestamp

  larr=line.split()

  if int(larr[9])<1:
    continue # skip cpu-only nodes

  k2="%s %s"%(larr[2],larr[3])

  c=int(larr[1])
  f=float(larr[10])

  for k1 in ['Total',larr[4]]:
    if k1 not in data.keys():
      data[k1]={}
    if k2 not in data[k1].keys():
      data[k1][k2]={'cnt':0,'flops':0.0}

    data[k1][k2]['cnt']+=c
    data[k1][k2]['flops']+=f

k1lst=data.keys()
k1lst.sort()

print("# Timestamp Fresh Actv Prov Count TFLOP32s")
for k1 in k1lst:
  k2lst=data[k1].keys()
  k2lst.sort()
  for k2 in k2lst:
    print("%s %s %s %i %.1f"%(lastt,k2,k1,data[k1][k2]['cnt'],data[k1][k2]['flops']))

