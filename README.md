# R4Pi Package builder toolchain

R package build factory

## Requirements

* env var AWS_CF_DIST_ID is cloudfront distribution ID
* s3cmd config
* aws config
* Vars for pushover.net

## Run the pipeline

To run interactively use `make all`.

The cron wrapper, `run_cron.sh`, that sends completion messages via pushover.net.

