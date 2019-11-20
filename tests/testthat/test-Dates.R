context("Dates")

test_that("is.Date works as expected", {
  expect_false(is.Date(234))
  expect_false(is.Date(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")))
  expect_false(is.Date(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")))
  expect_true(is.Date(Sys.Date()))
  expect_false(is.Date(minutes(1)))
  expect_false(is.Date(dminutes(1)))
  expect_false(is.Date(interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"),
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC"))))
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
  expect_equal(as_date("2010-08-03 00:59:59.23"), as_date("2010-08-03"))

  ## can supply custom format
  expect_equal(as_date("03/04/2015", format = "%d/%m/%Y"), as_date("2015-04-03"))

  ## Zulu time is part of the instant spec, so we compute on the instant object
  ## and not on the textual representation.
  expect_equal(as_date("2010-08-03 00:59:59.23Z-02"), as_date("2010-08-03"))
  expect_equal(as_date("2010-08-03 00:59:59.23Z+02"), as_date("2010-08-02"))
  expect_equal(as_date("2010-08-03 00:59:59.23Z+08"), as_date("2010-08-02"))

})
