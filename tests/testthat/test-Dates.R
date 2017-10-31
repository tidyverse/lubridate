context("Dates")

test_that("is.Date works as expected", {
  expect_that(is.Date(234), is_false())
  expect_that(is.Date(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.Date(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.Date(Sys.Date()), is_true())
  expect_that(is.Date(minutes(1)), is_false())
  expect_that(is.Date(dminutes(1)), is_false())
  expect_that(is.Date(interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"),
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC"))), is_false())
})

test_that("is.Date handles vectors", {
  expect_that(is.Date(c(Sys.Date(), as.Date("2009-10-31"))),
    is_true())
})

test_that("as_date works", {
  dt1 <- as.POSIXct("2010-08-03 00:59:59.23")
  dt2 <- as.POSIXct("2010-08-03 00:59:59.23", tz = "Europe/London")
  dt3 <- as.POSIXct("2010-11-03 00:59:59.23")
  dt4 <- as.POSIXct("2010-11-03 00:59:59.23", tz = "Europe/London")
  expect_equal(as_date(dt1), as_date("2010-08-03"))
  expect_equal(as_date(dt2), as_date("2010-08-03"))
  expect_equal(as_date(dt3), as_date("2010-11-03"))
  expect_equal(as_date(dt4), as_date("2010-11-03"))
  expect_equal(as_date(dt1), as.Date("2010-08-03"))
  expect_equal(as_date(dt2), as.Date("2010-08-03"))
  expect_equal(as_date(dt3), as.Date("2010-11-03"))
  expect_equal(as_date(dt4), as.Date("2010-11-03"))
  expect_equal(as_date(10), ymd("1970-01-11"))

  expect_equal(as_date("2010-08-03 00:59:59.23"), as_date("2010-08-03"))
  expect_equal(as_date("2010-11-03 00:59:59.23"), as_date("2010-11-03"))

  ## tz is ignored
  expect_equal(as_date("2010-08-03 00:59:59.23", tz = "Europe/Amsterdam"), as_date("2010-08-03"))
  expect_equal(as_date("2010-11-03 00:59:59.23", tz = "Europe/Amsterdam"), as_date("2010-11-03"))

  ## Zulu time is part of the instant spec, so we compute on the instant object
  ## and not on the textual representation.
  expect_equal(as_date("2010-08-03 00:59:59.23Z-02"), as_date("2010-08-03"))
  expect_equal(as_date("2010-08-03 00:59:59.23Z+02"), as_date("2010-08-02"))
  expect_equal(as_date("2010-08-03 00:59:59.23Z+08"), as_date("2010-08-02"))

})
