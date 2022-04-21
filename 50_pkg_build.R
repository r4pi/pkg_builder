#!/usr/bin/env Rscript

source("config.R")
setwd(conf_binrepo_dir)
cat(paste0(timestamp(),"\n"), file="../../../build.log")

pkgs <- dir(path = "../../../pkgsrc", full.names = TRUE)


for (pkg in pkgs){
  cat(paste(pkg, "\n"), file="build.log", append = TRUE)
  result <- system2(r_binary, paste("--vanilla CMD INSTALL -l '~/R/r4pi/' --no-multiarch --build", pkg))
  stopifnot("Build of package failed" = result == 0)
  file.rename(pkg, gsub("pkgsrc", "pkgarchive", pkg))
}
pkg_binary_names <- dir(path = ".", full.names = TRUE)
for (pkg_binary_name in pkg_binary_names){
    file.rename(pkg_binary_name, gsub("_R_armv7l-unknown-linux-gnueabihf", "", pkg_binary_name))
    file.rename(pkg_binary_name, gsub("_R_armv-unknown-linux-gnueabihf", "", pkg_binary_name))
    file.rename(pkg_binary_name, gsub("_R_aarch64-unknown-linux-gnu", "", pkg_binary_name))
}

