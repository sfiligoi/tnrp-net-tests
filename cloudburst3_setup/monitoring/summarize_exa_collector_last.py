#!/bin/env python

import sys,os,string

lines=sys.stdin.readlines()

lastl=lines[-1]
lastt=lastl.split()[0]

data={'Total Total':{'true Busy':{'cnt':0,'mbps':0.0,'flops':0.0}}}

k2lst=[]

for line in lines:
  if not line.startswith(lastt):
    continue # keep only last timestamp

  larr=line.split()

  if int(larr[8])<1:
    continue # skip cpu-only nodes

  k2="%s %s"%(larr[2],larr[3])
  if k2 not in k2lst:
    k2lst.append(k2)

  c=int(larr[1])
  m=float(larr[9])
  f=float(larr[10])

  for k1 in ['Total Total',"%s %s"%(larr[5],larr[6])]:
    if k1 not in data.keys():
      data[k1]={}
    if k2 not in data[k1].keys():
      data[k1][k2]={'cnt':0,'mbps':0.0,'flops':0.0}

    data[k1][k2]['cnt']+=c
    data[k1][k2]['mbps']+=m
    data[k1][k2]['flops']+=f

k1lst=data.keys()
k1lst.sort()
k2lst.sort()

print("# Timestamp Fresh Actv Sink Region Count Mbps TFLOP32s")
for k2 in k2lst:
  for k1 in k1lst:
    if k2 in data[k1].keys():
      print("%s %s %s %i %.1f %.1f"%(lastt,k2,k1,data[k1][k2]['cnt'],data[k1][k2]['mbps'],data[k1][k2]['flops']))

