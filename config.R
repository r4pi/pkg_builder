# configuration settings

# Define current R version for builds
r_version <- "release"

# local library path where libraries for r4pi get installed
conf_local_libpath <- "~/R/r4pi"

# Hopefully temporary patch as we move away from 32 bit support
if ( Sys.info()["nodename"] == "buildberry3" ){
    repo_dir <- "bookworm"
} else {
    repo_dir <- R.Version()$arch
}

# pkg repo directory location
conf_bin_dir <- file.path(
  "pkgbinrepo",
  repo_dir
)

conf_binrepo_dir <- file.path(
  "pkgbinrepo",
  R.Version()$arch,
  "src",
  "contrib"
)

# --- Additional vars built from the config vars above ---

# Path to R binary
r_binary <- paste0("/opt/R/", r_version, "/bin/R")
