all: pipeline-start packages.txt checks oldBuilt install deps download build PACKAGES html sync pipeline-stop

pipeline-start: 01_is_running.sh
	./01_is_running.sh start

pipeline-stop: 01_is_running.sh
	./01_is_running.sh stop
	rm packages.txt

packages.txt: packages.cfg list_packages
	./list_packages > packages.txt

checks: 10_preflight_checks.R
	./10_preflight_checks.R

oldBuilt:
	./15_check_built_outdated.R

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
	./75_repo_sync.sh
	./80_invalidate_cloudfront_cache.sh

clean:
	-rm is_running.lock

.PHONY: all checks install deps download build PACKAGES html sync
