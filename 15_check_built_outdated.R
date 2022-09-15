#!/usr/bin/env Rscript

# Checks for packages that were built with an older
# version of R and removes them


# You can burn the entire local package library with:
# remove.packages(installed.packages(lib.loc="~/R/r4pi")[,"Package"], lib="~/R/r4pi")

cat("Checking for outdated builds of packages\n")

CURRENT_R_VERSION <- paste(R.Version()[c("major", "minor")], collapse = ".")

INSTALLED_PACKAGES <- installed.packages(lib.loc="~/R/r4pi")

version_mismatch <- function(package){
    if (package == CURRENT_R_VERSION){
        FALSE
    } else {
        TRUE
    }
}

VERSIONS_MATCH <- unlist(lapply(INSTALLED_PACKAGES[,"Built"], version_mismatch))

OUTDATED_PACKAGES <- INSTALLED_PACKAGES[,"Package"][VERSIONS_MATCH]

remove.packages(OUTDATED_PACKAGES, lib="~/R/r4pi")

