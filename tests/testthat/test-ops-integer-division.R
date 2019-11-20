context("Integer division operations")

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
