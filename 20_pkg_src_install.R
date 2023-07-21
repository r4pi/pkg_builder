#!/usr/bin/env Rscript


cat("-- Updating installed packages\n")
update.packages(
  repos = "https://cran.rstudio.com",
  ask = FALSE,
  lib.loc = "~/R/r4pi/",
  instlib = "~/R/r4pi/"
)

cat("-- Detecting and installing new packages\n")
pkgs_input <- readLines("packages.txt")

package_installed <- function(pkg_name) {
  pkg_name %in% rownames(installed.packages(lib.loc = "~/R/r4pi/"))
}

for (pkg in pkgs_input) {
  if (!grepl("^#", pkg)) {
    if (isFALSE(package_installed(pkg))) {
      cat("Installing package:", pkg, "\n", file = stdout())
      install.packages(pkg, repos = "https://cran.rstudio.com", lib = "~/R/r4pi/")
    } else {
      cat("Already installed - skipping:", pkg, "\n", file = stdout())
    }
  }
}
