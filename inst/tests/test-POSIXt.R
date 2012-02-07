context("POSIXt")

test_that("is.POSIXt works as expected",{
  expect_that(is.POSIXt(234), is_false())
  expect_that(is.POSIXt(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_true())
  expect_that(is.POSIXt(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_true())
  expect_that(is.POSIXt(Sys.Date()), is_false())
  expect_that(is.POSIXt(minutes(1)), is_false())
  expect_that(is.POSIXt(eminutes(1)), is_false())
  expect_that(is.POSIXt(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_false())
})

test_that("is.POSIXt handles vectors",{
  expect_that(is.POSIXt(c(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})