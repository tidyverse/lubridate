test_that("period() returns zero-length vector", {
  x <- period()
  expect_s4_class(x, "Period")
  expect_length(x, 0)
  expect_equal(format(x), character())
  expect_output(print(x), "<Period[0]>", fixed = TRUE)
})

test_that("period(0-len-vec, ...) returns zero-length period", {
  x <- period(character())
  expect_s4_class(x, "Period")
  expect_length(x, 0)

  x <- period(hour = numeric())
  expect_s4_class(x, "Period")
  expect_length(x, 0)

  x <- period(numeric(), hour = numeric())
  expect_s4_class(x, "Period")
  expect_length(x, 0)

  expect_equal(
    period(c(30, 20), units = c("secs", "days")),
    period(c(30, 20), units = c("secs", "days"), days = numeric())
  )

  expect_equal(
    period(numeric(), days = 10),
    period(days = 10)
  )

  expect_equal(
    period(days = 10, secs = 1, hours = numeric()),
    period()
  )

  expect_equal(
    period(days = 10, secs = numeric(), hours = 3),
    period()
  )
})

test_that("period constructor doesn't accept non-numeric or non-character inputs", {
  expect_error(period(interval(ymd("2014-01-01"), ymd("2015-01-01"))))
})

test_that("period constructor works with duplicated units", {
  expect_equal(
    period(c(1, 1, 2, 10), c("days", "sec", "seconds", "day")),
    period("11d 3s")
  )
  expect_equal(
    period(sec = 1, day = 1, seconds = 2, days = 10),
    period("11d 3s")
  )
  expect_equal(
    period(sec = c(1, 2), day = c(1, 2), seconds = 2, days = c(10, 20, 30, 40)),
    period(c("11d 3s", "22d 4s", "31d 3s", "42d 4s"))
  )
})

test_that("period parsing works", {
  expect_equal(
    period("1min 2sec 2secs 1H 2M 1d"),
    period(seconds = 4, minutes = 3, hours = 1, days = 1)
  )
  expect_equal(
    period("day day"),
    period(days = 2)
  )
  expect_equal(
    period("S M H d m y"),
    period(seconds = 1, minutes = 1, hours = 1, days = 1, months = 1, years = 1)
  )
  expect_equal(
    period("2S 3M 4H 5d 6w 7m 8y"),
    period(seconds = 2, minutes = 3, hours = 4, days = 5, weeks = 6, months = 7, years = 8)
  )
  expect_equal(period("K")@.Data, NA_real_)
  expect_equal(period("K")@hour, NA_real_)
  expect_equal(period("ksfdsfds")@.Data, NA_real_)
  expect_equal(period("ksfdsfds")@day, NA_real_)
})

test_that("ISO ISO 8601 period parsing works", {
  expect_equal(period("")@.Data, NA_real_)
  expect_equal(period("P")@.Data, NA_real_)
  expect_equal(
    period("P3Y6M4DT12H30M5S"),
    period(years = 3, months = 6, days = 4, hours = 12, minutes = 30, seconds = 5)
  )
  expect_equal(
    period("P23DT23H"),
    period(days = 23, hours = 23)
  )
  expect_equal(
    period("P23DT60H"),
    period(days = 23, hours = 60)
  )
  expect_equal(
    period("P23DT60H20minutes 100 sec"),
    period(days = 23, hours = 60, minutes = 20, seconds = 100)
  )
  expect_equal(
    period(c("P23DT23H", "PT0S", "P0D")),
    period(days = c(23, 0, 0), hours = c(23, 0, 0))
  )
})

test_that("fractional parsing works as expected", {
  expect_equal(
    period("1.1min 2.3sec 2.3secs 1.0H 2.2M 1.5d"),
    period(seconds = 43222.6, minutes = 3, hours = 1, days = 1)
  )
  expect_equal(
    period("day 1.2days"),
    period(days = 2, seconds = 17280)
  )
})

