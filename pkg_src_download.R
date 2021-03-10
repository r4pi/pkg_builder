#!/usr/bin/env Rscript

pkgs_available_cran <- available.packages(repos = "https://cran.rstudio.com")


current_dir <- getwd()
contrib_path <- paste0("file://", current_dir, "/pkgbinrepo/src/contrib")
if (file.exists(paste0(current_dir, "/pkgbinrepo/src/contrib/PACKAGES"))){
    pkgs_available_local <- available.packages(contriburl = contrib_path)
} else {
    cat("Using fake local repo as no PACKAGES found\n")
    pkgs_available_local <- matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE,
				   dimnames = list(1, "Package"))
}

pkgs_input <- readLines("baufabrik_packages.txt")


pkg_update_available <- function(package_name, available_cran, available_local){
  cran_version <- available_cran[which(available_cran[,"Package"] == package_name),]["Version"]
  local_version <- available_local[which(available_local[,"Package"] == package_name),]["Version"]
  cat("Package:", package_name, "CRAN:", cran_version, "Local:", local_version, "\n")
  if (is.na(local_version)){
    return(TRUE)
  }
  if ( is.na(cran_version)){
	  cat("WARNING - Package:", package_name, "not available, skipping\n")
	  FALSE
  } else {
    if (cran_version == local_version){
      FALSE
    } else {
      TRUE
    }
  }
}

for (pkg in pkgs_input){
  if (pkg_update_available(pkg, pkgs_available_cran, pkgs_available_local)){
    download.packages(pkg, repos = "https://cran.rstudio.com", destdir = "pkgsrc")    
  }
}
