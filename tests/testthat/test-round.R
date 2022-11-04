test_that("floor_date works as expected with POSIX units", {
  set.seed(11111)
  x <- ymd_hms(c("2020-01-03 00:01:03", "2020-02-04 00:01:03", "2020-03-05 00:00:00"), tz = "America/New_York")
  min <- min(x)
  b <- ymd_hms(c("2020-01-03 00:00:01", "2020-02-05 00:00:01"))
  expect_equal(floor_date(x, b), b[c(1, 1, 2)])
  expect_equal(floor_date(x, sample(b)), b[c(1, 1, 2)])
  expect_equal(floor_date(x, rev(b)), b[c(1, 1, 2)])
  expect_equal(floor_date(b, x), with_tz(c(b[1], x[2]), "America/New_York"))
  expect_equal(floor_date(b, sample(x)), with_tz(c(b[1], x[2]), "America/New_York"))
  expect_equal(floor_date(rev(b), x), with_tz(rev(c(b[1], x[2])), "America/New_York"))
  expect_equal(floor_date(rev(x), b), rev(b[c(1, 1, 2)]))
  expect_equal(floor_date(x, b[[2]]), c(with_tz(c(min, min), "UTC"), b[[2]]))
  expect_equal(floor_date(ymd_hms("2030-01-01 00:03:00"), x), x[[3]])
  expect_equal(floor_date(y <- ymd_hms("2010-01-01 00:03:00"), x), with_tz(y, "America/New_York"))
  expect_equal(floor_date(ymd_hms("2030-01-01 00:03:00"), b), b[2])
})

test_that("floor_date works as expected with Date units", {
  set.seed(11111)
  x <- ymd(c("2020-01-03", "2020-02-04", "2020-03-05"))
  min <- min(x)
  b <- ymd(c("2020-01-03", "2020-02-05"))
  expect_equal(floor_date(x, b), b[c(1, 1, 2)])
  expect_equal(floor_date(x, sample(b)), b[c(1, 1, 2)])
  expect_equal(floor_date(x, rev(b)), b[c(1, 1, 2)])
  expect_equal(floor_date(b, x), c(b[1], x[2]))
  expect_equal(floor_date(b, sample(x)), c(b[1], x[2]))
  expect_equal(floor_date(rev(b), x), rev(c(b[1], x[2])))
  expect_equal(floor_date(rev(x), b), rev(b[c(1, 1, 2)]))
  expect_equal(floor_date(x, b[[2]]), c(c(min, min), b[[2]]))
  expect_equal(floor_date(ymd("2030-01-01"), x), x[[3]])
  expect_equal(floor_date(y <- ymd("2010-01-01"), x), y)
  expect_equal(floor_date(ymd("2030-01-01"), b), b[2])
})

test_that("ceiling_date works as expected with POSIX units", {
  set.seed(11111)
  x <- ymd_hms(c("2020-01-03 00:01:03", "2020-02-04 00:01:03", "2020-03-05 00:00:00"), tz = "America/New_York")
  na <- x
  na[[2]] <- NA
  max <- max(x)
  b <- ymd_hms(c("2020-01-03 00:00:01", "2020-02-05 00:00:01"))
  expect_equal(ceiling_date(x, b), c(b[c(2, 2)], max))
  expect_equal(ceiling_date(na, b), c(b[2], NA, max))
  expect_equal(ceiling_date(rev(x), b), rev(c(b[c(2, 2)], max)))
  expect_equal(ceiling_date(x, sample(b)), c(b[c(2, 2)], max))
  expect_equal(ceiling_date(x, rev(b)), c(b[c(2, 2)], max))
  expect_equal(ceiling_date(b, x), x[c(1, 3)])
  expect_equal(ceiling_date(b, sample(x)), x[c(1, 3)])
  expect_equal(ceiling_date(rev(b), x), rev(x[c(1, 3)]))
  expect_equal(ceiling_date(x, b[[2]]), c(b[c(2, 2)], max))
  expect_equal(ceiling_date(y <- ymd_hms("2030-01-01 00:03:00"), x), with_tz(y, "America/New_York"))
  expect_equal(ceiling_date(y <- ymd_hms("2010-01-01 00:03:00"), x), x[[1]])
})

test_that("ceiling_date works as expected with Date units", {
  set.seed(11111)
  x <- ymd(c("2020-01-04", "2020-02-04", "2020-03-05"))
  na <- x
  na[[2]] <- NA
  max <- max(x)
  b <- ymd(c("2020-01-03", "2020-02-05"))
  expect_equal(ceiling_date(x, b), c(b[c(2, 2)], max))
  expect_equal(ceiling_date(x, rep(b, 3)), c(b[c(2, 2)], max))
  expect_equal(ceiling_date(na, b), c(b[2], NA, max))
  expect_equal(ceiling_date(rev(x), b), rev(c(b[c(2, 2)], max)))
  expect_equal(ceiling_date(x, sample(b)), c(b[c(2, 2)], max))
  expect_equal(ceiling_date(x, rev(b)), c(b[c(2, 2)], max))
  expect_equal(ceiling_date(b, x), x[c(1, 3)])
  expect_equal(ceiling_date(b, sample(rep(x, 8))), x[c(1, 3)])
  expect_equal(ceiling_date(rev(b), x), rev(x[c(1, 3)]))
  expect_equal(ceiling_date(x, b[[2]]), c(b[c(2, 2)], max))
  expect_equal(ceiling_date(y <- ymd("2030-01-01"), x), y)
  expect_equal(ceiling_date(y <- ymd("2010-01-01"), x), x[[1]])
})

