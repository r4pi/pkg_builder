#!/usr/bin/env bash

set -euo pipefail

if [ $(hostname) == "buildberry3" ]; then
    s3cmd sync ./pkgbinrepo/bookworm/ s3://pkgs.r4pi.org/bookworm/ | tee sync.log
elif [ $(hostname) == "buildberry4" ]; then
    s3cmd sync ./pkgbinrepo/aarch64/ s3://pkgs.r4pi.org/noble/ | tee sync.log
else
    s3cmd sync ./pkgbinrepo/ s3://pkgs.r4pi.org/ | tee sync.log
fi
