#!/bin/bash
condor_status -af State -af 'strcat("R",substr(FileSystemDomain,3,1))' -af '((CurrentTime-LastHeardFrom)<700)' |sort |uniq -c

