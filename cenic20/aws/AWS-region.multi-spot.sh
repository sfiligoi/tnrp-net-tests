#!/bin/bash

#
# Arguments:
#   $1 = region
#   $2 = count
#   $3 = deadline
#
# Note: Will wait for all instances to start up

r="$1"
cnt="$2"
dl="$3"

if [ ! -f AWS-${r}.spot.${cnt}.json ]; then
  sed "s/: 1/: ${cnt}/g" AWS-${r}.spot.json > AWS-${r}.spot.${cnt}.json
fi

id=`aws ec2 request-spot-fleet --output text --region "${r}" --spot-fleet-request-config file://$PWD/AWS-${r}.spot.${cnt}.json`
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

# let user know what happened
echo "Requested ${cnt} instances as part of: ${id}"

# now wait
started=0
for ((i=0; $i<${dl}; i=$i+1)); do
  sleep 1
  ss=`aws ec2 describe-spot-fleet-requests --spot-fleet-request-id ${id} --region "${r}"  --output text |grep SPOTFLEETREQUESTCONFIGS`
  echo "`date` ${ss}"
  fstr=`echo "${ss}" |grep 'fulfilled'`
  if [ "x${fstr}" != "x" ]; then
    started=1
    break
  fi
done;

if [ ${started} -ne 1 ]; then
  echo "Failed"
  aws ec2 cancel-spot-fleet-requests --region ${r} --terminate-instances --spot-fleet-request-ids ${id}
  exit 1
fi

echo "aws ec2 cancel-spot-fleet-requests --region ${r} --terminate-instances --spot-fleet-request-ids ${id}" >> cancel_AWS-${r}.spot.sh

