#!/usr/bin/python

#
# Usage: fname ip
#

import sys,os

conffile=sys.argv[1]
ip=sys.argv[2]

# convert a.b.c.d to uint32
def ipstr2num(s):
  sarr=s.split(".")
  iarr=[int(e) for e in sarr]
  return ((iarr[0]*0xff+iarr[1])*0xff+iarr[2])*0xff+iarr[3]

# convert d into /d mask (e.g. 8 -> 0xff << 24)
def bits2mask(d):
  m=0
  for r in range(d):
    m = m*2+1
  for r in range(32-d):
    m = m*2
  return m

ipn=ipstr2num(ip)

with open(conffile,"r") as fd:
 lines=fd.readlines()

for line in lines:
   if line.startswith("#"):
     continue # comment
   larr=line.split("/")
   if len(larr)!=2:
     continue # not a.b.c.d/e 
   sarr=larr[0].split(".")
   if len(sarr)!=4:
     continue # not starting with a.b.c.d
   darr=larr[1].split()
   if len(darr[0])>2:
     continue # /d cannot be more than 2 digits

   an=ipstr2num(larr[0].strip())
   bits=int(darr[0])
   mask=bits2mask(bits)

   ab = an & mask
   ipb = ipn & mask
   if ab==ipb:
     print(line.strip())

