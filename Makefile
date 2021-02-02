all: checks install deps download build PACKAGES

checks: preflight_checks.R
	./preflight_checks.R

install: packages.txt pkg_src_install.R
	./pkg_src_install.R

deps: packages.txt pkg_deps.R
	./pkg_deps.R

download: baufabrik_packages.txt pkg_src_download.R
	./pkg_src_download.R

build: pkg_build.R
	./pkg_build.R

PACKAGES: pkg_write_packages.R
	./pkg_write_packages.R

.PHONY: checks install deps download build PACKAGES
