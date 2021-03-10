#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
source("config.R")

pkg <- args[1]

cat("Package to build: ", pkg, "\n")


download.packages(pkg, repos = "https://cran.rstudio.com", destdir = "pkgsrc")


install.packages(pkg, repos = "https://cran.rstudio.com", lib = "~/R/r4pi/")


setwd(conf_binrepo_dir)

pkgs <- dir(path = "../../../pkgsrc", full.names = TRUE)


for (pkg in pkgs){
  result <- system2(r_binary, paste("--vanilla CMD INSTALL -l '~/R/r4pi/' --no-multiarch --build", pkg))
  stopifnot("Build of package failed" = result == 0)
  file.rename(pkg, gsub("pkgsrc", "pkgarchive", pkg))
}
pkg_binary_names <- dir(path = ".", full.names = TRUE)
for (pkg_binary_name in pkg_binary_names){
    file.rename(pkg_binary_name, gsub("_R_armv7l-unknown-linux-gnueabihf", "", pkg_binary_name))
    file.rename(pkg_binary_name, gsub("_R_armv-unknown-linux-gnueabihf", "", pkg_binary_name))
}

