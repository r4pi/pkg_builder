#!/usr/bin/env Rscript

# Get all currently available packages
pkgs_cran <- available.packages("https://cran.rstudio.com/src/contrib")


pkg_available_version <- function(package_name, all_cran_packages){
  all_cran_packages[which(all_cran_packages[,"Package"] == package_name),]["Version"]
}
