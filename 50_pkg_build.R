#!/usr/bin/env Rscript

source("config.R")
setwd(conf_binrepo_dir)
cat(paste0(timestamp(), "\n"), file = "../../../../build.log")

pkgs <- dir(path = "../../../../pkgsrc", full.names = TRUE)

result <- integer(0)

for (pkg in pkgs) {
  cat(paste("-", pkg, "\n"), file = "../../../../build.log", append = TRUE)
  result <- append(result, system2(r_binary, paste("--vanilla CMD INSTALL -l '~/R/r4pi/' --no-multiarch --build", pkg)))
  file.rename(pkg, gsub("pkgsrc", "pkgarchive", pkg))
}

result <- ifelse(result == 0, FALSE, TRUE)

cat(paste(sum(!result), "package(s) built successfully\n"),
  file = "../../../../build.log",
  append = TRUE
)

cat(paste0(sum(result), " package builds failed (", paste(pkgs[result], collapse = ", "), ") \n"),
  file = "../../../../build.log",
  append = TRUE
)

pkg_binary_names <- dir(path = ".", full.names = TRUE, pattern = "*-linux-*")

for (pkg_binary_name in pkg_binary_names) {
  file.rename(pkg_binary_name, gsub("_R_armv7l-unknown-linux-gnueabihf", "", pkg_binary_name))
  file.rename(pkg_binary_name, gsub("_R_armv-unknown-linux-gnueabihf", "", pkg_binary_name))
  file.rename(pkg_binary_name, gsub("_R_aarch64-unknown-linux-gnu", "", pkg_binary_name))
}
