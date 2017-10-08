context("Timespans")

test_that("is.timespan works as expected", {
  expect_that(is.timespan(234), is_false())
  expect_that(is.timespan(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.timespan(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.timespan(Sys.Date()), is_false())
  expect_that(is.timespan(minutes(1)), is_true())
  expect_that(is.timespan(dminutes(1)), is_true())
  expect_that(is.timespan(interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"),
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC"))), is_true())
})

test_that("is.timespan handles vectors", {
  expect_that(is.timespan(minutes(1:3)), is_true())
})

test_that("time_length works as expected", {
  expect_that(time_length(period(1, "day")), # period
              equals(86400))
  expect_that(time_length(ymd("2014-12-15") - ymd("2014-11-30"), "day"), # difftime
              equals(15))
  expect_that(time_length(ymd("2014-12-15") - ymd("2014-11-30"), "week"),
              equals(15/7))
  expect_that(time_length(duration(3, "months"), "month"), # duration
              equals(3))
  expect_that(time_length(interval(ymd("2014-11-30"), ymd("2014-12-15")), "weeks"), # interval
              equals(15/7))
  expect_that(time_length(interval(ymd("1900-01-01"), ymd("1999-12-31")), "years"),
              is_less_than(100))
  expect_that(time_length(as.duration(interval(ymd("1900-01-01"), ymd("1999-12-31"))), "years"),
              is_more_than(100))
  expect_that(-time_length(interval(ymd("1900-01-01"), ymd("2000-01-01")), "days"),
              equals(time_length(int_flip(interval(ymd("1900-01-01"), ymd("2000-01-01"))), "days")))
})

test_that("time_length works with missing intervals", {
  expect_equal(time_length(interval(NA, ymd("2016-01-01")), unit = "year"), NA_real_)
})

test_that("time_length works with birth date 29 Feb ", {
  expect_that(round(time_length(interval(ymd("1992-02-29"), ymd("1999-02-28")), "years"), 4),
              equals(6.9973))
  expect_that(round(time_length(interval(ymd("1992-02-29"), ymd("1999-03-31")), "years"), 4),
              equals(7.0822))
  expect_that(time_length(interval(ymd("1992-02-29"), ymd("1999-03-01")), "years"),
              equals(7))
  expect_that(round(time_length(interval(ymd("1992-02-29"), ymd("2000-03-01")), "years"), 4),
              equals(8.0027))
  expect_that(time_length(interval(ymd("1992-02-29"), ymd("2000-02-29")), "years"),
              equals(8))
  expect_that(time_length(interval(ymd_hms("1992-02-29 12:00:00"), ymd_hms("1999-03-01 05:00:00")), "years"),
              is_more_than(7))
})

test_that("time_length works with negative interals", {
  expect_that(-time_length(interval(ymd("1992-02-28"), ymd("2000-01-01")), "days"),
              equals(time_length(int_flip(interval(ymd("1992-02-28"), ymd("2000-01-01"))), "days")))
  expect_that(-time_length(interval(ymd("1992-02-28"), ymd("2000-03-01")), "days"),
              equals(time_length(int_flip(interval(ymd("1992-02-28"), ymd("2000-03-01"))), "days")))

  ## If both ends include leap years Febs, the lenths are not identical
  int <- interval(ymd("1992-02-28"), ymd("2000-03-01"))
  expect_equal(-time_length(int, "years"), time_length(int_flip(int), "years"))

  ## or if both ends don't include leap years Febs, the lenths are identical
  int <- interval(ymd("1994-02-28"), ymd("2002-03-01"))
  expect_equal(-time_length(int, "years"), time_length(int_flip(int), "years"))

  ## ... otherwise not
  int <- interval(ymd("1992-02-28"), ymd("2002-01-01"))
  expect_gt(-time_length(int, "years"),  time_length(int_flip(int), "years"))
})

test_that("time_length handles vectors", {
  expect_that(time_length(days(1:3), unit = "days"),
              equals(1:3))
  expect_that(time_length(as.interval(days(1:3), start = today()), unit = "days"),
              equals(1:3))
  expect_that(time_length(as.interval(days(c(1:3, NA)), start = today()), unit = "days"),
              equals(c(1:3, NA)))

  ints <- new("Interval"
            , .Data = c(6363040, 1646253613, 159312603, -510371200, -381983229, 1369742727,
                  -190254638, -1118394043, -2091814107)
            , start = structure(c(64156663, 326788049, 462064351, 909110414, 778538359,
                  395846311, 1415640365, 1697694335, 2193040469),
                  class = c("POSIXct", "POSIXt"), tzone = "UTC")
            , tzone = "UTC")

  expect_equal(round(time_length(ints, "years"), 5),
               c(0.20122, 52.16674, 5.04903, -16.17281, -12.10439, 43.40412,
                 -6.03011, -35.44092, -66.28715))

  expect_equal(round(time_length(ints[ints > 0], "years"), 5),
               c(0.20122, 52.16674, 5.04903, 43.40412))

  expect_equal(round(time_length(ints[ints < 0], "years"), 5),
               c(-16.17281, -12.10439, -6.03011, -35.44092, -66.28715))

  expect_equal(round(time_length(ints, "month"), 5),
               c(2.4402, 625.99552, 60.57729, -194.06691, -145.2291, 520.81679,
                 -72.35552, -425.27918, -795.43557))

})

test_that("time_length handles 0 length intervals", {
  date <- ymd_hms("2014-12-30 20:35:13")
  int <- interval(c(date, date), c(date, date))
  expect_equal(time_length(int), c(0, 0))
  expect_equal(time_length(int, "years"), c(0, 0))
  expect_equal(time_length(int, "months"), c(0, 0))
})
