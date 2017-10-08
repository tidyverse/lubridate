context("Integer division operations")

test_that("integer division works for interval numerator", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  expect_error(int1 %/% int2)
  expect_equal(int1 %/% months(1), 12)
  expect_error(months(12) %/% int1)
  expect_equal(int1 %/% ddays(1), 365)
  expect_error(ddays(365) %/% int1)
})


test_that("integer division works for interval numerator with vectors", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  int3 <- ymd("2009-01-01") %--% ymd("2010-01-01")
  expect_error(int2 %/% c(int1, int3))
  expect_error(c(int1, int2) %/% int3)
  expect_equal(int1 %/% months(1:2), c(12, 6))
  expect_error(months(c(6, 12)) %/% int1)
  expect_equal(int1 %/% ddays(1:2), c(365, 182))
  expect_equal(c(int1, int2) %/% ddays(2), c(182, 365))
})


test_that("integer division works for period numerator", {
  int1 <- ymd("2010-01-01") %--% ymd("2010-12-31")
  expect_error(years(2) %/% int1)
  expect_equal(years(1) %/% days(1), 365)
  expect_equal(months(13) %/% years(1), 1)
  expect_error(months(1) %/% ddays(1))
})

test_that("integer division works for period numerator with vectors", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  expect_error(years(2) %/% c(int1, int2))
  expect_error(years(1:2) %/% int1)
  expect_equal(years(1) %/% months(1:2), c(12, 6))
  expect_equal(months(c(6, 12)) %/% years(1), c(0, 1))
  expect_error(years(1) %/% ddays(1:2))
  expect_error(years(1:2) %/% ddays(2))
})

test_that("integer division works for duration numerator", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  expect_error(dyears(2) %/% int1)
  expect_error(dyears(1) %/% months(1))
  expect_equal(dyears(1) %/% ddays(1), 365)
})

test_that("integer division works for duration numerator with vectors", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  expect_error(dyears(2) %/% c(int1, int2))
  expect_error(dyears(1:2) %/% int1)
  expect_error(dyears(1) %/% months(1:2))
  expect_error(dyears(1:2) %/% years(1))
  expect_equal(dyears(1) %/% ddays(1:2), c(365, 182))
  expect_equal(dyears(1:2) %/% ddays(2), c(182, 365))
})


test_that("integer division works with Period denominator (#235)", {
  a <- interval(ymd(20140331), ymd(20140519))
  expect_equal(a %/% months(1), 1)
  a <- interval(ymd(20140331), ymd(20140419))
  expect_equal(a %/% months(1), 0)
})
