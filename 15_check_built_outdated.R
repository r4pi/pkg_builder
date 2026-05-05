#!/usr/bin/env Rscript

# Checks for packages that were built with an older
# version of R and removes them


# You can burn the entire local package library with:
# remove.packages(installed.packages(lib.loc="~/R/r4pi")[,"Package"], lib="~/R/r4pi")

cat("Checking for outdated builds of packages\n")

source("config.R")

CURRENT_R_VERSION <- paste(R.Version()[c("major", "minor")], collapse = ".")

INSTALLED_PACKAGES <- as.data.frame(installed.packages(lib.loc = "~/R/r4pi")[,c("Package", "Built", "Version")])


ALL_OUTDATED_PACKAGES <- INSTALLED_PACKAGES[!startsWith(INSTALLED_PACKAGES$Built, paste("R", CURRENT_R_VERSION)),]

cat("Outdated packages:\n")
ALL_OUTDATED_PACKAGES
# Only grab the first n packages that are outdated
if (nrow(ALL_OUTDATED_PACKAGES) > num_remove) {
    OUTDATED_PACKAGES <- ALL_OUTDATED_PACKAGES[sample(nrow(ALL_OUTDATED_PACKAGES), num_remove), ]
} else {
    OUTDATED_PACKAGES <- ALL_OUTDATED_PACKAGES
}


marked_for_removal <- apply(OUTDATED_PACKAGES, 1, function(x) {
  paste0(x["Package"], "_", x["Version"], ".tar.gz")
})
marked_for_removal

for (package in marked_for_removal) {
    cat(package)
    package_name <- strsplit(package, "_")[[1]][1]
    if(
       !startsWith(
            x = packageDescription(
                    package_name,
                    lib.loc="~/R/r4pi/"
                    )$Built,
                prefix = paste("R", CURRENT_R_VERSION)
                )) {
       remove.packages(package_name, lib = "~/R/r4pi")
       pkg_full_path <- file.path(conf_binrepo_dir, package)
       cat("Removing file: ", pkg_full_path, "\n")
       unlink(pkg_full_path)
       } else {
         cat("Not deleting package: ", package_name, "\n")
        }
}

