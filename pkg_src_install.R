#!/usr/bin/env Rscript

# Read input file packages
pkgs_input <- readLines("packages.txt")

update.packages(repos = "https://cran.rstudio.com", ask = FALSE)

package_installed <- function(pkg_name){
  pkg_name %in% rownames(installed.packages())
}

for (pkg in pkgs_input){
  if (isFALSE(package_installed(pkg))){
    cat("Installing package:", pkg, "\n")
    install.packages(pkg, repos = "https://cran.rstudio.com")
  } else {
    cat("Already installed - skipping:", pkg, "\n")
  }
}
