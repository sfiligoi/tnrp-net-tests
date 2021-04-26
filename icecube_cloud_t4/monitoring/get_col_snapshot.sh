#!/bin/bash
condor_status -af State -af CLOUD_PROVIDER -af '((CurrentTime-LastHeardFrom)<700)' |sort |uniq -c

