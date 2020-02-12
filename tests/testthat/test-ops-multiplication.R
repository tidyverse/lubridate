context("Multiplication operations")


# multiplication for everything

test_that("multiplication throws error for instants", {
  x <- as.POSIXct("2010-03-15 00:00:00", tz = "UTC")

  expect_error(3 * x)

})

test_that("multiplication throws error for intervals", {
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- interval(time1, time2)
  diff <- difftime(time2, time1)
  int2 <- interval(time1, time1 + 2*diff)

  expect_equal(2*int, int2)
})

test_that("multiplication works as expected for periods", {

  expect_equal(3*months(1), months(3))
  expect_is(3*months(1), "Period")

})

test_that("multiplying vectors works for periods", {

  expect_equal(c(2, 3)*months(1), months(2:3))
  expect_is(c(2, 3)*months(1), "Period")

})

test_that("multiplication works as expected for durations", {

  expect_equal(3*dhours(1), dhours(3))
  expect_is(3*dhours(1), "Duration")

})

test_that("multiplying vectors works for durations", {

  expect_equal(c(2, 3)*dhours(1), dhours(2:3))
  expect_is(c(2, 3)*dhours(1), "Duration")

})


test_that("make_difftime makes a correct difftime object", {
  x <- as.POSIXct("2008-01-01 12:00:00", tz = "UTC")
  y <- difftime(x + 3600, x)
  attr(y, "tzone") <- NULL

  expect_equal(make_difftime(3600), y)
  expect_is(make_difftime(3600), "difftime")
})
