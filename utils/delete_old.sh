#!/usr/bin/env bash
# creates lists of packages to delete for a given package in pkgbinrepo
#
ALL_PKGS=$(ls | cut -d"_" -f1 | sort |uniq)

for PKG in ${ALL_PKGS}; do

if [ ${PKG} == "PACKAGES.gz" ] || [ ${PKG} == "PACKAGES" ] || [ ${PKG} == "PACKAGES.rds" ]; then
    echo
else
NUM_PKGS=$(ls -atr ${PKG}_* | wc -l)

if [ ${NUM_PKGS} -gt 1 ]; then

    let NUM_PKGS=NUM_PKGS-1

    ls -atr ${PKG}_* | tail -1 | sed 's/^/\#/g'
    ls -atr ${PKG}_* | head -${NUM_PKGS} | sed 's/^/rm\ /g'
fi

fi
done