test_that("round_date works as expected with Date units", {
  set.seed(11111)
  x <- ymd(c("2020-01-04", "2020-02-04", "2020-03-05"))
  na <- x
  na[[2]] <- NA
  max <- max(x)
  b <- ymd(c("2020-01-03", "2020-02-05"))
  expect_equal(round_date(x, b), b[c(1, 2, 2)])
  expect_equal(round_date(na, b), c(b[1], NA, b[2]))
  expect_equal(round_date(rev(x), b), b[c(2, 2, 1)])
  expect_equal(round_date(x, sample(b)), b[c(1, 2, 2)])
  expect_equal(round_date(x, rev(b)), b[c(1, 2, 2)])
  expect_equal(round_date(x, rep(b, 10)), b[c(1, 2, 2)])
  expect_equal(round_date(b, x), x[c(1, 2)])
  expect_equal(round_date(b, sample(x)), x[c(1, 2)])
  expect_equal(round_date(rev(b), x), rev(x[c(1, 2)]))
  expect_equal(round_date(y <- ymd("2030-01-01"), x), x[3])
  expect_equal(round_date(y <- ymd("2010-01-01"), x), x[1])
})

test_that("round_date works on POSIXlt objects", {
  x <- as.POSIXlt(ymd_hms(c("2012-11-01 23:41:00", "2012-11-01 00:44:10"), tz = "America/New_York"))
  expect_equal(
    round_date(x, "5 mins"),
    as.POSIXlt(ymd_hms(c("2012-11-01 23:40:00", "2012-11-01 00:45:00"), tz = "America/New_York"))
  )
})

test_that("round_date fails with invalid date-time units", {
  expect_error(round_date(now(), .POSIXct(double())), "Zero")
  expect_error(floor_date(now(), .POSIXct(double())), "Zero")
  expect_error(ceiling_date(now(), .POSIXct(double())), "Zero")
  expect_error(round_date(now(), .POSIXct(NA_real_)), "NAs")
  expect_error(floor_date(now(), .POSIXct(NA_real_)), "NAs")
  expect_error(ceiling_date(now(), .POSIXct(NA_real_)), "NAs")
})

