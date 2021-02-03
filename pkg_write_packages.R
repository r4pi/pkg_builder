#!/usr/bin/env Rscript

source("config.R")
setwd(conf_binrepo_dir)
tools::write_PACKAGES(type = "source")

