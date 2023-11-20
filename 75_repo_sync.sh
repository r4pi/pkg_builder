#!/usr/bin/env bash

set -euo pipefail

if [ $(hostname) == "buildberry3" ]; then
    s3cmd sync ./pkgbinrepo/aarch64 s3://pkgs.r4pi.org/bookworm/ | tee sync.log
else
    s3cmd sync ./pkgbinrepo/ s3://pkgs.r4pi.org/ | tee sync.log
fi
