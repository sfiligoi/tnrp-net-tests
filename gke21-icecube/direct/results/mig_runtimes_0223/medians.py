import sys
import statistics

with open(sys.argv[1],"r") as fd:
  lines=fd.readlines()

sstr="2022"
if len(sys.argv)>2:
  sstr=sys.argv[2]

data={}
for line in lines[1:]:
  larr=line.strip().split(",")
  #print(larr)
  if len(larr)!=5:
    continue

  if not larr[4].strip().startswith(sstr):
    continue

  kidx=int(larr[2].split('/')[1])
  if kidx<1:
    k="A100-SXM4-40GB MIG 7g.40gb"
  elif kidx<3:
    k="A100-SXM4-40GB MIG 3g.20gb"
  elif kidx<7:
    k="A100-SXM4-40GB MIG 2g.10gb"
  else:
    k="A100-SXM4-40GB MIG 1g.5gb"
  val=int(larr[3])

  if k not in data:
    data[k]=[]
  data[k].append(val)

ks=list(data.keys())
ks.sort()
print("#gpu, median, mean, jobs/day, job/gpu_day, samples")
for k in ks:
  m=statistics.mean(data[k])
  m1=statistics.median(data[k])
  s=int(k.split("MIG ")[1].split("g")[0])
  print("%s , %i , %i, %i, %i, %i"%(k, m1, m,24*3600/m,7*24*3600/(m*s),len(data[k])))
