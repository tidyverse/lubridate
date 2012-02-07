context("timespans")

test_that("is.timespan works as expected",{
  expect_that(is.timespan(234), is_false())
  expect_that(is.timespan(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.timespan(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.timespan(Sys.Date()), is_false())
  expect_that(is.timespan(minutes(1)), is_true())
  expect_that(is.timespan(eminutes(1)), is_true())
  expect_that(is.timespan(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})

test_that("is.timespan handles vectors",{
  expect_that(is.timespan(minutes(1:3)), is_true())
})