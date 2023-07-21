#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
source("config.R")

if (is.na(args[1])) {
  stop("Please supply a package name to rebuild")
}

pkg <- args[1]

cat("Package to build: ", pkg, "\n")

download.packages(pkg, repos = "https://cran.rstudio.com", destdir = "pkgsrc")


install.packages(pkg, repos = "https://cran.rstudio.com", lib = "~/R/r4pi/")


setwd(conf_binrepo_dir)

pkgs <- dir(path = "../../../pkgsrc", full.names = TRUE)

build_env <- c("LIBARROW_MINIMAL=FALSE", "NOT_CRAN=TRUE", "ARROW_S3=ON", "ARROW_GCS=ON", "ARROW_R_DEV=TRUE")


for (pkg in pkgs) {
  result <- system2(r_binary, paste("--vanilla CMD INSTALL -l '~/R/r4pi/' --no-multiarch --build", pkg), env = build_env)
  stopifnot("Build of package failed" = result == 0)
  file.rename(pkg, gsub("pkgsrc", "pkgarchive", pkg))
}
pkg_binary_names <- dir(path = ".", full.names = TRUE)
for (pkg_binary_name in pkg_binary_names) {
  file.rename(pkg_binary_name, gsub("_R_armv7l-unknown-linux-gnueabihf", "", pkg_binary_name))
  file.rename(pkg_binary_name, gsub("_R_armv-unknown-linux-gnueabihf", "", pkg_binary_name))
}
