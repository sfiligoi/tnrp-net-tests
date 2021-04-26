#!/bin/bash
condor_status -schedd |grep 'Total ' | awk '{print "Running: " $2 " Idle: " $3 " Held: " $4}'

