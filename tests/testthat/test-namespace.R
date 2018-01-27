context("Namespace")

if (file.exists("../../00check.log")) {
  # test was invoked by R CMD check -> package is already built
  R_test_lib <- normalizePath("../..")
  env <- paste0("R_LIBS=", R_test_lib, ":", Sys.getenv("R_LIBS"))
} else {
  # We're testing in the source directory -> need to build and install
  R_test_lib <- file.path(tempdir(), "Rlib")
  env <- ""
  ## dir.create(R_test_lib)
  ## on.exit(unlink(R_test_lib, recursive = TRUE))
  ## system2(
  ##   "R",
  ##   c("CMD install",
  ##     paste0("--library=", R_test_lib),
  ##     "--no-docs --no-help --no-demo --no-data --no-test-load",
  ##     normalizePath("../..")),
  ##   stdout = TRUE, stderr = TRUE)
}

do_Rscript <- function(expr) {
  rscript <- sprintf("%s/bin/Rscript", Sys.getenv("R_HOME"))
  paste(
    system2(rscript,
            args = c("--vanilla", "--default-packages=NULL", "-e", shQuote(expr)),
            env = c("R_TESTS=", env),
            stdout = TRUE, stderr = TRUE),
    collapse = "\n")
}

test_that("methods is not attached", {
  skip_on_cran()
  # Checking test assumptions.
  # If this fails, namespace tests may not be needed anymore!
  expect_match(
    do_Rscript("'package:methods' %in% search()"),
    "FALSE")
})

test_that("lubridate:: calls work when methods is not attached", {
  skip_on_cran()
  expect_match( # https://github.com/tidyverse/lubridate/issues/314
    do_Rscript(
      "lubridate::round_date(as.POSIXct('2017-10-03 03:01:13Z'), 'minute')"),
    as.character(round_date(as.POSIXct('2017-10-03 03:01:13Z'), 'minute')),
    fixed = TRUE)
  expect_match( # https://github.com/tidyverse/lubridate/issues/407
    do_Rscript("lubridate::days(1)"),
    as.character(days(1)),
    fixed = TRUE)
  expect_match( # https://github.com/tidyverse/lubridate/issues/499
    do_Rscript("lubridate::dhours(22)"),
    as.character(dhours(22)),
    fixed = TRUE)
})
