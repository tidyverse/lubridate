context("Time zones")

test_that("with_tz works as expected", {
  x <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  
  expect_that(with_tz(x, "UTC"), equals(as.POSIXct(format(
    as.POSIXct(x), tz = "UTC"), tz = "UTC")))
})

test_that("with_tz handles vectors", {
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 10:01:59"), tz = "America/New_York")
  
  expect_that(with_tz(x, "UTC"), equals(as.POSIXct(format(
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
  x <- as.POSIXct("2008-08-03 13:01:59", tz = "America/New_York")
  
  expect_that(force_tz(as.POSIXlt(x), "UTC"), 
              equals(as.POSIXlt(format(as.POSIXct(x)), tz = "UTC")))
})