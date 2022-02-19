#!/usr/bin/env Rscript

source("config.R")

# Helper functions

create_dir_if_not_exist <- function(dirname){
    if (dir.exists(dirname)){
        cat("Directory exists:", dirname, "\n")
    } else {
        dir.create(dirname, recursive=TRUE)
    }
}

# Check that the output dir is mounted
if (!file.exists("pkgbinrepo/index.html")){
    cat("Error: Output dir is not mounted\n")
    q(save = "no", status = 1)
} else {
    cat("Output dir is available...\n")
}

# create the custom install dir
create_dir_if_not_exist("~/R/r4pi/")

# create pkgbin
create_dir_if_not_exist(conf_binrepo_dir)

# create pkgsrc
create_dir_if_not_exist("pkgsrc")

# create pkgarchive
create_dir_if_not_exist("pkgarchive")

