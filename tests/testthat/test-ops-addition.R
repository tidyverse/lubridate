test_that("addition handles daylight savings time", {
  x <- as.POSIXct("2010-03-14 00:00:00", tz = "America/New_York")
  y <- as.POSIXct("2010-03-15 01:00:00", tz = "America/New_York")

  expect_equal(x + days(1), as.POSIXct(
    "2010-03-15 00:00:00",
    tz = "America/New_York"
  ))
  expect_equal(x + ddays(1), y)
})

test_that("subtraction handles daylight savings time", {
  x <- as.POSIXct("2010-03-15 00:00:00", tz = "America/New_York")
  y <- as.POSIXct("2010-03-13 23:00:00", tz = "America/New_York")

  expect_equal(x - days(1), as.POSIXct(
    "2010-03-14 00:00:00",
    tz = "America/New_York"
  ))
  expect_equal(x - ddays(1), y)
})

test_that("addition works as expected for instants", {
  x <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  y <- as.POSIXlt("2008-01-01 00:00:00", tz = "UTC")
  z <- as.Date("2008-01-01")

  expect_equal(x + years(1), as.POSIXct("2009-01-01 00:00:00", tz = "UTC"))
  expect_equal(y + years(1), as.POSIXlt("2009-01-01 00:00:00", tz = "UTC"))
  expect_equal(z + years(1), as.Date("2009-01-01"))

  expect_equal(x + dyears(1), as.POSIXct("2008-12-31 06:00:00", tz = "UTC"))
  expect_equal(y + dyears(1), as.POSIXlt("2008-12-31 06:00:00", tz = "UTC"))
  expect_equal(z + dyears(1), as.POSIXct("2008-12-31 06:00:00", tz = "UTC"))

  time1 <- as.POSIXct("2008-08-02 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- interval(time1, time2)
  num <- as.numeric(time2) - as.numeric(time1)

  expect_error(x + int)
  expect_error(y + int)
  expect_error(z + int)
})

test_that("addition with instants returns correct class", {
  x <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  y <- as.POSIXlt("2008-01-02 00:00:00", tz = "UTC")
  z <- as.Date("2008-01-01")

  expect_s3_class(x + years(1), "POSIXct")
  expect_s3_class(y + years(1), "POSIXlt")
  expect_s3_class(z + years(1), "Date")

  expect_s3_class(x + dyears(1), "POSIXct")
  expect_s3_class(y + dyears(1), "POSIXlt")
  expect_s3_class(z + dyears(1), "POSIXct")
})



test_that("addition works as expected for periods", {
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- interval(time1, time2)

  expect_equal(years(1) + 1, period(seconds = 1, years = 1))

  expect_equal(
    years(1) + as.POSIXct("2008-01-01 00:00:00", tz = "UTC"),
    as.POSIXct("2009-01-01 00:00:00", tz = "UTC")
  )

  expect_equal(
    years(1) + as.POSIXlt("2008-01-01 00:00:00", tz = "UTC"),
    as.POSIXlt("2009-01-01 00:00:00", tz = "UTC")
  )

  expect_equal(years(1) + minutes(3), period(
    minutes = 3,
    years = 1
  ))

  expect_error(years(1) + dyears(1))
  expect_error(years(1) + int)
})

test_that("addition with periods returns correct class", {
  expect_s4_class(years(1) + 1, "Period")

  expect_s3_class(years(1) + as.POSIXct(
    "2008-01-01 00:00:00",
    tz = "UTC"
  ), "POSIXt")

  expect_s3_class(years(1) + as.POSIXlt(
    "2008-01-01 00:00:00",
    tz = "UTC"
  ), "POSIXlt")

  expect_s4_class(years(1) + minutes(3), "Period")
})


test_that("addition works as expected for durations", {
  x <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  y <- as.POSIXct("2008-12-31 06:00:00", tz = "UTC")
  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- interval(time1, time2)

  expect_equal(dyears(1) + 1, duration(31557601))
  expect_equal(dyears(1) + x, y)
  expect_equal(dyears(1) + dyears(1), dyears(2))
  expect_error(dyears(1) + minutes(3))
  expect_error(dyears(1) + int)
})

test_that("addition with durations returns correct class", {
  ct <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  lt <- as.POSIXlt("2008-01-01 00:00:00", tz = "UTC")

  expect_s4_class(dyears(1) + 1, "Duration")
  expect_s3_class(dyears(1) + ct, "POSIXct")
  expect_s3_class(dyears(1) + lt, "POSIXlt")
  expect_s4_class(dyears(1) + dyears(1), "Duration")
})

test_that("addition works as expected for intervals", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  time3 <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  diff <- difftime(time2, time1)

  int <- interval(time1, time2)

  expect_error(int + time3)
  expect_error(int + time1)
  expect_error(int + 1)
  expect_error(int + minutes(3))
  expect_error(int + dyears(1))

  time5 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  int3 <- interval(time2, time5)

  expect_error(int + int3)
})


