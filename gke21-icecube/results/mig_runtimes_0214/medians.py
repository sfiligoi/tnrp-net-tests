import sys
import statistics

with open(sys.argv[1],"r") as fd:
  lines=fd.readlines()

data={}
for line in lines[1:]:
  larr=line.strip().split(",")
  #print(larr)
  if len(larr)!=3:
    continue

  k=larr[1]
  val=int(larr[2])

  if k not in data:
    data[k]=[]
  data[k].append(val)

ks=list(data.keys())

print("#gpu, median, mean, jobs/day, job/gpu_day")
for k in ks:
  m=statistics.mean(data[k])
  m1=statistics.median(data[k])
  s=int(k.split("MIG ")[1].split("g")[0])
  print("%s , %i , %i, %i, %i"%(k, m1, m,24*3600/m,7*24*3600/(m*s)))
