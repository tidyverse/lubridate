context("Time zones")

test_that("with_tz works as expected", {
  x <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  y <- as.POSIXlt(x)
  
  expect_that(with_tz(x, "UTC"), equals(as.POSIXct(format(
    as.POSIXct(x), tz = "UTC"), tz = "UTC")))
  expect_that(with_tz(y, "UTC"), equals(as.POSIXlt(format(
    as.POSIXct(x), tz = "UTC"), tz = "UTC")))
})

test_that("with_tz handles vectors", {
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 10:01:59"), tz = "America/New_York")
  y <- as.POSIXlt(x)
  
  expect_that(with_tz(x, "UTC"), equals(as.POSIXct(format(
    as.POSIXct(x), tz = "UTC"), tz = "UTC")))
  expect_that(with_tz(y, "UTC"), equals(as.POSIXlt(format(
    as.POSIXct(x), tz = "UTC"), tz = "UTC")))
})

test_that("with_tz handles various date-time classes", {
  x <- as.POSIXct("2008-08-03 13:01:59", tz = "America/New_York")
  
  expect_equal(with_tz(as.POSIXlt(x), "UTC"), 
               as.POSIXlt(format(as.POSIXct(x), tz = "UTC"), tz = "UTC"))
})

test_that("force_tz works as expected", {
  x <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  
  expect_that(force_tz(x, "UTC"), 
              equals(as.POSIXct(format(as.POSIXct(x)), tz = "UTC")))
})

test_that("force_tz handles vectors", {
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 10:01:59"), tz = "America/New_York")
  
  expect_that(force_tz(x, "UTC"), 
              equals(as.POSIXct(format(as.POSIXct(x)), tz = "UTC")))
})

test_that("force_tz handles various date-time classes", {
  x <- as.POSIXct("2008-12-03 13:01:59", tz = "America/New_York")
  
  expect_equal(force_tz(as.POSIXlt(x), "UTC"), 
    as.POSIXlt(format(x), tz = "UTC"))
})


test_that("force_tz doesn't return NA just because new time zone uses DST", {
  poslt <- as.POSIXlt("2009-03-14 02:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  poslt2 <- force_tz(poslt, tz = "America/New_York")
  
  expect_true(!is.na(poslt2))
})


test_that("olson_time_zones returns a non-trivial character vector", {
  tz_olson <- olson_time_zones()
  
  expect_true(length(tz_olson) > 0)
  expect_is(tz_olson, "character")
})