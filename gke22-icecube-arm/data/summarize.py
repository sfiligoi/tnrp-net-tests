import sys
import statistics

with open(sys.argv[1],"r") as fd:
  lines=fd.readlines()

data={}
for line in lines:
  larr=line.strip().split()
  k=larr[0].split("/")[2]
  v=larr[2].split("e")[0]
  if k not in data:
    data[k]=[]
  data[k].append(v)

vals=[]

for k in data.keys():
  for v in data[k][1:-1]:
   # '52:15.68'
   varr=v.split(".")[0]
   marr=varr.split(":")
   t=0
   exp=1
   for i in range(len(marr)):
     t=t+(exp*int(marr[-(i+1)]))
     exp=exp*60
   vals.append(t)

print(vals)
v=statistics.mean(vals)
print("mean: %is %.1fmin %.2fh"%(v,v/60.0,v/3600.0))
v=min(vals)
print("min:  %is %.1fmin %.2fh"%(v,v/60.0,v/3600.0))
v=max(vals)
print("max:  %is %.1fmin %.2fh"%(v,v/60.0,v/3600.0))
