#!/bin/bash

date

ARCH=$(uname -m)

LOCAL_AWS_CF_DIST_ID=${AWS_CF_DIST_ID:-default}

if [ $LOCAL_AWS_CF_DIST_ID == "default" ]; then
	echo 'Error: $AWS_CF_DIST_ID is not set'
	exit 1
fi


cd /home/mds/r4pi/pkg_builder

make all

# Set appropriate message and priority
if [ $? == 0 ];then
    SUCCESS="$(grep "successfully" build.log)"
    FAILURE="$(grep "failed" build.log)"
    UPLOAD="$(grep "tar.gz" sync.log | wc -l) uploaded"
    MESSAGE="($(hostname)-${ARCH}) ${SUCCESS} | ${FAILURE} | ${UPLOAD}"
    if [ ${FAILURE:0:1} != "0" ] ; then
	PRIORITY=1
    else
        PRIORITY=0
    fi
else
    MESSAGE="($(hostname)-${ARCH}) Package build pipeline failed!"
	PRIORITY=1
fi

echo "Send the message via pushover"
curl -s \
  --form-string "token=${PUSHOVER_TOKEN}" \
  --form-string "user=${PUSHOVER_USER}" \
  --form-string "message=${MESSAGE}" \
  --form-string "priority=${PRIORITY}" \
  https://api.pushover.net/1/messages.json
