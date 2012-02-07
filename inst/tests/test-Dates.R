context("Dates")

test_that("is.Date works as expected",{
  expect_that(is.Date(234), is_false())
  expect_that(is.Date(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.Date(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.Date(Sys.Date()), is_true())
  expect_that(is.Date(minutes(1)), is_false())
  expect_that(is.Date(eminutes(1)), is_false())
  expect_that(is.Date(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_false())
})

test_that("is.Date handles vectors",{
  expect_that(is.Date(c(Sys.Date(), as.Date("2009-10-31"))),
    is_true())
})