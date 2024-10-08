#!/usr/bin/env Rscript

cat("Write PACKAGES files\n", file = stdout())

source("config.R")
previous_all_built_pkgs <- if( file.exists("all_built_pkgs.txt")){
                                  readLines("all_built_pkgs.txt")
} else {
    NA
}

current_all_built_pkgs <- dir(conf_binrepo_dir)
is_not_pkg_override <- is.na(Sys.getenv("PKG_OVERRIDE", unset = NA))

if ( identical(current_all_built_pkgs, previous_all_built_pkgs) && is_not_pkg_override){
    cat("-- No changes since last run... skipping\n", file = stdout())
} else {
    writeLines(current_all_built_pkgs, "all_built_pkgs.txt")
    setwd(conf_binrepo_dir)
    # tools::write_PACKAGES(type = "source", verbose = TRUE)
    tools::update_PACKAGES(type = "source", verbose.level = 1)
}

