#!/bin/env python

import sys

bucket=int(sys.argv[1])

fnames=sys.argv[2:]


#
# Get file sizes
#

fsizes={}

for fname in fnames:
  with open(fname,"r") as fd:
    lines=fd.readlines()
  for line in lines:
    larr=line.split('nobody')
    if len(larr)!=3:
      continue

    # '-rw-r--r-- 1 nobody nobody 44962448 Jan 23 19:38 corsika.020904.307841.i3.zst'
    tfname=larr[2].rsplit(' ',1)[1].strip()
    tfsize=int(larr[2].split()[0])/(1024*1024.0)
    # print(tfname,tfsize)
    fsizes[tfname]=tfsize

#
# Parse logs to get the list of files, in timeseries
#
completed={}
clients={}

for fname in fnames:
  with open(fname,"r") as fd:
    lines=fd.readlines()
  for line in lines:
    larr=line.split('NOTICE')
    if len(larr)!=2:
      continue

    # '2020-01-21 10:12:52.871902 [NOTICE] ...'
    ftime=larr[0].split(' ')[1]
    iftime=((int(ftime.split(':')[0])*60+int(ftime.split(':')[1]))*60+int(ftime.split(':')[2].split('.')[0]))

    # '2020-01-16 17:49:33.465586 [NOTICE] [Context.cc:311] Downloading 24 item(s)'
    larr=line.split('Downloading')
    if len(larr)==2:
      # let's assume all further downloads go in parallel
      iftime_start=iftime
      continue

    larr=line.split('Download complete: ')
    if len(larr)!=2:
      continue
    
    # '2020-01-21 10:12:52.871902 [NOTICE] [RequestGroup.cc:1216] Download complete: /dev/shm/dir_2511/tmp/subdir_0/corsika.020904.370189.i3.zst'
    fname=larr[1].strip().rsplit('/',1)[1] 
    fsize=fsizes[fname]  
    #print(ftime,iftime,fname,fsize)

    if iftime_start!=iftime:
      fsizedt=fsize*1.0/(iftime-iftime_start)
      #print(ftime,iftime_start,iftime,fname,fsize,fsizedt)

      for t in range(iftime_start+1,iftime+1):
        if t not in completed.keys():
          completed[t]=0.0
        completed[t] += fsizedt
        if t not in clients.keys():
          clients[t]=0
        clients[t] += 1
    else:
      # within the second, count as a second
      sizedt=fsize*1.0
      t=iftime
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
    compsize[iftimeb] += completed[t]/bucket
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
  print("t: %5i %6i %i"%(t-t0,compsize[t],clisize[t]))

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
