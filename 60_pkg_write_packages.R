#!/usr/bin/env Rscript

cat("Write PACKAGES files\n", file=stdout())

source("config.R")
setwd(conf_binrepo_dir)
tools::write_PACKAGES(type = "source")

