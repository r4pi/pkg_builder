#!/usr/bin/env bash

set -euo pipefail

INTERNAL_AWS_CF_DIST_ID=${AWS_CF_DIST_ID:-default}
ARCH=$(uname -m)

if [ "${INTERNAL_AWS_CF_DIST_ID}" == "default" ]; then
  echo 'Error: please ensure the AWS CloudFront Distribution ID is set in $AWS_CF_DIST_ID'
  exit 1
fi
if grep index.html sync.log; then
    aws cloudfront create-invalidation \
        --distribution-id "${AWS_CF_DIST_ID}" \
        --paths /${ARCH}/index.html /${ARCH}/src/contrib/PACKAGES /${ARCH}/src/contrib/PACKAGES.gz
else
	echo "Invalidation not required"
fi
