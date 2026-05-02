#!/usr/bin/env Rscript
R4PI_PACKAGES <- available.packages(repos = "file:///home/mds/r4pi/pkg_builder/pkgbinrepo/aarch64")[, "Package"]

for (package in R4PI_PACKAGES){
    if(!file.exists(paste0("~/R/r4pi/", package))){
        install.packages(package,
        repos = "https://cloud.r-project.org",
        lib = "~/R/r4pi")
}
}
