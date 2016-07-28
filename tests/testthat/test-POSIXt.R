context("POSIXt")

test_that("is.POSIXt works as expected",{
  expect_that(is.POSIXt(234), is_false())
  expect_that(is.POSIXt(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_true())
  expect_that(is.POSIXt(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")),
    is_true())
  expect_that(is.POSIXt(Sys.Date()), is_false())
  expect_that(is.POSIXt(minutes(1)), is_false())
  expect_that(is.POSIXt(dminutes(1)), is_false())
  expect_that(is.POSIXt(interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"),
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_false())
})

test_that("is.POSIXt handles vectors",{
  expect_that(is.POSIXt(c(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"),
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})


# as_datetime -------------------------------------------------------------

test_that("converts numeric", {
  dt <- as_datetime(0)
  expect_s3_class(dt, "POSIXct")
  expect_equal(tz(dt), "UTC")
  expect_equal(unclass(dt)[[1]], 0)
})

test_that("converts date", {
  dt <- as_datetime(as.Date("1970-01-01"))
  expect_s3_class(dt, "POSIXct")
  expect_equal(tz(dt), "UTC")
  expect_equal(unclass(dt)[[1]], 0)
})

test_that("changes timezone of POSIXct", {
  dt <- as_datetime(make_datetime(tz = "America/Chicago"))
  expect_equal(tz(dt), "UTC")
})
