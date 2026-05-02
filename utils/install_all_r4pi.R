#!/usr/bin/env Rscript
install.packages(
   available.packages(repos = "file:///home/mds/r4pi/pkg_builder/pkgbinrepo/aarch64")[, "Package"],
   repos = "https://cloud.r-project.org",
   # repos = "file:///home/mds/r4pi/pkg_builder/pkgbinrepo/aarch64",
   lib = "~/R/r4pi")
