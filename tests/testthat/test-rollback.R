test_that("rollback returns correct results", {
  expect_equal(
    rollback(ymd_hms("2010-03-03 12:44:22")),
    ymd_hms("2010-02-28 12:44:22")
  )
  expect_equal(
    rollback(ymd_hms("2010-03-03 12:44:22"), preserve_hms = FALSE),
    ymd_hms("2010-02-28 00:00:00")
  )
  expect_equal(
    rollback(ymd_hms("2010-03-03 12:44:22"), roll_to_first = TRUE),
    ymd_hms("2010-03-01 12:44:22")
  )
  expect_equal(
    rollback(ymd_hms("2010-03-03 12:44:22"), roll_to_first = TRUE, preserve_hms = FALSE),
    ymd_hms("2010-03-01 00:00:00")
  )
})


test_that("rollback works with missing numbers", {
  expect_equal(
    ymd(c("20150131", NA)) %m+% months(1),
    ymd(c("201502-28", NA))
  )
  expect_equal(
    rollbackward(ymd(c("2015-03-31", NA))),
    ymd(c("201502-28", NA))
  )
})


test_that("rollforward returns correct results", {
  expect_equal(
    rollforward(ymd_hms("2010-02-03 12:44:22")),
    ymd_hms("2010-02-28 12:44:22")
  )
  expect_equal(
    rollforward(ymd_hms("2010-02-03 12:44:22"), preserve_hms = FALSE),
    ymd_hms("2010-02-28 00:00:00")
  )
  expect_equal(
    rollforward(ymd_hms("2010-02-03 12:44:22"), roll_to_first = TRUE),
    ymd_hms("2010-03-01 12:44:22")
  )
  expect_equal(
    rollforward(ymd_hms("2010-02-03 12:44:22"), roll_to_first = TRUE, preserve_hms = FALSE),
    ymd_hms("2010-03-01 00:00:00")
  )
})


test_that("rollforward works with missing numbers", {
  expect_equal(
    ymd(c("20150131", NA)) %m+% months(1),
    ymd(c("201502-28", NA))
  )

  expect_equal(
    rollforward(ymd(c("20150203", NA))),
    ymd(c("2015-02-28", NA))
  )
})
