# configuration settings

# Define current R version for builds
r_version <- "release"

# local library path where libraries for r4pi get installed
conf_local_libpath <- "~/R/r4pi"

# pkg repo director location
conf_bin_dir <- file.path(
  "pkgbinrepo",
  R.Version()$arch
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
