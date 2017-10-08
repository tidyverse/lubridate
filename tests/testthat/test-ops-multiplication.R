context("Multiplication operations")


# multiplication for everything

test_that("multiplication throws error for instants", {
  x <- as.POSIXct("2010-03-15 00:00:00", tz = "UTC")

  expect_that(3 * x, throws_error())

})

test_that("multiplication throws error for intervals", {
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- interval(time1, time2)
  diff <- difftime(time2, time1)
  int2 <- interval(time1, time1 + 2*diff)

  expect_that(2*int, equals(int2))
})

test_that("multiplication works as expected for periods", {

  expect_that(3*months(1), equals(months(3)))
  expect_that(3*months(1), is_a("Period"))

})

test_that("multiplying vectors works for periods", {

  expect_that(c(2, 3)*months(1), equals(months(2:3)))
  expect_that(c(2, 3)*months(1), is_a("Period"))

})

test_that("multiplication works as expected for durations", {

  expect_that(3*dhours(1), equals(dhours(3)))
  expect_that(3*dhours(1), is_a("Duration"))

})

test_that("multiplying vectors works for durations", {

  expect_that(c(2, 3)*dhours(1), equals(dhours(2:3)))
  expect_that(c(2, 3)*dhours(1), is_a("Duration"))

})


test_that("make_difftime makes a correct difftime object", {
  x <- as.POSIXct("2008-01-01 12:00:00", tz = "UTC")
  y <- difftime(x + 3600, x)
  attr(y, "tzone") <- NULL

  expect_that(make_difftime(3600), equals(y))
  expect_that(make_difftime(3600), is_a("difftime"))
})
