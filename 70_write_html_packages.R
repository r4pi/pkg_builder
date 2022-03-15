#!/usr/bin/env Rscript

source("config.R")

url_extract <- function(x){
  no_cr_x <- gsub("\n", " ", x)
  split_x <- strsplit(no_cr_x, " ", fixed=TRUE)
  cleaned_x <- gsub(",", "", split_x[[1]])
  is_url <- startsWith(cleaned_x, "http")
  replacement <- unlist(lapply(cleaned_x[is_url], function(x){paste0('<a href="', x, '">', x, '</a>')}))
  text <- x
  placeholder_text <- gsub("http.[^, ]*", "PLACEHOLDER", text)
  output_text <- placeholder_text
  for (i in replacement){
    output_text <- sub("PLACEHOLDER", i, output_text)
    # cat(output_text, "\n")
  }
  output_text
}


all_pkgs <- readLines("baufabrik_packages.txt")

html_header <- c("<!DOCTYPE html>",
                 "<html>",
                 "<head>",
                 "<title>r4pi - Packages</title>",
                 "<meta name='viewport' content='width=device-width initial-scale=1.0'>",
		 "<style>",
		 "body {font-family: sans-serif;}",
		 "tr:nth-child(even) {background-color: #f2f2f2;}",
		 "tr:hover {background-color: #ccffcc;}",
		 "th { background-color: #D9230F; color: white; }",
		 "th, td {padding: 5px;}",
		 "</style>",
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
    package_url <- url_extract(pkg_description$URL)
  }
  if (is.null(pkg_description$BugReports)){
    package_bugs_url <- "None"
  } else {
    package_bugs_url <- url_extract(pkg_description$BugReports)
  }
  html_table_row <- paste0(
    "<tr>",
    "  <td>", pkg_description$Package, "</td>",
    "  <td>", pkg_description$Version, "</td>",
    "  <td>", pkg_description$Title, "</td>",
    "  <td>", package_url, "</td>",
    "  <td>", package_bugs_url, "</td>",
    "</td>"
  )
  cat(html_table_row, file = "pkgbinrepo/index.html", sep = "\n", append = TRUE)
}

html_footer <- c("</table>",
                 "</body>",
                 "</html>")
cat(html_footer, file = "pkgbinrepo/index.html", sep = "\n", append = TRUE)

