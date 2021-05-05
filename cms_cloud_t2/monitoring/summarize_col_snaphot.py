#!/usr/bin/python

import os,sys

data={'Total':0,'R1':0,'R2':0,'R3':0,'R4':0,'R5':0,'R6':0,'Claimed':0,'Unclaimed':0,'Other':0, 'Old':0}

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
for i in ['Total','R1','R2','R3','R4','R5','R6','Claimed','Unclaimed','Other', 'Old']:
  outstr.append("%s: %i"%(i,data[i]))
print(" ".join(outstr))
