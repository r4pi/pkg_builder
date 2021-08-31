#!/usr/bin/env bash

set -euo pipefail

INTERNAL_AWS_CF_DIST_ID=${AWS_CF_DIST_ID:-default}

if [ "${INTERNAL_AWS_CF_DIST_ID}" == "default" ]; then
  echo 'Error: please ensure the AWS CloudFront Distribution ID is set in $AWS_CF_DIST_ID'
  exit 1
fi
grep index.html sync.log
if [ $? -eq 0 ]; then
  aws cloudfront create-invalidation --distribution-id ${AWS_CF_DIST_ID} --paths /index.html
fi
