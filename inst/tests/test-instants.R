context("instants")

test_that("is.instant/is.timepoint works as expected",{
  expect_that(is.instant(234), is_false())
  expect_that(is.instant(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_true())
  expect_that(is.instant(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_true())
  expect_that(is.instant(Sys.Date()), is_true())
  expect_that(is.instant(minutes(1)), is_false())
  expect_that(is.timespan(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})

test_that("is.instant/is.timepoint handle vectors",{
  expect_that(is.instant(minutes(1:2)), is_false())
  expect_that(is.instant(as.POSIXct(c("2008-08-03 13:01:59", 
  	"2008-08-03 13:01:59"), tz = "UTC")), is_true())
})

test_that("now() handles time zone input correctly",{
  expect_identical(floor_date(now("UTC"), "minute"), floor_date(as.POSIXct(format(
    as.POSIXct(Sys.time()), tz = "UTC"), tz = "UTC"), "minute"))
})

test_that("today() works correctly",{
  expect_identical(today(), Sys.Date())
})