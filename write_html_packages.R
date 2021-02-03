#!/usr/bin/env Rscript

source("config.R")

all_pkgs <- readLines("baufabrik_packages.txt")

html_header <- c("<html>",
                 "<head>",
                 "<title>r4pi - Packages</title>",
                 "</head>",
                 "<body>",
                 "<table>",
                 "<tr>",
                 "  <th>Package</th>",
                 "  <th>Version</th>",
                 "  <th>Title</th>",
                 "  <th>Wesbite</th>",
                 "  <th>Bugs</th>",
                 "</tr>")

cat(html_header, file = "pkgbinrepo/index.html", sep = "\n", append = FALSE)

for (pkg in all_pkgs){
  pkg_description <- packageDescription(pkg, lib.loc = conf_local_libpath)
  cat("Package:", pkg_description$Package, "\n")
  if (is.null(pkg_description$URL)){
	  package_url <- "None"
  } else {
	  package_url <- strsplit(pkg_description$URL, ",")[[1]][1]
  }
  html_table_row <- paste0(
    "<tr>",
    "  <td>", pkg_description$Package, "</td>",
    "  <td>", pkg_description$Version, "</td>",
    "  <td>", pkg_description$Title, "</td>",
    "  <td>", package_url, "</td>",
    "  <td>", pkg_description$BugReports, "</td>",
    "</td>"
  )
  cat(html_table_row, file = "pkgbinrepo/index.html", sep = "\n", append = TRUE)
}

html_footer <- c("</table>",
                 "</body>",
                 "</html>")
cat(html_footer, file = "pkgbinrepo/index.html", sep = "\n", append = TRUE)