#### Vectors

test_that("adding vectors works as expected for instants", {
  x <- as.POSIXct(c("2008-01-01 00:00:00", "2009-01-01 00:00:00"), tz = "UTC")
  y <- as.POSIXlt(c("2008-01-01 00:00:00", "2009-01-01 00:00:00"), tz = "UTC")
  z <- c(as.Date("2008-01-01"), as.Date("2008-01-10"))

  expect_equal(x + years(1), ymd_hms(c("2009-01-01 00:00:00", "2010-01-01 00:00:00")))
  expect_equal(y + years(1), as.POSIXlt(c("2009-01-01 00:00:00", "2010-01-01 00:00:00"), tz = "UTC"))
  expect_equal(z + years(1), as.Date(c("2009-01-01", "2009-01-10")))

  expect_equal(x + dyears(1), ymd_hms(c("2008-12-31 06:00:00", "2010-01-01 06:00:00")))
  expect_equal(y + dyears(1), as.POSIXlt(c("2008-12-31 06:00:00", "2010-01-01 06:00:00"), tz = "UTC"))
  expect_equal(z + dyears(1), ymd_hms(c("2008-12-31 06:00:00", "2009-01-09 06:00:00")))

  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- interval(time1, time2)
  num <- as.numeric(time2) - as.numeric(time1)

  expect_error(x + int)
  expect_error(y + int)
  expect_error(z + int)
})

test_that("adding vectors works as expected for periods", {
  expect_equal(years(1:2) + 1, period(seconds = 1, years = c(1, 2)))

  expect_equal(
    years(1:2) + as.POSIXct("2008-01-01 00:00:00", tz = "UTC"),
    as.POSIXct(c("2009-01-01 00:00:00", "2010-01-01 00:00:00"), tz = "UTC")
  )

  expect_equal(years(1:2) + as.POSIXlt("2008-01-01 00:00:00",
    tz = "UTC"
  ), as.POSIXlt(c(
    "2009-01-01 00:00:00",
    "2010-01-01 00:00:00"
  ), tz = "UTC"))


  expect_equal(years(1:2) + minutes(3), period(
    minutes = 3, years = c(1, 2)
  ))

  expect_error(years(1:2) + dyears(1))

  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- interval(time1, time2)

  expect_error(years(1:2) + int)
})

