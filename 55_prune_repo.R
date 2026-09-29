#!/usr/bin/env Rscript
#
# Removes old packages that aren't in the current published repository (PACKAGES file)
# from the repo.
# This keeps the repo light and speeds up the write.PACKAGES process
#

# Set to TRUE to prevent this script from actually deleting anything.
# Useful for testing
dry_run <- FALSE

source("config.R")
setwd(conf_binrepo_dir)

DO_NOT_DELETE <- c("PACKAGES", "PACKAGES.rds", "PACKAGES.gz")
repo_pkgs <- dir(path = ".", full.names = TRUE)
published_pkgs <- read.dcf("PACKAGES")
pkgsdf <- as.data.frame(published_pkgs)

pkg_file_names <- paste0(pkgsdf$Package, "_", pkgsdf$Version, ".tar.gz")

for (pkg in repo_pkgs){
    cat("Current pkg: ", pkg, "\n")
    pkg_file_name <- tail(unlist(strsplit(pkg, "/")), 1)
    if (pkg_file_name %in% DO_NOT_DELETE){
        cat("Skipping...\n")
    } else if (pkg_file_name %in% pkg_file_names){
        cat("Package in PACKAGES, not deleting!\n")
    } else if (dry_run){
        cat("Package NOT in Packages (not deleting due to dry_run=T\n")
    } else {
        cat("Package NOT in Packages, deleting!! \n")
        unlink(pkg)
    }
}
