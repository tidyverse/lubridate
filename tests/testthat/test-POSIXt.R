context("POSIXt")

test_that("is.POSIXt works as expected", {
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
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC"))), is_false())
})

test_that("is.POSIXt handles vectors", {
  expect_that(is.POSIXt(c(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"),
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC"))), is_true())
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

test_that("converts character", {
  chars <- c("2017-03-22T15:48:00.000Z", "2017-03-01 0:0:0", "2017-03-01 0:0:0.23", "2017-03-01 0:0:0.23")
  dt <- as_datetime(chars)
  expect_s3_class(dt, "POSIXct")
  expect_equal(tz(dt), "UTC")
  expect_equal(dt, ymd_hms(chars))
  expect_equal(as_datetime(chars, tz = "Europe/Amsterdam"), ymd_hms(chars, tz = "Europe/Amsterdam", quiet = TRUE))
})

test_that("changes timezone of POSIXct", {
  dt <- as_datetime(make_datetime(tz = "America/Chicago"))
  expect_equal(tz(dt), "UTC")
})

test_that("addition of large seconds doesn't overflow", {
  from_period <- origin + seconds(2 ^ 31 + c(-2:2))
  from_char <- ymd_hms(c("2038-01-19 03:14:06", "2038-01-19 03:14:07", "2038-01-19 03:14:08",
                         "2038-01-19 03:14:09", "2038-01-19 03:14:10"))
  expect_equal(from_period, from_char)
})

test_that("as_datetime works correctly", {

  x <- c("17-01-20", "2017-01-20 01:02:03", "2017-03-22T15:48:00.000Z",
         "2017-01-20", "2017-01-20 01:02:03", "2017-03-22T15:48:00.000Z")

  y <- c("2017-01-20 00:00:00 UTC", "2017-01-20 01:02:03 UTC",
         "2017-03-22 15:48:00 UTC", "2017-01-20 00:00:00 UTC",
         "2017-01-20 01:02:03 UTC", "2017-03-22 15:48:00 UTC")

  zns <- c(3, 6)
  putc <- ymd_hms(y)
  pus <- ymd_hms(y[-zns], tz = "America/Chicago")
  expect_equal(as_datetime(x), putc)
  expect_equal(as_datetime(x[-zns], tz = "America/Chicago"), pus)

  for (i in seq_along(x)) {
    expect_equal(as_datetime(x[[i]]), putc[[i]])
  }

  for (i in seq_along(pus)) {
    expect_equal(as_datetime(x[-zns][[i]], tz = "America/Chicago"), pus[[i]])
  }

})
