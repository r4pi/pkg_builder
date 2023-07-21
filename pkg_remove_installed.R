#!/usr/bin/env Rscript

args <- commandArgs(trailing = TRUE)


if (!is.na(args[2])) {
  stop("Too many arguments!\n")
}

if (is.na(args[1])) {
  stop("Not enough arguments.\nPlease use the name of the package you wish to uninstall\n")
}


remove.packages(args[1], lib = "~/R/r4pi/")
