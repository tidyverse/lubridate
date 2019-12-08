context("Integer division operations")

test_that("integer division concatenates and recycles correctly", {

  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  int3 <- ymd("2009-01-01") %--% ymd("2010-01-01")

  expect_equal(int1 %/% ddays(1:2), c(365, 182))
  expect_equal(int1 %/% days(1:2), c(365, 182))
  expect_equal(c(int1, int2) %/% ddays(2), c(182, 365))
  expect_equal(c(int1, int2) %/% days(2), c(182, 365))
  expect_equal(dyears(1) %/% ddays(1:2), c(365, 182))
  expect_equal(dyears(1:2) %/% ddays(2), c(182, 365))
  expect_equal(months(c(13, 26)) %/% years(2), c(0, 1))
  expect_equal(months(13) %/% years(c(1, 2)), c(1, 0))

})

test_that("integer division works for interval numerator", {

  verify_output(test_path("test-ops-integer-division.txt"), {
    int <- ymd("2010-01-01") %--% ymd("2010-06-01")
    dur <- ddays(1)
    per <- months(1)

    "# Interval numerator"
    int %/% int
    int %/% dur
    int %/% per

    "# Duration numerator"
    dur %/% int
    dur %/% dur
    dur %/% per

    "# Period numeric"
    per %/% int
    per %/% dur
    per %/% per
  })
})
