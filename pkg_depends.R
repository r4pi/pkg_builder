#!/usr/bin/env Rscript

args <- commandArgs(trailing=TRUE)


if (!is.na(args[2])){
	stop("Too many arguments!\n")
}

if (is.na(args[1])){
	stop("Not enough arguments.\nPlease use the name of the package you wish to check\n")
}

pkgs <- tools::package_dependencies(args[1], recursive=TRUE)

cat(unlist(pkgs), sep="\n")