test_that("floor_date works for each time element", {
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  expect_identical(floor_date(x, "second"), as.POSIXct("2009-08-03 12:01:59", tz = "UTC"))
  expect_identical(floor_date(x, "minute"), as.POSIXct("2009-08-03 12:01:00", tz = "UTC"))
  expect_identical(floor_date(x, "hour"), as.POSIXct("2009-08-03 12:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "day"), as.POSIXct("2009-08-03 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "week"), as.POSIXct("2009-08-02 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "month"), as.POSIXct("2009-08-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "bimonth"), as.POSIXct("2009-07-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "quarter"), as.POSIXct("2009-07-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "halfyear"), as.POSIXct("2009-07-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "year"), as.POSIXct("2009-01-01 00:00:00", tz = "UTC"))
})

test_that("floor_date and round_date throw on invalid multi-unit spec", {
  x <- ymd_hms("2009-08-03 12:01:57.11")

  expect_error(floor_date(x, "120 sec"))
  expect_error(floor_date(x, "120 min"))
  expect_error(floor_date(x, "25 h"))
  expect_error(floor_date(x, "32 days"))
})

test_that("floor_date works for multi-units", {
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  expect_identical(floor_date(x, "2 secs"), as.POSIXct("2009-08-03 12:01:58", tz = "UTC"))
  expect_identical(floor_date(x, "2s"), as.POSIXct("2009-08-03 12:01:58", tz = "UTC"))
  expect_identical(floor_date(x, "2 mins"), as.POSIXct("2009-08-03 12:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "2M"), as.POSIXct("2009-08-03 12:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "2 hours"), as.POSIXct("2009-08-03 12:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "2h"), as.POSIXct("2009-08-03 12:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "2 days"), as.POSIXct("2009-08-03 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "3 days"), as.POSIXct("2009-08-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "10 days"), as.POSIXct("2009-08-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "10d"), as.POSIXct("2009-08-01 00:00:00", tz = "UTC"))
  ## expect_identical(floor_date(x, "2 week"), as.POSIXct("2009-08-xx 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "2 month"), as.POSIXct("2009-07-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "2m"), as.POSIXct("2009-07-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "2 bimonth"), floor_date(x, "4 months"))
  expect_identical(floor_date(x, "2 quarter"), floor_date(x, "6 months"))
  expect_identical(floor_date(x, "2 halfyear"), floor_date(x, "year"))
  expect_identical(floor_date(x, "2 year"), as.POSIXct("2008-01-01 00:00:00", tz = "UTC"))
})

test_that("floor_date works for fractional multi-units", {
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  expect_identical(floor_date(x, ".2 secs"), as.POSIXct("2009-08-03 12:01:59.2", tz = "UTC"))
  expect_identical(floor_date(x, ".1s"), as.POSIXct("2009-08-03 12:01:59.2", tz = "UTC"))
  expect_identical(floor_date(x, ".05s"), as.POSIXct("2009-08-03 12:01:59.2", tz = "UTC"))
  expect_identical(floor_date(x, ".01s"), as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC"))
  expect_identical(floor_date(x, ".005s"), as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC"))
  expect_identical(floor_date(x, ".5 mins"), as.POSIXct("2009-08-03 12:01:30", tz = "UTC"))
})

test_that("multi-unit rounding works the same for POSIX and Date objects", {
  px <- ymd("2009-08-01", tz = "UTC")
  dt <- ymd("2009-08-01")
  expect_identical(floor_date(px, "5 mins"), floor_date(dt, "5 mins"))
  expect_identical(floor_date(px, "5 mins"), floor_date(dt, "5 mins"))
  expect_identical(ceiling_date(px + 0.0001, "5 mins"), ceiling_date(dt, "5 mins"))
  expect_identical(
    ceiling_date(px, "5 mins", change_on_boundary = T),
    ceiling_date(dt, "5 mins", change_on_boundary = T)
  )
  expect_identical(ceiling_date(px + 0.001, "5 hours"), ceiling_date(dt, "5 hours"))
  expect_identical(ceiling_date(px + 0.0001, "5 hours", change_on_boundary = T), ceiling_date(dt, "5 hours", change_on_boundary = T))
  expect_identical(ceiling_date(px + 0.001, "2 hours"), ceiling_date(dt, "2 hours"))
  expect_identical(as_date(floor_date(px, "2 days")), floor_date(dt, "2 days"))
  expect_identical(as_date(ceiling_date(px + 0.001, "2 days")), ceiling_date(dt, "2 days"))
  expect_identical(as_date(floor_date(px, "5 days")), floor_date(dt, "5 days"))
  expect_identical(as_date(ceiling_date(px + 0.001, "5 days")), ceiling_date(dt, "5 days"))
  expect_identical(as_date(floor_date(px, "2 months")), floor_date(dt, "2 months"))
  expect_identical(as_date(ceiling_date(px, "2 months")), ceiling_date(dt, "2 months"))
  expect_identical(as_date(floor_date(px, "5 months")), floor_date(dt, "5 months"))
  expect_identical(as_date(ceiling_date(px, "5 months")), ceiling_date(dt, "5 months"))
})


test_that("ceiling_date works for multi-units", {
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  y <- as.POSIXct("2009-08-03 12:01:30.23", tz = "UTC")
  z <- as.POSIXct("2009-08-24 12:01:30.23", tz = "UTC")
  expect_identical(ceiling_date(x, "2 secs"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "3 secs"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "5 secs"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_identical(ceiling_date(y, "2 secs"), as.POSIXct("2009-08-03 12:01:32", tz = "UTC"))
  expect_identical(ceiling_date(y, "3 secs"), as.POSIXct("2009-08-03 12:01:33", tz = "UTC"))
  expect_identical(ceiling_date(y, "5 secs"), as.POSIXct("2009-08-03 12:01:35", tz = "UTC"))
  expect_identical(ceiling_date(x, "2 mins"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "3 mins"), as.POSIXct("2009-08-03 12:03:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "5 mins"), as.POSIXct("2009-08-03 12:05:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "2 hours"), as.POSIXct("2009-08-03 14:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "3 hours"), as.POSIXct("2009-08-03 15:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "2 days"), as.POSIXct("2009-08-05 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "3 days"), as.POSIXct("2009-08-04 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "10 days"), as.POSIXct("2009-08-11 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(z, "5 days"), as.POSIXct("2009-08-26 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(z, "10 days"), as.POSIXct("2009-08-31 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "2 month"), as.POSIXct("2009-09-01 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "2 bimonth"), ceiling_date(x, "4 months"))
  expect_identical(ceiling_date(x, "2 quarter"), ceiling_date(x, "6 months"))
  expect_identical(ceiling_date(x, "2 halfyear"), ceiling_date(x, "year"))
  expect_identical(ceiling_date(x, "2 year"), as.POSIXct("2010-01-01 00:00:00", tz = "UTC"))
})

test_that("ceiling_date works for fractional multi-units", {
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  expect_identical(ceiling_date(x, ".2 secs"), as.POSIXct("2009-08-03 12:01:59.4", tz = "UTC"))
  expect_identical(ceiling_date(x, ".1s"), as.POSIXct("2009-08-03 12:01:59.3", tz = "UTC"))
  expect_identical(ceiling_date(x, ".05s"), as.POSIXct("2009-08-03 12:01:59.25", tz = "UTC"))
  expect_identical(ceiling_date(x, ".5 mins"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
})

test_that("round_date works for each time element", {
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  expect_equal(round_date(x, "second"), as.POSIXct("2009-08-03 12:01:59", tz = "UTC"))
  expect_equal(round_date(x, "minute"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_equal(round_date(x, "hour"), as.POSIXct("2009-08-03 12:00:00", tz = "UTC"))
  expect_equal(round_date(x, "day"), as.POSIXct("2009-08-04 00:00:00", tz = "UTC"))
  expect_equal(round_date(x, "week"), as.POSIXct("2009-08-02 00:00:00", tz = "UTC"))
  expect_equal(round_date(x, "month"), as.POSIXct("2009-08-01 00:00:00", tz = "UTC"))
  expect_equal(round_date(x, "bimonth"), as.POSIXct("2009-09-01 00:00:00", tz = "UTC"))
  expect_equal(round_date(x, "quarter"), as.POSIXct("2009-07-01 00:00:00", tz = "UTC"))
  expect_equal(round_date(x, "halfyear"), as.POSIXct("2009-07-01 00:00:00", tz = "UTC"))
  expect_equal(round_date(x, "year"), as.POSIXct("2010-01-01 00:00:00", tz = "UTC"))
})

test_that("floor_date and ceiling_date work with leap years", {
  expect_equal(
    floor_date(ymd_hms(c("2016-02-29 1:2:3", "2016-03-01 10:20:30")), "year"),
    ymd_hms(c("2016-01-01 0:0:0", "2016-01-01 0:0:0"))
  )
  expect_equal(
    floor_date(ymd_hms(c("2016-02-29 1:2:3", "2016-03-01 10:20:30"), tz = "America/New_York"), "year"),
    ymd_hms(c("2016-01-01 0:0:0", "2016-01-01 0:0:0"), tz = "America/New_York")
  )
  expect_equal(
    ceiling_date(ymd_hms(c("2016-02-29 1:2:3", "2016-03-01 10:20:30")), "year"),
    ymd_hms(c("2017-01-01 0:0:0", "2017-01-01 0:0:0"))
  )
  expect_equal(
    ceiling_date(ymd_hms(c("2016-02-29 1:2:3", "2016-03-01 10:20:30"), tz = "America/New_York"), "year"),
    ymd_hms(c("2017-01-01 0:0:0", "2017-01-01 0:0:0"), tz = "America/New_York")
  )
})

test_that("round_date works for multi-units", {
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  expect_equal(round_date(x, "2 second"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_equal(round_date(x, "2 minute"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_equal(round_date(x, "3 mins"), as.POSIXct("2009-08-03 12:03:00", tz = "UTC"))
  expect_equal(round_date(x, "5 mins"), as.POSIXct("2009-08-03 12:00:00", tz = "UTC"))
  expect_equal(round_date(x, "2 hour"), as.POSIXct("2009-08-03 12:00:00", tz = "UTC"))
  expect_equal(round_date(x, "5 hour"), as.POSIXct("2009-08-03 10:00:00", tz = "UTC"))
  expect_equal(round_date(x, "2 days"), as.POSIXct("2009-08-03 00:00:00", tz = "UTC"))
  expect_equal(round_date(x, "2 months"), as.POSIXct("2009-09-01 00:00:00", tz = "UTC"))
  expect_equal(round_date(x, "bimonth"), round_date(x, "2 months"))
  expect_equal(round_date(x, "bimonth"), round_date(x, "4 months"))
  expect_equal(round_date(x, "quarter"), round_date(x, "3 months"))
  expect_equal(round_date(x, "halfyear"), round_date(x, "6 months"))
  expect_equal(round_date(x, "3 years"), as.POSIXct("2010-01-01 00:00:00", tz = "UTC"))
  expect_equal(round_date(x, "4 years"), as.POSIXct("2008-01-01 00:00:00", tz = "UTC"))
})

test_that("round_date works for fractional multi-units", {
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  expect_identical(round_date(x, ".2 secs"), as.POSIXct("2009-08-03 12:01:59.2", tz = "UTC"))
  expect_identical(round_date(x, ".1s"), as.POSIXct("2009-08-03 12:01:59.2", tz = "UTC"))
  expect_identical(round_date(x, ".05s"), as.POSIXct("2009-08-03 12:01:59.25", tz = "UTC"))
  expect_identical(round_date(x, ".5 mins"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
})

test_that("floor_date handles vectors", {
  x <- as.POSIXct(c(
    "2009-08-03 12:01:59.23",
    "2010-08-03 12:01:59.23"
  ), tz = "UTC")
  expect_identical(
    floor_date(x, "second"),
    as.POSIXct(c("2009-08-03 12:01:59", "2010-08-03 12:01:59"), tz = "UTC")
  )
  expect_identical(
    floor_date(x, "minute"),
    as.POSIXct(c("2009-08-03 12:01:00", "2010-08-03 12:01:00"), tz = "UTC")
  )
  expect_identical(
    floor_date(x, "hour"),
    as.POSIXct(c("2009-08-03 12:00:00", "2010-08-03 12:00:00"), tz = "UTC")
  )
  expect_identical(
    floor_date(x, "day"),
    as.POSIXct(c("2009-08-03 00:00:00", "2010-08-03 00:00:00"), tz = "UTC")
  )
  expect_identical(
    floor_date(x, "week"),
    as.POSIXct(c("2009-08-02 00:00:00", "2010-08-01 00:00:00"), tz = "UTC")
  )
  expect_identical(
    floor_date(x, "month"),
    as.POSIXct(c("2009-08-01 00:00:00", "2010-08-01 00:00:00"), tz = "UTC")
  )
  expect_identical(
    floor_date(x, "year"),
    as.POSIXct(c("2009-01-01 00:00:00", "2010-01-01 00:00:00"), tz = "UTC")
  )
})

test_that("ceiling_date handles vectors", {
  x <- as.POSIXct(c("2009-08-03 12:01:59.23", "2010-08-03 12:01:59.23"), tz = "UTC")
  expect_identical(
    ceiling_date(x, "second"),
    as.POSIXct(c("2009-08-03 12:02:00", "2010-08-03 12:02:00"), tz = "UTC")
  )
  expect_identical(
    ceiling_date(x, "minute"),
    as.POSIXct(c("2009-08-03 12:02:00", "2010-08-03 12:02:00"), tz = "UTC")
  )
  expect_identical(
    ceiling_date(x, "hour"),
    as.POSIXct(c("2009-08-03 13:00:00", "2010-08-03 13:00:00"), tz = "UTC")
  )
  expect_identical(
    ceiling_date(x, "day"),
    as.POSIXct(c("2009-08-04 00:00:00", "2010-08-04 00:00:00"), tz = "UTC")
  )
  expect_identical(
    ceiling_date(x, "week"),
    as.POSIXct(c("2009-08-09 00:00:00", "2010-08-08 00:00:00"), tz = "UTC")
  )
  expect_identical(
    ceiling_date(x, "month"),
    as.POSIXct(c("2009-09-01 00:00:00", "2010-09-01 00:00:00"), tz = "UTC")
  )
  expect_identical(
    ceiling_date(x, "year"),
    as.POSIXct(c("2010-01-01 00:00:00", "2011-01-01 00:00:00"), tz = "UTC")
  )
})


test_that("round_date handles vectors", {
  x <- as.POSIXct(c("2009-08-03 12:01:59.23", "2010-08-03 12:01:59.23"), tz = "UTC")
  expect_identical(
    round_date(x, "second"),
    as.POSIXct(c(
      "2009-08-03 12:01:59",
      "2010-08-03 12:01:59"
    ), tz = "UTC")
  )
  expect_identical(
    round_date(x, "minute"),
    as.POSIXct(c(
      "2009-08-03 12:02:00",
      "2010-08-03 12:02:00"
    ), tz = "UTC")
  )
  expect_identical(
    round_date(x, "hour"),
    as.POSIXct(c(
      "2009-08-03 12:00:00",
      "2010-08-03 12:00:00"
    ), tz = "UTC")
  )
  expect_identical(
    round_date(x, "day"),
    as.POSIXct(c(
      "2009-08-04 00:00:00",
      "2010-08-04 00:00:00"
    ), tz = "UTC")
  )
  expect_identical(
    round_date(x, "week"),
    as.POSIXct(c(
      "2009-08-02 00:00:00",
      "2010-08-01 00:00:00"
    ), tz = "UTC")
  )
  expect_identical(
    round_date(x, "month"),
    as.POSIXct(c(
      "2009-08-01 00:00:00",
      "2010-08-01 00:00:00"
    ), tz = "UTC")
  )
  expect_identical(
    round_date(x, "year"),
    as.POSIXct(c(
      "2010-01-01 00:00:00",
      "2011-01-01 00:00:00"
    ), tz = "UTC")
  )
})

test_that("floor_date works for a variety of formats", {
  x <- as.POSIXct("2009-08-03 12:01:59", tz = "UTC")

  expect_equal(
    floor_date(x, "minute"),
    as.POSIXct("2009-08-03 12:01:00", tz = "UTC")
  )
  expect_equal(
    floor_date(as.Date(x), "month"),
    as.Date("2009-08-01")
  )
  expect_equal(
    floor_date(as.Date(x), "bimonth"),
    ymd("2009-07-01")
  )
  expect_equal(
    floor_date(as.Date(x), "quarter"),
    ymd("2009-07-01")
  )
  expect_equal(
    floor_date(as.Date(x), "halfyear"),
    ymd("2009-07-01")
  )
  expect_equal(
    floor_date(as.POSIXlt(x), "minute"),
    as.POSIXlt(as.POSIXct("2009-08-03 12:01:00", tz = "UTC"))
  )
})

test_that("ceiling_date works for a variety of formats", {
  x <- as.POSIXct("2009-08-03 12:01:59", tz = "UTC")

  expect_equal(
    ceiling_date(x, "minute"),
    as.POSIXct("2009-08-03 12:02:00", tz = "UTC")
  )
  expect_equal(
    ceiling_date(as.Date(x), "month"),
    as.Date("2009-09-01")
  )
  expect_equal(
    ceiling_date(as.Date(x), "bimonth"),
    ymd("2009-09-01")
  )
  expect_equal(
    ceiling_date(as.Date(x), "quarter"),
    ymd("2009-10-01")
  )
  expect_equal(
    ceiling_date(as.Date(x), "halfyear"),
    ymd("2010-01-01")
  )
  expect_equal(
    ceiling_date(as.POSIXlt(x), "minute"),
    as.POSIXlt(as.POSIXct("2009-08-03 12:02:00",
      tz =
        "UTC"
    ))
  )
})

test_that("round_date works for a variety of formats", {
  x <- as.POSIXct("2009-08-03 12:01:59", tz = "UTC")
  expect_equal(round_date(x, "minute"), as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_equal(round_date(as.Date(x), "month"), as.Date("2009-08-01"))

  expect_equal(
    # Workaround for https://github.com/r-lib/testthat/issues/1710
    structure(round_date(as.POSIXlt(x), "minute"), balanced = NULL),
    structure(as.POSIXlt(as.POSIXct("2009-08-03 12:02:00", tz = "UTC")), balanced = NULL))

  ## https://github.com/tidyverse/lubridate/issues/1008
  y <- as.Date("2021-01-31")
  expect_equal(round_date(y, "month"), as.Date("2021-02-01"))
})


test_that("rounding works across DST", {
  ## https://github.com/tidyverse/lubridate/issues/399
  tt <- ymd("2016-03-27", tz = "Europe/Helsinki")
  expect_equal(ceiling_date(tt, "month"), as.POSIXct("2016-04-01", tz = "Europe/Helsinki"))
  expect_equal(ceiling_date(tt, "day"), as.POSIXct("2016-03-27", tz = "Europe/Helsinki"))
  tt <- ymd("2016-03-28", tz = "Europe/Helsinki")
  expect_equal(floor_date(tt, "month"), as.POSIXct("2016-03-01", tz = "Europe/Helsinki"))
  tt <- ymd_hms("2016-03-27 05:00:00", tz = "Europe/Helsinki")
  expect_equal(floor_date(tt, "day"), as.POSIXct("2016-03-27", tz = "Europe/Helsinki"))
  ## https://github.com/tidyverse/lubridate/issues/605
  x <- ymd_hms("2017-11-05 23:59:03", tz = "America/New_York")
  expect_equal(ceiling_date(x, "day"), as.POSIXct("2017-11-06", tz = "America/New_York"))
})

test_that("Ceiling for partials (Date) rounds up on boundary", {
  expect_identical(ceiling_date(as.Date("2012-09-27"), "day"), ymd("2012-09-28"))
  expect_identical(ceiling_date(as.Date("2012-09-01"), "day"), ymd("2012-09-02"))
  expect_identical(ceiling_date(as.Date("2012-09-01"), "2 days"), ymd("2012-09-03"))
})

test_that("Ceiling for Date returns date when unit level is higher than day", {
  expect_true(is.Date(ceiling_date(ymd("20160927"), "year")))
  expect_true(is.Date(ceiling_date(ymd("20160927"), "halfyear")))
  expect_true(is.Date(ceiling_date(ymd("20160927"), "quarter")))
  expect_true(is.Date(ceiling_date(ymd("20160927"), "bimonth")))
  expect_true(is.Date(ceiling_date(ymd("20160927"), "month")))
  expect_true(is.Date(ceiling_date(ymd("20160927"), "week")))
  expect_true(is.Date(ceiling_date(ymd("20160927"), "day")))
  expect_true(is.POSIXct(ceiling_date(ymd("20160927"), "hour")))
  expect_true(is.POSIXct(ceiling_date(ymd("20160927"), "minute")))
  expect_true(is.POSIXct(ceiling_date(ymd("20160927"), "second")))
})

test_that("Ceiling for POSIXct always returns POSIXct", {
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "year")))
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "halfyear")))
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "quarter")))
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "bimonth")))
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "month")))
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "week")))
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "day")))
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "hour")))
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "minute")))
  expect_true(is.POSIXct(ceiling_date(ymd_hms("20160927 00:00:00"), "second")))
})

