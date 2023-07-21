#!/usr/bin/env Rscript

# Checks for packages that were built with an older
# version of R and removes them


# You can burn the entire local package library with:
# remove.packages(installed.packages(lib.loc="~/R/r4pi")[,"Package"], lib="~/R/r4pi")

cat("Checking for outdated builds of packages\n")

source("config.R")

CURRENT_R_VERSION <- paste(R.Version()[c("major", "minor")], collapse = ".")

INSTALLED_PACKAGES <- installed.packages(lib.loc = "~/R/r4pi")

version_mismatch <- function(package) {
  if (package == CURRENT_R_VERSION) {
    FALSE
  } else {
    TRUE
  }
}

VERSIONS_MATCH <- unlist(lapply(INSTALLED_PACKAGES[, "Built"], version_mismatch))

OUTDATED_PACKAGES <- INSTALLED_PACKAGES[, "Package"][VERSIONS_MATCH]

remove.packages(OUTDATED_PACKAGES, lib = "~/R/r4pi")
INSTALLED_PACKAGES[, "Package"][VERSIONS_MATCH]

pkgs_versions <- data.frame(
  "Package" = INSTALLED_PACKAGES[, "Package"][VERSIONS_MATCH],
  "Version" = INSTALLED_PACKAGES[, "Version"][VERSIONS_MATCH]
)

marked_for_removal <- apply(pkgs_versions, 1, function(x) {
  paste0(x[1], "_", x[2], ".tar.gz")
})

for (package in marked_for_removal) {
  # cat(package)
  pkg_full_path <- file.path(conf_binrepo_dir, package)
  cat("Removing file: ", pkg_full_path, "\n")
  unlink(pkg_full_path)
}