test_that("is.period works", {
  expect_false(is.period(234))
  expect_false(is.period(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")))
  expect_false(is.period(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")))
  expect_false(is.period(Sys.Date()))
  expect_true(is.period(minutes(1)))
  expect_false(is.period(dminutes(1)))
  expect_false(is.period(interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"),
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  )))
})

test_that("period works as expected", {
  per <- period(second = 90, minute = 5)

  expect_s4_class(per, "Period")
  expect_equal(period(hours = 25), hours(25))
  expect_equal(per@year, 0)
  expect_equal(per@month, 0)
  expect_equal(per@day, 0)
  expect_equal(per@hour, 0)
  expect_equal(per@minute, 5)
  expect_equal(per@.Data, 90)
})

test_that("period works as expected", {
  per <- period(c(90, 5), c("second", "minute"))

  expect_s4_class(per, "Period")
  expect_equal(period(hours = 25), hours(25))
  expect_equal(per@year, 0)
  expect_equal(per@month, 0)
  expect_equal(per@day, 0)
  expect_equal(per@hour, 0)
  expect_equal(per@minute, 5)
  expect_equal(per@.Data, 90)
})

test_that("period handles vector input", {
  per <- period(second = c(90, 60), minute = 5)

  expect_s4_class(per, "Period")
  expect_equal(length(per), 2)
  expect_equal(per@year, c(0, 0))
  expect_equal(per@month, c(0, 0))
  expect_equal(per@day, c(0, 0))
  expect_equal(per@hour, c(0, 0))
  expect_equal(per@minute, c(5, 5))
  expect_equal(per@.Data, c(90, 60))
})


test_that("period objects handle vector input", {
  x <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  expect_equal(
    as.numeric(x + minutes(c(1, 3, 4))),
    as.numeric(x + c(60, 180, 240))
  )
})

test_that("format.Period works as expected", {
  per <- period(second = 90, minute = 5)
  per2 <- period(days = 0)
  per3 <- period(years = 1, days = NA)
  expect_match(format(per), "5M 90S")
  expect_match(format(per2), "0S")
  expect_equal(format(per3), as.character(NA))
})

test_that("as.numeric and as.duration correctly handle periods", {
  tt <- period(24, "hours") + period(60, "minutes")
  expect_equal(as.numeric(tt, "hour"), 25)
  tt <- period(hours = 24, minutes = 6)
  expect_equal(as.numeric(tt, "hour"), 24.1)
  expect_equal(
    as.numeric(tt, "hour"),
    as.numeric(as.duration(tt), "hour")
  )
})

test_that("as.period handles interval objects", {
  start <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  end <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- interval(start, end)
  int_neg <- interval(end, start)

  expect_equal(as.period(int), years(1))
  expect_equal(as.period(int_neg), years(-1))
})

test_that("as.period handles intervals across years correctly", {
  ## https://github.com/tidyverse/lubridate/issues/371

  t1 <- ymd("1985-11-30")
  t2 <- ymd("1986-02-01")
  expect_equal(t2, t1 + as.period(interval(t1, t2)))

  ## negative
  t1 <- ymd("1986-02-01")
  t2 <- ymd("1985-11-30")
  expect_equal(t2, t1 + as.period(interval(t1, t2)))

  t1 <- "1985-11-01"
  t2 <- "2007-08-01"
  as.period(interval(t1, t2))
  ymd(t1) + as.period(interval(t1, t2, "UTC"))

  ## negative
  t1 <- "2007-08-01"
  t2 <- "1985-11-01"
  as.period(interval(t1, t2))
  ymd(t1) + as.period(interval(t1, t2, "UTC"))

  t1 <- ymd("1986-02-01")
  t2 <- ymd("1986-01-05")
  expect_equal(t2, t1 + as.period(interval(t1, t2)))
})

test_that("as.period handles vector interval objects", {
  ## https://github.com/tidyverse/lubridate/issues/349
  ints <- c(
    interval(ymd("2001-01-01"), ymd("2002-01-01")),
    interval(ymd("2001-01-01"), ymd("2004-01-01"))
  )
  expect_equal(as.period(ints), period(years = c(1, 3)))

  ints <- c(
    interval(ymd("2001-01-01"), ymd("2002-03-05")),
    interval(ymd("2001-01-01"), ymd_hms("2004-12-31 3:2:1"))
  )
  expect_equal(
    as.period(ints),
    period(
      years = c(1, 3), months = c(2, 11), days = c(4, 30),
      hours = c(0, 3), minutes = c(0, 2), seconds = c(0, 1)
    )
  )
})

test_that("as.period handles don't produce negative periods", {
  p2 <- as.period(interval(ymd("1985-12-31"), ymd("1986-02-01")))
  expect_equal(month(p2), 1)

  p3 <- as.period(interval(ymd("1985-12-31"), ymd("1986-03-01")))
  expect_equal(month(p3), 2)
  expect_equal(day(p3), 1)
})

test_that("as.period handles interval objects with special start dates", {
  start <- ymd("1992-02-29")
  end <- ymd("2010-12-05")
  int <- interval(start, end)

  expect_equal(as.period(int), period(c(18, 9, 6), c("year", "month", "day")))
  expect_equal(as.period(int) + start, end)
})


test_that("as.period with different units handles interval objects", {
  start <- ymd("1992-02-29")
  end <- ymd_hms("2010-12-05 01:02:03")
  int <- interval(start, end)

  expect_equal(
    as.period(int),
    period(c(18, 9, 6, 1, 2, 3), c("year", "month", "day", "hour", "minute", "second"))
  )
  expect_equal(as.period(int) + start, end)

  expect_equal(
    as.period(int, "months"),
    period(c(225, 6, 1, 2, 3), c("month", "day", "hour", "minute", "second"))
  )
  expect_equal(as.period(int, "months") + start, end)

  expect_equal(as.period(int, "hours"), period(c(164497, 2, 3), c("hour", "minute", "second")))
  expect_equal(as.period(int, "hours") + start, end)

  expect_equal(as.period(int, "minute"), period(c(9869822, 3), c("minute", "second")))
  expect_equal(as.period(int, "minute") + start, end)

  expect_equal(as.period(int, "second"), period(c(592189323), c("second")))
  expect_equal(as.period(int, "second") + start, end)
})

test_that("as.period on intervals with months unit recycles and standardizes the new 0 year (#1109)", {
  start <- ymd("2019-01-01") + c(0, NA, 2)
  end <- ymd("2023-01-02") + c(0, NA, 100)
  int <- interval(start, end, tzone = "UTC")

  x <- as.period(int, "months")

  expect_identical(x, months(c(48, NA, 51)) + days(c(1, NA, 9)))

  # In particular, the year slot should be recycled and have `NA`s standardized
  expect_identical(x@year, c(0, NA, 0))
  expect_identical(year(x), c(0, NA, 0))
})

test_that("as.period on periods with months unit recycles and standardizes the new 0 year (#1109)", {
  x <- years(c(1, NA, 2))
  x <- as.period(x, "months")

  expect_identical(x, months(c(12, NA, 24)))

  # In particular, the year slot should be recycled and have `NA`s standardized
  expect_identical(x@year, c(0, NA, 0))
  expect_identical(year(x), c(0, NA, 0))
})

test_that("period constructor works num-unit args", {
  expect_equal(period(1, c("sec", "hour")), period("1H 1S"))
  expect_equal(period(1:3, c("sec", "hour", "min")), period("2H 1S 3M"))
  expect_error(period(1:3, c("sec", "hour")), "Incompatible")
})

test_that("as.period with different units handles negative interval objects", {
  end <- ymd("1992-02-29", tz = "UTC")
  start <- ymd_hms("2010-12-05 01:02:03")
  int <- interval(start, end)

  expect_equal(
    as.period(int),
    period(-c(18, 9, 5, 1, 2, 3), c("year", "month", "day", "hour", "minute", "second"))
  )
  expect_equal(as.period(int) + start, end)

  expect_equal(
    as.period(int, "months"),
    period(-c(225, 5, 1, 2, 3), c("month", "day", "hour", "minute", "second"))
  )
  expect_equal(as.period(int, "months") + start, end)

  expect_equal(as.period(int, "hours"), period(-c(164497, 2, 3), c("hour", "minute", "second")))
  expect_equal(as.period(int, "hours") + start, end)

  expect_equal(as.period(int, "minute"), period(-c(9869822, 3), c("minute", "second")))
  expect_equal(as.period(int, "minute") + start, end)

  expect_equal(as.period(int, "second"), period(-c(592189323), c("second")))
  expect_equal(as.period(int, "second") + start, end)
})

test_that("as.period handles tricky intervals", {
  expect_equal(
    as.period(interval(ymd("1986-01-31"), ymd("1986-02-01"))),
    period(days = 1)
  )

  expect_equal(
    as.period(interval(ymd("1984-01-30"), ymd("1986-02-01"))),
    period(years = 2, days = 2)
  )

  expect_equal(
    as.period(interval(ymd("1984-01-30"), ymd("1986-03-01"))),
    period(years = 2, months = 1, days = 1)
  )

  expect_equal(
    as.period(interval(ymd("1985-01-30"), ymd("1986-03-30"))),
    period(years = 1, months = 2)
  )

  expect_equal(
    as.period(interval(ymd("1985-01-28"), ymd("1986-03-28"))),
    period(years = 1, months = 2)
  )

  expect_equal(
    as.period(interval(ymd("1985-01-31"), ymd("1986-03-28"))),
    period(years = 1, months = 1, days = 28)
  )

  expect_equal(
    as.period(interval(ymd("1984-01-28"), ymd("1984-02-28"))),
    period(months = 1)
  )

  expect_equal(
    as.period(interval(ymd("1984-01-28"), ymd("1984-02-29"))),
    period(months = 1, days = 1)
  )

  expect_equal(
    as.period(interval(ymd_hms("1984-01-28 5:0:0"), ymd_hms("1984-02-29 3:0:0"))),
    period(months = 1, hours = 22)
  )

  expect_equal(
    as.period(interval(ymd("1984-01-28"), ymd("1984-03-01"))),
    period(months = 1, days = 2)
  )

  expect_equal(
    as.period(interval(ymd_hms("1984-01-28 5:0:0"), ymd_hms("1984-03-01 3:0:0"))),
    period(months = 1, days = 1, hours = 22)
  )
})



test_that("as.period handles tricky negative intervals", {
  expect_equal(
    as.period(interval(ymd("1986-02-01"), ymd("1986-01-31"))),
    period(days = -1)
  )

  expect_equal(
    as.period(interval(ymd("1986-02-01"), ymd("1984-01-30"))),
    period(years = -2, days = -2)
  )

  expect_equal(
    as.period(interval(ymd("1986-03-01"), ymd("1984-01-30"))),
    period(years = -2, months = -1, days = -2)
  )

  expect_equal(
    as.period(interval(ymd("1986-03-30"), ymd("1985-01-30"))),
    period(years = -1, months = -2)
  )

  expect_equal(
    as.period(interval(ymd("1986-03-28"), ymd("1985-01-28"))),
    period(years = -1, months = -2)
  )

  expect_equal(
    as.period(interval(ymd("1986-03-28"), ymd("1985-01-31"))),
    period(years = -1, months = -1, days = -28)
  )

  expect_equal(
    as.period(interval(ymd("1986-02-01"), ymd("1985-12-31"))),
    period(months = -1, days = -1)
  )

  expect_equal(
    as.period(interval(ymd("1984-03-01"), ymd("1984-01-31"))),
    period(months = -1, days = -1)
  )

  expect_equal(
    as.period(interval(ymd("1984-03-01"), ymd("1984-01-30"))),
    period(months = -1, days = -2)
  )

  expect_equal(
    as.period(interval(ymd("1984-03-01"), ymd("1984-01-29"))),
    period(months = -1, days = -3)
  )

  expect_equal(
    as.period(interval(ymd_hms("1984-03-01 3:0:0"), ymd_hms("1984-01-28 5:0:0"))),
    period(months = -1, days = -3, hours = -22)
  )
})

test_that("as.period handles NA in interval objects", {
  one_missing_date <- as.POSIXct(NA_real_, origin = origin)
  one_missing_interval <- interval(
    one_missing_date,
    one_missing_date
  )
  several_missing_dates <- rep(as.POSIXct(NA_real_, origin = origin), 2)
  several_missing_intervals <- interval(
    several_missing_dates,
    several_missing_dates
  )
  start_missing_intervals <- interval(several_missing_dates, origin)
  end_missing_intervals <- interval(origin, several_missing_dates)
  na.per <- period(
    sec = NA, min = NA, hour = NA, day = NA,
    month = NA, year = NA
  )

  expect_equal(as.period(one_missing_interval, "year"), na.per)
  expect_equal(as.period(several_missing_intervals, "year"), c(na.per, na.per))
  expect_equal(as.period(start_missing_intervals, "year"), c(na.per, na.per))
  expect_equal(as.period(end_missing_intervals, "year"), c(na.per, na.per))
})

test_that("as.period handles NA duration objects", {
  na.per <- period(
    sec = NA, min = NA, hour = NA, day = NA,
    month = NA, year = NA
  )

  expect_equal(suppressMessages(as.period(dyears(NA))), na.per)
  expect_equal(suppressMessages(as.period(dyears(c(NA, NA)))), c(na.per, na.per))
  expect_equal(suppressMessages(as.period(dyears(c(1, NA)))), c(years(1), na.per))
})

test_that("as.period handles NA objects", {
  na.per <- seconds(NA)
  expect_equal(as.period(NA), na.per)
})

test_that("as.period handles vectors", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 13:01:59", tz = "UTC")
  int <- interval(c(time2, time1), time3)

  dur <- duration(seconds = 5, minutes = c(30, 59))

  expect_equal(as.period(int), years(1:2))
  expect_equal(as.period(dur), seconds(5) +
    minutes(c(30, 59)))
})

test_that("as.period handles duration objects", {
  dur <- duration(seconds = 5, minutes = 30)
  expect_equal(as.period(dur), seconds(5) + minutes(30))
})

test_that("as.period handles period objects", {
  per <- minutes(1000) + seconds(50) + seconds(11)
  expect_equal(as.period(per), per)
  expect_equal(as.period(per, "minute"), period(c(1001, 1), c("minute", "second")))
  expect_equal(as.period(per, "hour"), period(c(16, 41, 1), c("hour", "minute", "second")))
})

test_that("[<- can subset periods with new periods", {
  Time <- data.frame(Time = c(hms("01:01:01"), hms("02:02:02")))
  Time[1, 1] <- Time[1, 1] + hours(1)

  times <- days(1:3)
  times[1] <- times[1] + hours(2)

  expect_equal(Time[1, 1], hms("02:01:01"))
  expect_equal(times[1], period(days = 1, hours = 2))
})

test_that("period correctly handles week units", {
  expect_equal(period(1, "week"), days(7))
  expect_equal(period(8, "days"), days(8))
  expect_equal(period(c(3, 2), c("days", "week")), days(c(17)))
})

test_that("format.period correctly displays negative units", {
  expect_match(format(days(-2)), "-2d 0H 0M 0S")
  expect_match(format(period(second = -1, hour = -2, day = 3)), "3d -2H 0M -1S")
})

test_that("c.Period correctly handles NAs", {
  per <- period(seconds = 5)
  expect_true(is.na(c(per, NA)[2]))
})

test_that("NA components propagate to all components of a period", {
  p <- period(secs = c(1, 2, 3), days = c(1, 2, NA), months = c(1, NA, 3))
  expect_equal(
    p,
    new("Period",
      .Data = c(1, NA, NA), year = c(0, NA, NA),
      month = c(1, NA, NA), day = c(1, NA, NA),
      hour = c(0, NA, NA), minute = c(0, NA, NA)
    )
  )
})

test_that("c.Period doesn't fail with empty elements", {
  expect_equal(
    c(period(), period(3), NULL, logical(), period(1, "days")),
    c(period(3), period(days = 1))
  )
})

test_that("as.integer works with periods", {
  p <- period("2d 0H 2M 1s")
  expect_equal(as.integer(p, units = "minute"), as.integer(as.numeric(p, units = "minute")))
  expect_equal(as.integer(p, units = "hour"), as.integer(as.numeric(p, units = "hour")))
  expect_equal(as.integer(p), as.numeric(p))
  expect_type(as.integer(p), "integer")
})

test_that("c.Period works with named elements", {
  nmd <- c(a = hours(1), b = minutes(30))
  umd <- c(hours(1), minutes(30))
  names(umd) <- c("a", "b")
  expect_equal(nmd, umd)

  nmd <- c(a = hours(c(1, 1)), b = minutes(c(30, 31)))
  umd <- c(hours(1), hours(1), minutes(30), minutes(31))
  names(umd) <- c("a1", "a2", "b1", "b2")
  expect_equal(nmd, umd)

  ## empty elements
  nmd <- c(a = hours(1), NULL, b = minutes(30), seconds(10))
  umd <- c(hours(1), minutes(30), seconds(10))
  names(umd) <- c("a", "b", "")
  expect_equal(nmd, umd)
})

test_that("summary.Period creates useful summary", {
  per <- period(minutes = 5)
  text <- c(rep("5M 0S", 6), 1)
  names(text) <- c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max.", "NA's")

  expect_equal(summary(c(per, NA)), text)
})



test_that("idempotentcy between period_to_seconds and seconds_to_period holds", {
  period <- period(years = 2, months = 3, days = 4, hour = 5, minutes = 6, seconds = 7)
  seconds <- 71319967
  expect_equal(period_to_seconds(seconds_to_period(seconds)), seconds)
})


test_that("direct reation of periods works as expected", {
  expect_equal(
    new("Period", 1:4),
    period(seconds = 1:4)
  )

  expect_equal(
    new("Period", 1:4, day = 1:2),
    period(seconds = 1:4, days = 1:2)
  )
})


test_that("period arithmetic works with infinite times", {
  #1113
  skip("FIXME: activate when timechange#29 isfixed")
  date <- ymd("2023-01-01")
  expect_equal(date + Inf, date + days(Inf))
  expect_equal(date + Inf, date + days(Inf))

  ime <- ymd("2023-01-01", tz = "America/New_York")
  expect_equal(date + Inf, date + days(Inf))
  expect_equal(date + Inf, date + days(Inf))
})
