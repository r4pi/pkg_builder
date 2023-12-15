#!/bin/bash

date
source /etc/os-release
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

# send status to the r4pi status service
if [ "$PRIORITY" == 0 ]; then
    STATUS_MSG="Sucess"
else
    STATUS_MSG="Failed"
fi

REV=$(curl -s -u ${R4PI_STATUS_USER}:${R4PI_STATUS_PASS} http://moby:5984/r4pi_status/$(hostname) | jq -r "._rev")
echo ${REV}
if [ "$REV" == "null" ]; then
    REV_STR=""
else
    REV_STR=", \"_rev\":\"${REV}\""
fi

DATA_STRING="{\"builder\":\"$(hostname)\", \"arch\":\"$(uname -m)\", \"codename\":\"${VERSION_CODENAME}\", \"timestamp\":\"$(date -Iseconds)\", \"status\":\"${STATUS_MSG}\"${REV_STR}}"
echo ${DATA_STRING}
COUCH_DOC="http://moby:5984/r4pi_status/$(hostname)"
echo ${COUCH_DOC}

curl -vvv -s \
    -u ${R4PI_STATUS_USER}:${R4PI_STATUS_PASS} \
    -X PUT \
    --data "${DATA_STRING}" \
    ${COUCH_DOC}

