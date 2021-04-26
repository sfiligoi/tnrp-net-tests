#!/usr/bin/python

import os,sys

data={'Total':0,'AWS':0,'GCP':0,'AZURE':0,'Claimed':0,'Unclaimed':0,'Other':0, 'Old':0}

lines=os.popen("./get_col_snapshot.sh").readlines()
for line in lines:
  larr=line.strip().split()
  try:
    cnt=int(larr[0])
    status=larr[1]
    cloud=larr[2]
    valid=larr[3]=='true'
    data[cloud]+=cnt
    data['Total']+=cnt
    if status in data.keys():
       data[status]+=cnt
    else:
       data['Other']+=cnt
    if not valid:
       data['Old']+=cnt
    #print([cnt,status,cloud,valid])
  except:
    sys.stderr.write("Bad line: %s\n"%line.strip())

outstr=[]
for i in ['Total','AWS','GCP','AZURE','Claimed','Unclaimed','Other', 'Old']:
  outstr.append("%s: %i"%(i,data[i]))
print(" ".join(outstr))
