install: packages.txt pkg_src_install.R
	./pkg_src_install.R

deps: packages.txt pkg_deps.R
	./pkg_deps.R

.PHONY: deps