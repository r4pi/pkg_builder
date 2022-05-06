#!/bin/bash


date

LOCAL_AWS_CF_DIST_ID=${AWS_CF_DIST_ID:-default}

if [ $LOCAL_AWS_CF_DIST_ID == "default" ]; then
	echo 'Error: $AWS_CF_DIST_ID is not set'
	exit 1
fi


cd /home/mds/r4pi/packages

make all

# Set appropriate message and priority
if [ $? == 0 ];then
	MESSAGE="Package build successful"
	PRIORITY=0
	NUM_PACKAGES="
Number of packages this build: $(grep "tar.gz" sync.log | wc -l)"
else
	MESSAGE="Package build failed!"
	PRIORITY=1
fi

echo "Send the message via pushover"
curl -s \
  --form-string "token=aght6r9rv9qhivo8jdqu2awgbacsjt" \
  --form-string "user=uk1mrore93mx7rhftgm1d96atndxvu" \
  --form-string "message=${MESSAGE}${NUM_PACKAGES}" \
  --form-string "priority=${PRIORITY}" \
  https://api.pushover.net/1/messages.json
