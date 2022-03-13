#!/bin/bash

cd /home/pi/r4pi/packages

make
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

# Send the message via pushover
curl -s \
  --form-string "token=aght6r9rv9qhivo8jdqu2awgbacsjt" \
  --form-string "user=uk1mrore93mx7rhftgm1d96atndxvu" \
  --form-string "message=${MESSAGE}${NUM_PACKAGES}" \
  --form-string "priority=${PRIORITY}" \
  https://api.pushover.net/1/messages.json
