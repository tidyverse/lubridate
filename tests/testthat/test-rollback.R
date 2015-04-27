context("rollback")

test_that("rollback returns correct results",{
  expect_equal(rollback(ymd_hms("2010-03-03 12:44:22")),
               ymd_hms("2010-02-28 12:44:22"))
  expect_equal(rollback(ymd_hms("2010-03-03 12:44:22"), preserve_hms = FALSE),
               ymd_hms("2010-02-28 00:00:00"))
  expect_equal(rollback(ymd_hms("2010-03-03 12:44:22"), roll_to_first = TRUE),
               ymd_hms("2010-03-01 12:44:22"))
  expect_equal(rollback(ymd_hms("2010-03-03 12:44:22"), roll_to_first = TRUE, preserve_hms = FALSE),
               ymd_hms("2010-03-01 00:00:00"))
})

