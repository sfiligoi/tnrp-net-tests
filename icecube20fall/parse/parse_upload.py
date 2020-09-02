#!/bin/env python

import sys

bucket=int(sys.argv[1])

fnames=sys.argv[2:]


#
# Parse logs to get the list of files, in timeseries
#
completed={}
clients={}

#SUCCESS: At 1595616425330 uploaded 516 MB in 9904 ms
for fname in fnames:
  with open(fname,"r") as fd:
    lines=fd.readlines()
  for line in lines:
    larr=line.strip().split()
    if len(larr)!=9 or larr[0]!='SUCCESS:' or larr[-1]!='ms':
      continue

    iftime=int(int(larr[2])/100) # in 1/10th of a second
    fsize=int(larr[4])
    dt100=int(larr[-2])
    dt=int(dt100/100) # in 1/10th of a second
    fsizedt=fsize*100.0/dt100

    for t in range(iftime-dt,iftime):
        if t not in completed.keys():
          completed[t]=0.0
        completed[t] += fsizedt
        if t not in clients.keys():
          clients[t]=0
        clients[t] += 1

#
# Now put in buckets
#

compsize={}
clisize={}

for t in completed.keys():
    # insert into buckets
    iftimeb=(t/(bucket))*bucket
    if iftimeb not in compsize.keys():
      compsize[iftimeb]=0.0
    compsize[iftimeb] += 10.0*completed[t]/bucket
    if iftimeb not in clisize.keys():
      clisize[iftimeb]=0.0
    clisize[iftimeb] += clients[t]*1.0/bucket


tkeys=list(compsize.keys())
tkeys.sort()

# first and last element are partial, so remove them
del compsize[tkeys[0]]
del compsize[tkeys[-1]]


#
# Now print out
#

def median(lst):
    n = len(lst)
    s = sorted(lst)
    return (sum(s[n//2-1:n//2+1])/2.0, s[n//2])[n % 2] if n else None

def mean(numbers):
    return sum(numbers) / max(len(numbers), 1)

tkeys=list(compsize.keys())
tkeys.sort()
t0=tkeys[0]
for t in tkeys:
  print("t: %5.1f %6i %i"%((t-t0)*0.1,compsize[t],clisize[t]))

top5=list(compsize.values())
top5.sort(reverse=True)
top5=top5[:5]

print("max: %i"%top5[0])
print("top5: %s"%[int(i) for i in top5])
print("top5 mean: %i"%mean(top5))
print("top5 median: %i"%median(top5))
print("===")
print("mean: %i"%mean(compsize.values()))
print("median: %i"%median(compsize.values()))
