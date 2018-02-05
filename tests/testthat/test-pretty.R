context("Pretty formatting of dates")

test_that("pretty_dates works for years", {

  ## skip anything that uses setenv(TZ) on CRAN for now
  skip_on_cran()

  ## https://github.com/hadley/lubridate/issues/227
  expect_equal(pretty_dates(c(as.Date("1993-12-05"), as.Date("2007-12-01")), 7),
               ymd(c("1993-01-01 UTC", "1995-01-01 UTC", "1997-01-01 UTC",
                     "1999-01-01 UTC", "2001-01-01 UTC", "2003-01-01 UTC",
                     "2005-01-01 UTC", "2007-01-01 UTC"),
                   tz = "UTC"))

  ## https://github.com/hadley/lubridate/issues/248
  expect_equal(
    pretty_dates(ymd_hms("2014-02-05 22:45:46 GMT", "2014-03-03 14:28:20"), 10),
    ymd(c("2014-02-05 UTC", "2014-02-07 UTC", "2014-02-09 UTC", "2014-02-11 UTC",
          "2014-02-13 UTC", "2014-02-15 UTC", "2014-02-17 UTC", "2014-02-19 UTC",
          "2014-02-21 UTC", "2014-02-23 UTC", "2014-02-25 UTC", "2014-02-27 UTC",
          "2014-03-01 UTC", "2014-03-03 UTC"),
        tz = "UTC"))
})
