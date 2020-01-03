#!/bin/bash
echo "hostname: `hostname`"
echo "ping stashcache.t2.ucsd.edu"
ping -c 2 stashcache.t2.ucsd.edu
echo "tracepath stashcache.t2.ucsd.edu"
tracepath stashcache.t2.ucsd.edu

