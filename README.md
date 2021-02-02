# baufabrik

R package build factory

## Notes

devtools::build() can do this

or do it yourself:

```{r}
system2("R", "CMD", "INSTALL", "--build", pkg_name)
```

there are options to skip builds of some types of docs

## todo

* automate package downloads as required

if the CRAN version newer than our local version?
if so, download the source and then build it


* build binary packages

```
devtools::build(
  pkg = ".",
  path = NULL,
  binary = FALSE,
  vignettes = TRUE,
  manual = FALSE,
  args = NULL,
  quiet = FALSE,
  ...
)
```

eg.

```{r}
devtools::build(
  pkg = "pkgsrc/dplyr_1.0.3.tar.gz",
  path = NULL,
  binary = TRUE,
  vignettes = TRUE,
  manual = FALSE,
  args = NULL,
  quiet = FALSE
)
```

* Copy the files off somewhere

```{r}
file.rename("pkgsrc/dplyr_1.0.3.tgz", "pkgbin/dplyr_1.0.3.tgz")
```

* write packages file

```{r}
tools::write_PACKAGES(".", type = "mac.binary", verbose = TRUE)
```

* publish! (sync with s3? CDN)
