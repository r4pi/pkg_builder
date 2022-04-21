#!/usr/bin/env Rscript

cat(paste(Sys.time(), "----- Pre-flight script -----\n"), file=stdout())

cat(paste(Sys.time(), "Read in the config file\n"), file=stdout())
source("config.R")

# Helper functions

create_dir_if_not_exist <- function(dirname){
    if (dir.exists(dirname)){
        cat("Directory exists:", dirname, "\n", file=stdout())
    } else {
        dir.create(dirname, recursive=TRUE)
    }
}

# Check that the output dir is mounted
if (!file.exists(file.path(conf_bin_dir, "index.html"))){
    cat("Error: Output dir is not mounted\n", file=stdout())
    q(save = "no", status = 1)
} else {
    cat("Output dir is available...\n", file=stdout())
}

# create the custom install dir
create_dir_if_not_exist("~/R/r4pi/")

# create pkgbin
create_dir_if_not_exist(conf_binrepo_dir)

# create pkgsrc
create_dir_if_not_exist("pkgsrc")

# create pkgarchive
create_dir_if_not_exist("pkgarchive")

