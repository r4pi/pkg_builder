#!/usr/bin/env Rscript


setwd("pkgbin")

pkgs <- dir(path = "../pkgsrc", full.names = TRUE)


for (pkg in pkgs){
  result <- system2("R", paste("--vanilla CMD INSTALL --build", pkg))
  stopifnot("Build of package failed" = result == 0)
  file.rename(pkg, gsub("pkgsrc", "pkgarchive", pkg))
}
