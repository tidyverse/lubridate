context("Utilities")

test_that("leap_year correctly identifies leap years",{
  x <- as.POSIXct("2009-08-03 12:01:59", tz = "UTC")
  y <- as.POSIXct("2008-08-03 12:01:59", tz = "UTC")
  
  expect_that(leap_year(x), is_false())
  expect_that(leap_year(y), is_true())
})

test_that("leap_year handles vectors",{
  x <- as.POSIXct(c("2008-08-03 12:01:59", "2009-08-03 12:01:59"), tz = "UTC")
  
  expect_that(leap_year(x)[1], is_true())
  expect_that(leap_year(x)[2], is_false())
  expect_that(leap_year(as.Date(x))[1], is_true())
  expect_that(leap_year(as.Date(x))[2], is_false())
})

test_that("leap_year handles various classes of date-time object",{
  x <- as.POSIXct(c("2008-08-03 12:01:59", "2009-08-03 12:01:59"), tz = "UTC")
  
  expect_that(leap_year(x)[1], is_true())
  expect_that(leap_year(x)[2], is_false())
  expect_that(leap_year(as.Date(x))[1], is_true())
  expect_that(leap_year(as.Date(x))[2], is_false())
  expect_that(leap_year(as.POSIXlt(x))[1], is_true())
  expect_that(leap_year(as.POSIXlt(x))[2], is_false())
})


test_that("now() handles time zone input correctly",{
  expect_that(now("UTC"), equals(as.POSIXct(format(
    as.POSIXct(Sys.time()), tz = "UTC"), tz = "UTC")))
})

test_that("today() works correctly",{
  expect_that(today(), equals(Sys.Date()))
})

test_that("am and pm correctly identify time of day",{
  x <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  y <- as.POSIXct("2008-08-03 10:01:59", tz = "UTC")
  
  expect_that(am(x), is_false())
  expect_that(am(y), is_true())
  
  expect_that(pm(x), is_true())
  expect_that(pm(y), is_false())
})

test_that("am and pm handle vectors",{
  x <- as.POSIXct(c("2009-08-03 13:01:59", "2008-08-03 10:01:59"), tz = "UTC")
  y <- as.POSIXct(c("2009-08-03 10:01:59", "2008-08-03 13:01:59"), tz = "UTC")
  
  expect_that(pm(x)[1], is_true())
  expect_that(pm(x)[2], is_false())
  expect_that(am(y)[1], is_true())
  expect_that(am(y)[2], is_false())
})

test_that("am and pm handle various classes of date-time object",{
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 10:01:59"), tz = "UTC")
  
  expect_that(pm(x)[1], is_true())
  expect_that(pm(x)[2], is_false())
  expect_that(pm(as.Date(x))[1], is_false())
  expect_that(pm(as.POSIXlt(x))[1], is_true())
  expect_that(pm(as.POSIXlt(x))[2], is_false())
})


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


test_that("decimal_date works as expected",{
  x <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  
  expect_that(decimal_date(x), equals(2008.58846))
})

test_that("decimal_date works handles vectors",{
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 10:01:59"), tz = "UTC")
  
  expect_that(round(decimal_date(x), 3), equals(c(2008.589, 2009.587)))
  
})