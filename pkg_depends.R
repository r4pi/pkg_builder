#!/usr/bin/env Rscript

args <- commandArgs(trailing = TRUE)


if (!is.na(args[2])) {
  stop("Too many arguments!\n")
}

if (is.na(args[1])) {
  stop(
    "Not enough arguments. ",
    "Please use the name of the package you wish to check\n"
  )
}

pkgs <- tools::package_dependencies(
  args[1],
  recursive = TRUE,
  db = available.packages(
    repos = paste0(
      "https://pkgs.r4pi.org/",
      R.Version()$arch
    )
  )
)

cat(unlist(pkgs), sep = "\n")
