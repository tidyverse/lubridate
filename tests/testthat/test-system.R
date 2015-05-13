context("Sytem")


test_that("Rscript runs correctly", {
  skip_on_cran()
  if(nzchar(Sys.getenv("TRAVIS")))
    skip("Running  on Travis")
  expect_equal(0L, system("Rscript -e \"lubridate::round_date(Sys.time(),'minute')\"",
                          ignore.stderr = T, ignore.stdout = T))
})