test_that("adding vectors works as expected for durations", {
  w <- as.POSIXct("2007-01-01 00:00:00", tz = "UTC")
  x <- as.POSIXct("2008-01-01 00:00:00", tz = "UTC")
  y <- as.POSIXct(c("2008-01-01 00:00:00", "2008-12-31 00:00:00"), tz = "UTC")
  dur <- dminutes(1:2) + 1
  ddif <- ddays(c(.25, .5))
  expect_equal(dur@.Data, c(61, 121))
  expect_equal(dyears(1:2) + w - ddif, y)
  expect_equal(dyears(1:2) + as.POSIXlt(w) - ddif, as.POSIXlt(y))
  expect_error(dyears(1:2) + minutes(3))
  expect_equal(dyears(1:2) + dyears(1), dyears(2:3))

  time1 <- as.POSIXct("2008-01-02 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  int <- interval(time1, time2)
  expect_error(dyears(1:2) + int)
})

test_that("adding vectors works as expected for intervals", {
  time1 <- as.POSIXct("2008-08-03 00:00:00", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 00:00:00", tz = "UTC")
  time3 <- as.POSIXct("2010-08-03 00:00:00", tz = "UTC")
  int <- interval(c(time1, time2), time3)
  int2 <- interval(time1, time2)

  expect_error(int + time4)
  expect_error(int + 1)
  expect_error(int + minutes(3))
  expect_error(int + dyears(1))
  expect_error(int + int2)
})

test_that("%m+% correctly adds months without rollover", {
  jan <- ymd_hms("2010-01-31 03:04:05")
  ends <- ymd_hms(c("2010-02-28 03:04:05", "2010-03-31 03:04:05", "2010-04-30 03:04:05"))

  expect_equal(jan %m+% months(1:3), ends)
})

test_that("%m+% correctly adds years without rollover", {
  leap <- ymd("2012-02-29")
  next1 <- ymd("2013-02-28")
  next2 <- ymd("2013-03-29")
  expect_equal(leap %m+% years(1), next1)
  expect_equal(leap %m+% period(years = 1, months = 1), next2)
})

test_that("%m+% correctly adds years, months, days and HMS (#286)", {
  date <- ymd("2012-02-29")
  per_all <- period(years = 1, months = 1, days = 2, hours = 1, minutes = 20, seconds = 30)
  per_major <- period(years = 1, months = 1)
  per_minor <- period(days = 2, hours = 1, minutes = 20, seconds = 30)
  expect_equal(
    date %m+% per_all,
    date %m+% per_major + per_minor
  )

  date <- ymd("2012-03-31")
  per_all <- period(months = 3, days = 30, hours = 1, minutes = 20, seconds = 30)
  per_major <- period(months = 3)
  per_minor <- period(days = 30, hours = 1, minutes = 20, seconds = 30)
  expect_equal(
    date %m+% per_all,
    date %m+% per_major + per_minor
  )
})

test_that("add_with_rollback doesn't chock on DTS", {
  x <- ymd_hms(c("2019-03-29 02:03:00", "2019-03-29 02:11:00"), tz = "Europe/Paris")
  y <- ymd_hms(c("2020-03-29 03:00:00", "2020-03-29 03:00:00"), tz = "Europe/Paris")
  expect_equal(add_with_rollback(x, years(1)), y)
})

test_that("%m+% correctly adds negative months without rollover", {
  may <- ymd_hms("2010-05-31 03:04:05")
  ends <- ymd_hms(c("2010-04-30 03:04:05", "2010-03-31 03:04:05", "2010-02-28 03:04:05"))

  expect_equal(may %m+% -months(1:3), ends)
})

test_that("%m+% correctly adds negative years without rollover", {
  leap <- ymd("2012-02-29")
  next1 <- ymd("2011-02-28")
  next2 <- ymd("2011-01-29")
  next3 <- ymd("2011-03-29")

  expect_equal(leap %m+% years(-1), next1)
  expect_equal(leap %m+% period(years = -1, months = -1), next2)
  expect_equal(leap %m+% period(years = -1, months = 1), next3)
})


test_that("addition with period months and years returns NA when appropriate", {
  jan <- ymd("2013-01-31", tz = "America/Chicago")
  feb <- ymd("2013-02-28", tz = "America/Chicago")
  mar <- ymd("2013-03-28", tz = "America/Chicago")
  leap <- ymd("2012-02-29", tz = "America/Chicago")

  mos <- ymd(c(
    "2013-01-31", NA, "2013-03-31", NA,
    "2013-05-31", NA, "2013-07-31",
    "2013-08-31", NA, "2013-10-31", NA,
    "2013-12-31"
  ), tz = "America/Chicago")
  yrs <- ymd(c("2012-02-29", NA, NA, NA, "2016-02-29"), tz = "America/Chicago")

  mos2 <- ymd(c(
    "2013-01-31", "2012-12-31", NA,
    "2012-10-31", NA, "2012-08-31",
    "2012-07-31", NA, "2012-05-31", NA,
    "2012-03-31", NA
  ), tz = "America/Chicago")
  yrs2 <- ymd(c("2012-02-29", NA, NA, NA, "2008-02-29"), tz = "America/Chicago")

  expect_equal(jan + months(0:11), mos)
  expect_equal(feb + months(1), mar)
  expect_equal(leap + years(0:4), yrs)

  expect_equal(jan - months(0:11), mos2)
  expect_equal(mar - months(1), feb)
  expect_equal(leap - years(0:4), yrs2)

  # Again with Dates (#1069)
  jan <- as_date(jan)
  feb <- as_date(feb)
  mar <- as_date(mar)
  leap <- as_date(leap)
  mos <- as_date(mos)
  yrs <- as_date(yrs)
  mos2 <- as_date(mos2)
  yrs2 <- as_date(yrs2)

  expect_equal(jan + months(0:11), mos)
  expect_equal(feb + months(1), mar)
  expect_equal(leap + years(0:4), yrs)

  expect_equal(jan - months(0:11), mos2)
  expect_equal(mar - months(1), feb)
  expect_equal(leap - years(0:4), yrs2)
})

test_that("addition with period months recycles correctly", {
  x <- as_date(c("2019-01-01", "2019-01-02"))
  y <- as_datetime(x, tz = "UTC")

  period <- months(1)
  x_expect <- as_date(c("2019-02-01", "2019-02-02"))
  y_expect <- as_datetime(x_expect, tz = "UTC")
  expect_identical(x + period, x_expect)
  expect_identical(y + period, y_expect)

  period <- months(NA_integer_)
  x_expect <- as_date(c(NA, NA))
  y_expect <- as_datetime(x_expect, tz = "UTC")
  expect_identical(x + period, x_expect)
  expect_identical(y + period, y_expect)

  period <- months(integer())
  expect_error(x + period)
  expect_error(y + period)

  period <- months(1:3)
  expect_error(x + period)
  expect_error(y + period)

  period <- months(c(1, 2, NA))
  expect_error(x + period)
  expect_error(y + period)
})

test_that("adding multi unit periods produces NAs on intermediate computation", {
  expect_equal(ymd("2021-01-31") + period("1m1d"), NA_Date_)
  expect_equal(ymd("2020-02-29") + period("1y1d"), NA_Date_)
  expect_equal(ymd("2020-01-29") + period("1y1m1d"), NA_Date_)
  expect_equal(ymd("2021-01-31", tz = "UTC") + period("1m1d"), NA_POSIXct_)
  expect_equal(ymd("2020-02-29", tz = "UTC") + period("1y1d"), NA_POSIXct_)
  expect_equal(ymd("2020-01-29", tz = "UTC") + period("1y1m1d"), NA_POSIXct_)
})

test_that("addition with singleton NAs periods work", {
  days1 <- days(NA_real_)
  months1 <- months(NA_real_)
  years1 <- years(NA_real_)

  x <- as.Date("2019-01-01")
  y <- as.POSIXct("2019-01-01", "UTC")

  expect_equal(x + days1, as.Date(NA))
  expect_equal(y + days1, NA_POSIXct_)
  expect_equal(x + months1, as.Date(NA))
  expect_equal(y + months1, NA_POSIXct_)
  expect_equal(x + years1, as.Date(NA))
  expect_equal(y + years1, NA_POSIXct_)
})

test_that("addition with durations containing NA", {
  dt <- ymd(20161018)
  dt_1 <- ymd(20161019)

  dd_1na <- ddays(c(1, NA))
  dd_na1 <- ddays(c(NA, 1))
  dd_nana <- ddays(c(NA, NA))

  ans_1na <- add_duration_to_date(dd_1na, dt)
  ans_na1 <- add_duration_to_date(dd_na1, dt)
  ans_nana <- add_duration_to_date(dd_nana, dt)

  expect_s3_class(ans_1na, "Date")
  expect_s3_class(ans_na1, "Date")
  expect_s3_class(ans_nana, "Date")

  expect_equal(ans_1na, c(dt_1, NA))
  expect_equal(ans_na1, rev(c(dt_1, NA)))
  expect_equal(ans_nana, as.Date(c(NA, NA)))
})


test_that("addition works correctly for DST transitions", {
  ref <- ymd("2017-10-01", tz = "Australia/Melbourne")
  expect_equal(ref + hours(1:3), ref + dhours(c(1, NA, 2)))
  ref <- ymd_hms("2022-10-30 00:00:00", tz = "Europe/Amsterdam")
  expect_equal(ref + hours(1:3), ref + dhours(c(1, 2, 4)))
  ref <- ymd_hms("2022-03-27 00:00:00", tz = "Europe/Amsterdam")
  expect_equal(ref + hours(1:3), ref + dhours(c(1, NA, 2)))
})
