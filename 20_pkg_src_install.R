#!/usr/bin/env Rscript

# Read input file packages
pkgs_input <- readLines("packages.txt")

update.packages(repos = "https://cran.rstudio.com", ask = FALSE, lib.loc = "~/R/r4pi/", instlib = "~/R/r4pi/")

package_installed <- function(pkg_name){
  pkg_name %in% rownames(installed.packages(lib.loc = "~/R/r4pi/"))
}

for (pkg in pkgs_input){
  if (!grepl("^#", pkg)){
    if (isFALSE(package_installed(pkg))){
      cat("Installing package:", pkg, "\n", file=stdout())
      install.packages(pkg, repos = "https://cran.rstudio.com", lib = "~/R/r4pi/")
    } else {
      cat("Already installed - skipping:", pkg, "\n", file=stdout())
    }
  }
}
