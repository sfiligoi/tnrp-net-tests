#!/bin/bash
ps -ef |grep vm |grep python |awk '{print "kill " $2 " # " $10 " " $16 }'
