all: checks install deps download build PACKAGES html sync

checks: 10_preflight_checks.R
	./10_preflight_checks.R

install: packages.txt 20_pkg_src_install.R
	./20_pkg_src_install.R

deps: packages.txt 30_pkg_deps.R
	./30_pkg_deps.R

download: baufabrik_packages.txt 40_pkg_src_download.R
	./40_pkg_src_download.R

build: 50_pkg_build.R
	./50_pkg_build.R

PACKAGES: 60_pkg_write_packages.R
	./60_pkg_write_packages.R

html: 70_write_html_packages.R
	./70_write_html_packages.R

sync:
	s3cmd sync ./pkgbinrepo/ s3://pkgs.r4pi.org/ | tee sync.log
	./80_invalidate_cloudfront_cache.sh

.PHONY: all checks install deps download build PACKAGES html sync