test_that("ceiling_date does not round up dates that are already on a boundary", {
  expect_equal(ceiling_date(ymd_hms("2012-09-01 00:00:00"), "month"), as.POSIXct("2012-09-01", tz = "UTC"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 00:00:00"), "year"), as.POSIXct("2012-01-01", tz = "UTC"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 00:00:00"), "2 year"), as.POSIXct("2012-01-01", tz = "UTC"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 00:00:00"), "3 year"), as.POSIXct("2013-01-01", tz = "UTC"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 00:00:00"), "5 year"), as.POSIXct("2015-01-01", tz = "UTC"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 01:00:00"), "second"), ymd_hms("2012-01-01 01:00:00"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 01:00:00"), "2 second"), ymd_hms("2012-01-01 01:00:00"))
  expect_equal(
    ceiling_date(ymd_hms("2012-01-01 01:00:00"), "2 second", change_on_boundary = T),
    ymd_hms("2012-01-01 01:00:02")
  )
  expect_equal(ceiling_date(ymd_hms("2012-01-01 01:00:00"), "5 second"), ymd_hms("2012-01-01 01:00:00"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 00:00:00"), "bimonth"), ymd_hms("2012-01-01 00:00:00"))
})

test_that("ceiling_date does round up dates on a boundary with change_on_boundary=TRUE", {
  expect_equal(ceiling_date(as.Date("2012-09-27"), "day", TRUE), as.Date("2012-09-28"))
  expect_equal(ceiling_date(as.Date("2012-09-01"), "month", TRUE), as.Date("2012-10-01"))
  expect_equal(ceiling_date(ymd_hms("2012-09-01 00:00:00"), "month", TRUE), ymd("2012-10-01", tz = "UTC"))
  expect_equal(ceiling_date(ymd_hms("2012-09-01 00:00:00"), "bimonth", TRUE), ymd("2012-11-01", tz = "UTC"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 00:00:00"), "year", TRUE), as.POSIXct("2013-01-01", tz = "UTC"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 01:00:00"), "hour", TRUE), ymd_hms("2012-01-01 02:00:00"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 00:00:00"), "day", TRUE), ymd("2012-01-02", tz = "UTC"))
  expect_equal(ceiling_date(ymd_hms("2012-01-01 01:00:00"), "second", TRUE), ymd_hms("2012-01-01 01:00:01"))
})

test_that("floor_date does not round down dates that are already on a boundary", {
  expect_equal(floor_date(as.Date("2012-09-27"), "day"), as.Date("2012-09-27"))
})

test_that("round_date does not round dates that are already on a boundary", {
  expect_equal(round_date(as.Date("2012-09-27"), "day"), as.Date("2012-09-27"))
})

test_that("ceiling_date returns input of length zero when given input of length zero", {
  x <- structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt"))
  expect_equal(ceiling_date(x), x)
})

test_that("floor_date returns input of length zero when given input of length zero", {
  x <- structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt"))
  expect_equal(floor_date(x), x)
})

test_that("round_date returns input of length zero when given input of length zero", {
  x <- structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt"))
  expect_equal(round_date(x), x)
})

test_that("round_date behaves correctly on 60th second", {
  ## (bug #217)
  x <- ymd_hms("2013-12-01 23:59:59.9999")
  expect_equal(
    round_date(x, unit = "second"),
    ymd("2013-12-02", tz = "UTC")
  )
  second(x) <- 60
  expect_equal(x, ymd("2013-12-02", tz = "UTC"))
})

test_that("round_date and ceiling_date skip day time gap", {

  ##  (#240)
  tz <- "Europe/Amsterdam"
  times <- ymd_hms("2013-03-31 01:00:00 CET", "2013-03-31 01:15:00 CEST",
    "2013-03-31 01:30:00 CEST", "2013-03-31 01:45:00 CEST",
    "2013-03-31 03:00:00 CEST", "2013-03-31 03:15:00 CEST",
    tz = tz
  )

  round <- ymd_hms("2013-03-31 01:00:00 CET",
    "2013-03-31 01:00:00 CEST", "2013-03-31 03:00:00 CEST",
    "2013-03-31 03:00:00 CEST", "2013-03-31 03:00:00 CEST",
    "2013-03-31 03:00:00 CEST",
    tz = tz
  )
  expect_equal(round_date(times, "hour"), round)

  ceiling <- ymd_hms("2013-03-31 01:00:00 CET",
    "2013-03-31 03:00:00 CEST", "2013-03-31 03:00:00 CEST",
    "2013-03-31 03:00:00 CEST", "2013-03-31 03:00:00 CEST",
    "2013-03-31 04:00:00 CEST",
    tz = tz
  )
  expect_equal(ceiling_date(times, "hour"), ceiling)


  tz <- "America/Chicago"

  x <- ymd_hms(c(
    "2014-03-09 00:00:00", "2014-03-09 00:29:59", "2014-03-09 00:30:00",
    "2014-03-09 00:59:59", "2014-03-09 01:35:00", "2014-03-09 03:15:00",
    "2014-11-02 00:30:00", "2014-11-02 00:59:59", "2014-11-02 01:35:00",
    "2014-11-02 02:15:00", "2014-11-02 02:45:00"
  ),
  tz = tz
  )

  y <- as.POSIXct(c(
    "2014-03-09 00:00:00", "2014-03-09 00:00:00", "2014-03-09 01:00:00",
    "2014-03-09 01:00:00", "2014-03-09 03:00:00", "2014-03-09 03:00:00",
    "2014-11-02 01:00:00", "2014-11-02 01:00:00", "2014-11-02 02:00:00",
    "2014-11-02 02:00:00", "2014-11-02 03:00:00"
  ),
  tz = tz
  )

  ## ymd_hms("2014-11-02 01:35:00", tz = tz)
  ## force_tz(ymd_hms("2014-11-02 01:35:00"), tzone = "America/Chicago")
  ## round_date(ymd_hms("2014-11-02 01:35:00", tz = "America/Chicago"), "hour")
  expect_equal(round_date(x, "hour"), y)


})

test_that("rounding works within repeated DST", {
  ## "2014-11-02 00:00:00 CDT"
  ref <- ymd_hms("2014-11-02 00:00:00", tz = "America/Chicago")

  expect_equal(round_date(ref + dminutes(25), "hour"), ref)
  expect_equal(round_date(ref + dminutes(35), "hour"), ref + dhours(1))
  expect_equal(round_date(ref + dhours(1) + dminutes(25), "hour"), ref + dhours(1))
  expect_equal(round_date(ref + dhours(1) + dminutes(35), "hour"), ref + dhours(2))
  expect_equal(round_date(ref + dhours(2) + dminutes(20), "hour"), ref + dhours(2))
  expect_equal(round_date(ref + dhours(2) + dminutes(35), "hour"), ref + dhours(3))

  expect_equal(round_date(ref + duration("1H 35M 2S"), "minute"), ref + duration("1H 35M"))
  expect_equal(round_date(ref + duration("1H 35M 35S"), "minute"), ref + duration("1H 36M"))
  expect_equal(round_date(ref + duration("2H 35M 2S"), "minute"), ref + duration("2H 35M"))
})

test_that("ceiling_date, round_date and floor_date behave correctly with NA", {
  ## (bug #486)
  x <- ymd_hms("2009-08-03 12:01:59.23", tz = "UTC") + (0:1) * days()
  x[2] <- NA
  expect_equal(ceiling_date(x, unit = "day"), ymd(c("2009-08-04", NA), tz = "UTC"))
  expect_equal(ceiling_date(x, unit = "seconds"), ymd_hms(c("2009-08-03 12:02:00", NA), tz = "UTC"))
  expect_equal(ceiling_date(x, unit = "months"), ymd(c("2009-09-01", NA), tz = "UTC"))
  expect_equal(floor_date(x, unit = "day"), ymd(c("2009-08-03", NA), tz = "UTC"))
  expect_equal(floor_date(x, unit = "months"), ymd(c("2009-08-01", NA), tz = "UTC"))
  expect_equal(round_date(x, unit = "minute"), ymd_hms(c("2009-08-03 12:02:00", NA), tz = "UTC"))
})


test_that("floor_date works for seasons", {
  dts <- ymd_hms(sprintf("2017-%d-02 0:34:3", 1:12))
  expect_equal(month(floor_date(dts, "season")), c(12, 12, 3, 3, 3, 6, 6, 6, 9, 9, 9, 12))
  dts <- force_tz(dts, "America/New_York")
  expect_equal(month(floor_date(dts, "season")), c(12, 12, 3, 3, 3, 6, 6, 6, 9, 9, 9, 12))
})

test_that("ceiling_date works for seasons", {
  dts <- ymd_hms(sprintf("2017-%d-02 0:34:3", 1:12))
  expect_equal(month(ceiling_date(dts, "season")), c(3, 3, 6, 6, 6, 9, 9, 9, 12, 12, 12, 3))
  dts <- force_tz(dts, "America/New_York")
  expect_equal(month(ceiling_date(dts, "season")), c(3, 3, 6, 6, 6, 9, 9, 9, 12, 12, 12, 3))
})


test_that("round on week respects week_start", {
  date <- ymd("2017-05-07") ## sunday
  ct <- as.POSIXct("2010-02-03 13:45:59", tz = "America/New_York", format = "%Y-%m-%d %H:%M:%S") ## Wednesday

  expect_equal(wday(floor_date(ct, "week", week_start = 1)), 2)
  expect_equal(wday(floor_date(ct, "week", week_start = 2)), 3)
  expect_equal(wday(floor_date(ct, "week", week_start = 5)), 6)
  expect_equal(wday(floor_date(ct, "week", week_start = 7)), 1)
  expect_equal(wday(floor_date(date, "week", week_start = 1)), 2)
  expect_equal(wday(floor_date(date, "week", week_start = 2)), 3)
  expect_equal(wday(floor_date(date, "week", week_start = 5)), 6)
  expect_equal(wday(floor_date(date, "week", week_start = 7)), 1)

  expect_equal(wday(floor_date(ct, "week", week_start = 1), week_start = 1), 1)
  expect_equal(wday(floor_date(ct, "week", week_start = 2), week_start = 2), 1)
  expect_equal(wday(floor_date(ct, "week", week_start = 5), week_start = 5), 1)
  expect_equal(wday(floor_date(ct, "week", week_start = 7), week_start = 7), 1)
  expect_equal(wday(floor_date(date, "week", week_start = 1), week_start = 1), 1)
  expect_equal(wday(floor_date(date, "week", week_start = 2), week_start = 2), 1)
  expect_equal(wday(floor_date(date, "week", week_start = 5), week_start = 5), 1)
  expect_equal(wday(floor_date(date, "week", week_start = 7), week_start = 7), 1)

  expect_equal(wday(ceiling_date(ct, "week", week_start = 1)), 2)
  expect_equal(wday(ceiling_date(ct, "week", week_start = 2)), 3)
  expect_equal(wday(ceiling_date(ct, "week", week_start = 5)), 6)
  expect_equal(wday(ceiling_date(ct, "week", week_start = 7)), 1)
  expect_equal(wday(ceiling_date(date, "week", week_start = 1)), 2)
  expect_equal(wday(ceiling_date(date, "week", week_start = 2)), 3)
  expect_equal(wday(ceiling_date(date, "week", week_start = 5)), 6)
  expect_equal(wday(ceiling_date(date, "week", week_start = 7)), 1)

  expect_equal(wday(ceiling_date(ct, "week", week_start = 1), week_start = 1), 1)
  expect_equal(wday(ceiling_date(ct, "week", week_start = 2), week_start = 2), 1)
  expect_equal(wday(ceiling_date(ct, "week", week_start = 5), week_start = 5), 1)
  expect_equal(wday(ceiling_date(ct, "week", week_start = 7), week_start = 7), 1)
  expect_equal(wday(ceiling_date(date, "week", week_start = 1), week_start = 1), 1)
  expect_equal(wday(ceiling_date(date, "week", week_start = 2), week_start = 2), 1)
  expect_equal(wday(ceiling_date(date, "week", week_start = 5), week_start = 5), 1)
  expect_equal(wday(ceiling_date(date, "week", week_start = 7), week_start = 7), 1)

  expect_equal(wday(round_date(ct, "week", week_start = 1)), 2)
  expect_equal(wday(round_date(ct, "week", week_start = 2)), 3)
  expect_equal(wday(round_date(ct, "week", week_start = 5)), 6)
  expect_equal(wday(round_date(ct, "week", week_start = 7)), 1)
  expect_equal(wday(round_date(date, "week", week_start = 1)), 2)
  expect_equal(wday(round_date(date, "week", week_start = 2)), 3)
  expect_equal(wday(round_date(date, "week", week_start = 5)), 6)
  expect_equal(wday(round_date(date, "week", week_start = 7)), 1)

  expect_equal(wday(round_date(ct, "week", week_start = 1), week_start = 1), 1)
  expect_equal(wday(round_date(ct, "week", week_start = 2), week_start = 2), 1)
  expect_equal(wday(round_date(ct, "week", week_start = 5), week_start = 5), 1)
  expect_equal(wday(round_date(ct, "week", week_start = 7), week_start = 7), 1)
  expect_equal(wday(round_date(date, "week", week_start = 1), week_start = 1), 1)
  expect_equal(wday(round_date(date, "week", week_start = 2), week_start = 2), 1)
  expect_equal(wday(round_date(date, "week", week_start = 5), week_start = 5), 1)
  expect_equal(wday(round_date(date, "week", week_start = 7), week_start = 7), 1)
})

test_that("rounding works when week_start = name of week day", {
  date <- ymd("2017-05-07") ## sunday
  ct <- as.POSIXct("2010-02-03 13:45:59", tz = "America/New_York", format = "%Y-%m-%d %H:%M:%S") ## Wednesday

  expect_identical(floor_date(ct, "week", week_start = "Monday"), floor_date(ct, "week", week_start = 1))
  expect_identical(floor_date(ct, "week", week_start = "Tuesday"), floor_date(ct, "week", week_start = 2))

  expect_identical(ceiling_date(ct, "week", week_start = "Monday"), ceiling_date(ct, "week", week_start = 1))
  expect_identical(ceiling_date(ct, "week", week_start = "Friday"), ceiling_date(ct, "week", week_start = 5))

  expect_identical(ceiling_date(ct, "week", week_start = "Mond"), ceiling_date(ct, "week", week_start = 1))
  expect_identical(ceiling_date(ct, "week", week_start = "Fri"), ceiling_date(ct, "week", week_start = 5))

  expect_identical(round_date(ct, "week", week_start = "Monday"), round_date(ct, "week", week_start = 1))
  expect_identical(round_date(ct, "week", week_start = "Sunday"), round_date(ct, "week", week_start = 7))
  expect_identical(round_date(ct, "week", week_start = "Mon"), round_date(ct, "week", week_start = 1))
  expect_identical(round_date(ct, "week", week_start = "Sund"), round_date(ct, "week", week_start = 7))
})


test_that("wday extract and update: week_start can be a week day", {

  d <- ymd("2017-01-02") # Monday
  p <- as_datetime(d)

  expect_identical(wday(d, week_start = "Tue"), 7)
  expect_identical(wday(p, week_start = "Tue"), 7)
  expect_identical(wday(d, week_start = "Monday"), 1)
  expect_identical(wday(p, week_start = "Monday"), 1)
  expect_identical(wday(2, week_start = "Monday"), 1)
  expect_identical(wday(2, week_start = "Monday"), wday(2, week_start = 1))

  wday(d) <- "Tue"
  expect_identical(wday(d), 3)

  # ignore week_start when value is a character
  wday(d, week_start = 1) <- "Tue"
  expect_identical(wday(d), 3)
  wday(p, week_start = 2) <- "Sunday"
  expect_identical(wday(p), 1)

  wday(p) <- "Wednesday"
  expect_identical(wday(p), 4)

  wday(d) <- 4
  expect_identical(wday(d), 4)
  wday(d, week_start = 2) <- 4
  expect_identical(wday(d, week_start = 2), 4)
  wday(p) <- 5
  expect_identical(wday(p), 5)

})
