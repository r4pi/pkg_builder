#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
DEFAULT_SAMPLE_SIZE <- 5
if ( is.na(args[1]) ){
    SAMPLE_SIZE <- DEFAULT_SAMPLE_SIZE
} else {
    SAMPLE_SIZE <- args[1]
}

cat("Sample size:", SAMPLE_SIZE, "\n")

R4PI_PACKAGES <- available.packages(repos = "file:///home/mds/r4pi/pkg_builder/pkgbinrepo/aarch64")[, "Package"]
CRAN_PACKAGES <- available.packages(repos = "https://cloud.r-project.org/")[, "Package"]

NON_R4PI_PKGS <- CRAN_PACKAGES[ ! CRAN_PACKAGES %in% R4PI_PACKAGES]

cat("R4PI:", length(R4PI_PACKAGES), "\n")
cat("CRAN:", length(CRAN_PACKAGES), "\n")
cat("Non R4PI:", length(NON_R4PI_PKGS), "\n")


names(sample(NON_R4PI_PKGS, SAMPLE_SIZE))

