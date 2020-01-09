#!/bin/bash

#
# Arguments:
#   $1 = region
#

r="$1"

id=`aws ec2 request-spot-fleet --output text --region "${r}" --spot-fleet-request-config file://$PWD/AWS-${r}.spot.json`
rc=$?
if [ $rc -ne 0 ]; then
  echo "Failed"
  exit $rc
fi

# Create or extend cancel file
if [ ! -f cancel_AWS-${r}.spot.sh ] ; then
  echo '#!/bin/bash' > cancel_AWS-${r}.spot.sh
  chmod u+x cancel_AWS-${r}.spot.sh
fi

echo "aws ec2 cancel-spot-fleet-requests --region ${r} --terminate-instances --spot-fleet-request-ids ${id}" >> cancel_AWS-${r}.spot.sh

# let user know what happened
echo "Requested: ${id}"
