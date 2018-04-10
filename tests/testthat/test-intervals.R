context("Intervals")

test_that("is.interval works as expected", {
  expect_that(is.interval(234), is_false())
  expect_that(is.interval(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.interval(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.interval(Sys.Date()), is_false())
  expect_that(is.interval(minutes(1)), is_false())
  expect_that(is.interval(dminutes(1)), is_false())
  expect_that(is.interval(interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"),
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC"))), is_true())
})

test_that("Parsing of iso 8601 intervals works", {
  expect_equal(interval("2007-03-01T13:00:00Z/2008-05-11T15:30:00Z"),
               interval("2007-03-01T13:00:00Z", "2008-05-11T15:30:00Z"))
  expect_equal(interval("2007-03-01T13:00:00Z/P1Y2M10DT2H30M"),
               interval("2007-03-01T13:00:00Z",
                        ymd_hms("2007-03-01T13:00:00Z") + period("P1Y2M10DT2H30M")))

  expect_equal(interval("P1Y2M10DT2H30M/2008-05-11T15:30:00Z"),
               interval(ymd_hms("2008-05-11T15:30:00Z") - period("P1Y2M10DT2H30M"),
                        "2008-05-11T15:30:00Z"))

  expect_equal(interval(c("P1Y2M10DT2H30M/2008-05-11T15:30:00Z",
                          "P2H30M/2008-05-11T15:30:00Z")),
               interval(ymd_hms("2008-05-11T15:30:00Z") - period(c("P1Y2M10DT2H30M", "P2H30M")),
                        "2008-05-11T15:30:00Z"))

  expect_equal(interval(c("P1Y2M10DT2H30M/2008-05-11T15:30:00Z",
                          "2001-05-11T15:30:00Z/P2H30M")),
               interval(c(ymd_hms("2008-05-11T15:30:00Z") - period("P1Y2M10DT2H30M"),
                          ymd_hms("2001-05-11T15:30:00Z")),
                        c(ymd_hms("2008-05-11T15:30:00Z"),
                          ymd_hms("2001-05-11T15:30:00Z") + period("P2H30M"))))

})

test_that("is.interval handles vectors", {
  expect_that(is.interval(interval(
    as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 13:01:59"), tz = "UTC"),
    as.POSIXct("2010-08-03 13:01:59", tz = "UTC"))), is_true())
})


test_that("interval works as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- interval(time1, time2)
  num <- as.numeric(time2) - as.numeric(time1)

  expect_equal(int@.Data, num)
  expect_equal(int@start, time1)
  expect_is(int, "Interval")

})

test_that("interval handles vector input", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  time3 <- as.POSIXct("2009-08-04 13:01:59", tz = "UTC")
  int <- interval(c(time1, time2), time3)
  num <- as.numeric(time3) -  as.numeric(c(time1, time2))

  expect_equal(int@.Data, num)
  expect_equal(int@start, c(time1, time2))
  expect_is(int, "Interval")

  int2 <- interval(time1, c(time3, time2))
  num2 <- as.numeric(c(time3, time2)) - as.numeric(time1)
  starts <- structure(c(time1, time1), "tzone" = "UTC")

  expect_equal(int2@.Data, num2)
  expect_equal(int2@start, starts)
  expect_is(int2, "Interval")
})


test_that("format.Interval works as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
  int <- interval(time1, time2)

  expect_match(format(int), "2008-08-03 13:01:59 UTC--2009-08-03 13:01:59 UTC")
})

test_that("interval handles character inputs", {
  t1 <- c("2007-01-01")
  t2 <- c("2007-08-01")
  expect_equal(interval(t1, t2),
               new("Interval", 18316800,
                   start = as.POSIXct("2007-01-01", tz = "UTC"),
                   tzone = "UTC"))

  t1 <- c("2007-01-01")
  t2 <- c("2007-08-01 00:01:02")
  expect_equal(interval(t1, t2),
               new("Interval", 18316862,
                   start = as.POSIXct("2007-01-01", tz = "UTC"),
                   tzone = "UTC"))
})


test_that("interval handles POSIXlt inputs", {
  skip_on_cran()

  oldtz <- Sys.getenv("TZ")
  Sys.setenv(TZ = "America/Los_Angeles")
  on.exit(if (oldtz == "") Sys.unsetenv("TZ") else Sys.setenv(TZ = oldtz))

  t1 <- as.POSIXlt("2007-01-01")
  t2 <- as.POSIXlt("2007-08-01")

  expect_equal(unclass(interval(t1, t2)),
               unclass(new("Interval", 18313200,
                           start = as.POSIXct("2007-01-01"),
                           tzone = "America/Los_Angeles")))

  t1 <- as.POSIXlt("2007-01-01")
  t2 <- as.POSIXlt("2007-08-01 00:01:02")

  expect_equal(unclass(interval(t1, t2)),
               unclass(new("Interval", 18313262,
                           start = as.POSIXct("2007-01-01"),
                           tzone = "America/Los_Angeles")))

})

test_that("as.interval works as expected", {
  a <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  pint <- interval(a, a + days(1))
  dint <- interval(a, a + ddays(1))

  expect_equal(pint, as.interval(days(1), a))
  expect_equal(dint, as.interval(ddays(1), a))
})

test_that("as.interval handles vector input", {
    a <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
    b <- as.POSIXct("2009-08-03 13:01:59", tz = "UTC")
    pint <- interval(a, a + days(1:2))
    dint <- interval(a, a + ddays(1:2))
    pint1 <- interval(c(a, b), c(a, b) + days(1:2))
    dint1 <- interval(c(a, b), c(a, b) + ddays(1:2))
    pint2 <- interval(c(a, b), c(a, b) + days(1))
    dint2 <- interval(c(a, b), c(a, b) + ddays(1))

  expect_equal(pint, as.interval(days(1:2), a))
  expect_equal(dint, as.interval(ddays(1:2), a))
  expect_equal(pint1, as.interval(days(1:2), c(a, b)))
  expect_equal(dint1, as.interval(days(1:2), c(a, b)))
  expect_equal(pint2, as.interval(days(1), c(a, b)))
  expect_equal(dint2, as.interval(days(1), c(a, b)))

})

test_that("[<- can subset intervals", {
  ints <- data.frame(spans = c(interval(ymd(20090201), ymd(20090101)),
                               interval(ymd(20090201), ymd(20090101))))
  my_int <- interval(ymd(18800101), ymd(18810101))
  ints[1, 1] <- 31536000
  ints[2, 1] <- my_int
  int2 <- interval(ymd(20090201), ymd(20100201))

  expect_equal(ints[1, 1], int2)
  expect_equal(ints[2, 1], my_int)

})

test_that("format.Interval correctly displays intervals of length 0", {
  int <- interval(ymd(18800101), ymd(18810101))
  expect_output(print(int[FALSE]), "Interval\\(0)")
})

test_that("interval handles correctly time zones of Date objects", {
  expect_equal(interval(as.Date("2011-01-01"), as.Date("2013-01-01")),
               interval(ymd("2011-01-01"), ymd("2013-01-01")))
})

test_that("summary.Interval creates useful summary", {
  int <- interval(ymd(20090201), ymd(20090101))
  text <- c(3, "2009-01-01", "2009-02-01", "UTC", 1)
  names(text) <- c("Intervals", "Earliest endpoint", "Latest endpoint", "Time zone", "NA's")

  expect_equal(summary(c(int, int, int, as.interval(NA))), text)
})

test_that("as.interval handles NAs", {
  expect_equal(as.interval(NA), interval(NA, NA))
})

test_that("c.interval works as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 15:03:39", tz = "UTC")
  int <- interval(time1, time2)
  ints <- interval(c(time1, time1), c(time2, time2))
  nants <- interval(c(time1, NA), c(time2, NA))

  expect_equal(c(int, int), ints)
  expect_equal(c(int, NA), nants)
})

test_that("%--% works as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 15:03:39", tz = "UTC")
  int <- interval(time1, time2)
  attempt <- time1 %--% time2

  expect_equal(attempt, int)
})

test_that("int_start and int_end work as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- as.POSIXct("2009-08-03 15:03:39", tz = "UTC")
  int1 <- interval(time1, time2)
  int2 <- interval(time2, time1)

  expect_equal(int_start(int1), time1)
  expect_equal(int_start(int2), time2)
  expect_equal(int_start(c(int1, int2)), c(time1, time2))

  expect_equal(int_end(int1), time2)
  expect_equal(int_end(int2), time1)
  expect_equal(int_end(c(int2, int1)), c(time1, time2))
})

test_that("int_length works as expected", {
  time1 <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  time2 <- time1 + 1111
  time3 <- time1 - 5555
  int <- interval(time1, time2)
  int2 <- interval(time1, time3)

  expect_equal(int_length(int), 1111)
  expect_equal(int_length(int2), -5555)
  expect_equal(int_length(c(int, int2)), c(1111, -5555))
})

test_that("int_shift works as expected", {
  time1 <- as.POSIXct("2001-01-01", tz = "UTC")
  time2 <- as.POSIXct("2002-01-01", tz = "UTC")
  int <- interval(time1, time2)
  int2 <- interval(time2, time1)

  dur <- duration(seconds = 11*24*60*60)
  dur2 <- duration(seconds = -3600)

  dint <- interval(time1 + 11*24*60*60, time2 + 11*24*60*60)
  dint2 <- interval(time2 + 11*24*60*60, time1 + 11*24*60*60)

  nint <- interval(time1 - 3600, time2 - 3600)
  nint2 <- interval(time2 - 3600, time1 - 3600)


  expect_equal(int_shift(int, dur), dint)
  expect_equal(int_shift(int, dur2), nint)
  expect_equal(int_shift(int, c(dur, dur2)), c(dint, nint))
  expect_equal(int_shift(int2, dur), dint2)
  expect_equal(int_shift(int2, dur2), nint2)
  expect_equal(int_shift(int2, c(dur, dur2)), c(dint2, nint2))
  expect_equal(int_shift(c(int, int2), dur), c(dint, dint2))
  expect_equal(int_shift(c(int, int2), dur2), c(nint, nint2))
  expect_equal(int_shift(c(int, int2), c(dur, dur2)), c(dint, nint2))
  expect_equal(int_shift(c(int, int2), c(dur2, dur)), c(nint, dint2))
})

test_that("int_overlaps works as expected", {
  time1 <- as.POSIXct("2001-01-01", tz = "UTC")
  time2 <- as.POSIXct("2002-01-01", tz = "UTC")
  time21 <- as.POSIXct("2001-06-01", tz = "UTC")
  time22 <- as.POSIXct("2002-06-01", tz = "UTC")
  time31 <- as.POSIXct("2003-01-01", tz = "UTC")
  time32 <- as.POSIXct("2004-01-01", tz = "UTC")
  int1 <- interval(time1, time2)
  int2 <- interval(time21, time22)
  int3 <- interval(time31, time32)

  nint1 <- interval(time2, time1)
  nint2 <- interval(time22, time21)
  nint3 <- interval(time32, time31)


  expect_true(int_overlaps(int1, int2))
  expect_false(int_overlaps(int1, int3))
  expect_equal(int_overlaps(int1, c(int2, int3)), c(TRUE, FALSE))
  expect_equal(int_overlaps(c(int1, int3), int2), c(TRUE, FALSE))

  expect_true(int_overlaps(nint1, nint2))
  expect_false(int_overlaps(nint1, nint3))
  expect_equal(int_overlaps(nint1, c(nint2, nint3)), c(TRUE, FALSE))
  expect_equal(int_overlaps(c(nint1, nint3), nint2), c(TRUE, FALSE))

  expect_true(int_overlaps(int1, nint2))
  expect_true(int_overlaps(nint1, int2))
  expect_false(int_overlaps(int1, nint3))
  expect_false(int_overlaps(nint1, int3))
  expect_equal(int_overlaps(int1, c(int2, nint3)), c(TRUE, FALSE))
  expect_equal(int_overlaps(c(int1, nint3), nint2), c(TRUE, FALSE))

})

test_that("int_aligns works as expected", {
  time1 <- as.POSIXct("2001-01-01", tz = "UTC")
  time2 <- as.POSIXct("2002-01-01", tz = "UTC")
  time21 <- as.POSIXct("2001-06-01", tz = "UTC")
  time22 <- as.POSIXct("2002-01-01", tz = "UTC")
  time31 <- as.POSIXct("2003-01-01", tz = "UTC")
  time32 <- as.POSIXct("2004-01-01", tz = "UTC")
  int1 <- interval(time1, time2)
  int2 <- interval(time21, time22)
  int3 <- interval(time31, time32)

  nint1 <- interval(time2, time1)
  nint2 <- interval(time22, time21)
  nint3 <- interval(time32, time31)

  expect_true(int_aligns(int1, int2))
  expect_false(int_aligns(int1, int3))
  expect_equal(int_aligns(int1, c(int2, int3)), c(TRUE, FALSE))
  expect_equal(int_aligns(c(int1, int3), int2), c(TRUE, FALSE))

  expect_true(int_aligns(nint1, nint2))
  expect_false(int_aligns(nint1, nint3))
  expect_equal(int_aligns(nint1, c(nint2, nint3)), c(TRUE, FALSE))
  expect_equal(int_aligns(c(nint1, nint3), nint2), c(TRUE, FALSE))

  expect_true(int_aligns(int1, nint2))
  expect_true(int_aligns(nint1, int2))
  expect_false(int_aligns(int1, nint3))
  expect_false(int_aligns(nint1, int3))
  expect_equal(int_aligns(int1, c(int2, nint3)), c(TRUE, FALSE))
  expect_equal(int_aligns(c(int1, nint3), nint2), c(TRUE, FALSE))
})

test_that("int_diff works as expected", {
  time1 <- as.POSIXct("2001-01-01", tz = "UTC")
  time2 <- as.POSIXct("2002-01-01", tz = "UTC")
  time3 <- as.POSIXct("2003-06-01", tz = "UTC")
  time4 <- as.POSIXct("2002-01-01", tz = "UTC")
  time5 <- as.POSIXct("2003-01-01", tz = "UTC")
  time6 <- as.POSIXct("2004-01-01", tz = "UTC")
  times <- c(time1, time2, time3, time4, time5, time6)
  int1 <- interval(time1, time2)
  int2 <- interval(time2, time3)
  int3 <- interval(time3, time4)
  int4 <- interval(time4, time5)
  int5 <- interval(time5, time6)
  ints <- c(int1, int2, int3, int4, int5)

  expect_equal(int_diff(times), ints)
})

test_that("int_standardize works as expected", {
   int <- interval(ymd(20100101), ymd(20090101))
   standard <- interval(ymd(20090101), ymd(20100101))
   ints <- c(int, int)
   ints2 <- c(int, standard)
   standards <- c(standard, standard)

   expect_equal(int_standardize(int), standard)
   expect_equal(int_standardize(standard), standard)
   expect_equal(int_standardize(ints), standards)
   expect_equal(int_standardize(ints2), standards)
   expect_equal(int_standardize(standards), standards)
})

test_that("int_flip works as expected", {
  int <- interval(ymd(20100101), ymd(20090101))
  flip <- interval(ymd(20090101), ymd(20100101))
  ints <- c(int, int)
  ints2 <- c(int, flip)
  flips <- c(flip, flip)
  flips2 <- c(flip, int)

  expect_equal(int_flip(int), flip)
  expect_equal(int_flip(ints), flips)
  expect_equal(int_flip(ints2), flips2)
  expect_equal(int_flip(flip), int)
  expect_equal(int_flip(flips), ints)
  expect_equal(int_flip(flips2), ints2)
})

test_that("intersect.Interval works as expected", {
  time1 <- as.POSIXct("2001-01-01", tz = "UTC")
  time2 <- as.POSIXct("2002-01-01", tz = "UTC")
  time21 <- as.POSIXct("2001-06-01", tz = "UTC")
  time22 <- as.POSIXct("2002-06-01", tz = "UTC")
  time31 <- as.POSIXct("2003-01-01", tz = "UTC")
  time32 <- as.POSIXct("2004-01-01", tz = "UTC")
  int1 <- interval(time1, time2)
  int2 <- interval(time21, time22)
  int3 <- interval(time31, time32)

  nint1 <- interval(time2, time1)
  nint2 <- interval(time22, time21)
  nint3 <- interval(time32, time31)

  expect_equal(intersect(int1, int2), interval(time21, time2))
  expect_equal(intersect(int1, int3), interval(NA, NA, tz = "UTC"))
  expect_equal(intersect(int1, c(int2, int3)), interval(c(time21, NA), c(time2, NA)))
  expect_equal(intersect(c(int1, int3), int2), interval(c(time21, NA), c(time2, NA)))
  expect_equal(intersect(c(int1, int3), c(int2, int2)), interval(c(time21, NA), c(time2, NA)))

  expect_equal(intersect(nint1, nint2), interval(time2, time21))
  expect_equal(intersect(nint1, nint3), interval(NA, NA, tz = "UTC"))
  expect_equal(intersect(nint1, c(nint2, nint3)), interval(c(time2, NA), c(time21, NA)))
  expect_equal(intersect(c(nint1, nint3), nint2), interval(c(time2, NA), c(time21, NA)))
  expect_equal(intersect(c(nint1, nint3), c(nint2, nint2)), interval(c(time2, NA), c(time21, NA)))

  expect_equal(intersect(int1, nint2), interval(time21, time2))
  expect_equal(intersect(nint1, nint2), interval(time2, time21))
  expect_equal(intersect(int1, nint3), interval(NA, NA, tz = "UTC"))
  expect_equal(intersect(nint1, int3), interval(NA, NA, tz = "UTC"))
  expect_equal(intersect(int1, c(nint2, int3)), interval(c(time21, NA), c(time2, NA)))
  expect_equal(intersect(nint1, c(int2, int3)), interval(c(time2, NA), c(time21, NA)))
  expect_equal(intersect(c(int1, nint3), nint2), interval(c(time21, NA), c(time2, NA)))
  expect_equal(intersect(c(nint1, int3), nint2), interval(c(time2, NA), c(time21, NA)))
  expect_equal(intersect(c(int1, nint3), int2), interval(c(time21, NA), c(time2, NA)))
  expect_equal(intersect(c(nint1, int3), int2), interval(c(time2, NA), c(time21, NA)))
  expect_equal(intersect(c(int1, nint3), c(nint2, int2)), interval(c(time21, NA), c(time2, NA)))
  expect_equal(intersect(c(nint1, int3), c(int2, nint2)), interval(c(time2, NA), c(time21, NA)))
})

test_that("union.Interval works as expected", {
  time1 <- as.POSIXct("2001-01-01", tz = "UTC")
  time2 <- as.POSIXct("2002-01-01", tz = "UTC")
  time21 <- as.POSIXct("2001-06-01", tz = "UTC")
  time22 <- as.POSIXct("2002-06-01", tz = "UTC")
  time31 <- as.POSIXct("2003-01-01", tz = "UTC")
  time32 <- as.POSIXct("2004-01-01", tz = "UTC")
  int1 <- interval(time1, time2)
  int2 <- interval(time21, time22)
  int3 <- interval(time31, time32)

  nint1 <- interval(time2, time1)
  nint2 <- interval(time22, time21)
  nint3 <- interval(time32, time31)

  expect_equal(suppressMessages(union(int1, int2)),
               interval(time1, time22))
  expect_equal(suppressMessages(union(int1, int3)),
               interval(time1, time32))
  expect_equal(suppressMessages(union(int3, int1)),
               interval(time1, time32))
  expect_equal(suppressMessages(union(int1, c(int2, int3))),
               interval(c(time1, time1), c(time22, time32)))
  expect_equal(suppressMessages(union(c(int1, int3), int2)),
               interval(c(time1, time21), c(time22, time32)))
  expect_equal(suppressMessages(union(c(int1, int3), c(int2, int1))),
               interval(c(time1, time1), c(time22, time32)))

  expect_equal(suppressMessages(union(nint1, nint2)),
               interval(time22, time1))
  expect_equal(suppressMessages(union(nint1, nint3)),
               interval(time32, time1))
  expect_equal(suppressMessages(union(nint3, nint1)),
               interval(time32, time1))
  expect_equal(suppressMessages(union(nint1, c(nint2, nint3))),
               interval(c(time22, time32), c(time1, time1)))
  expect_equal(suppressMessages(union(c(nint1, nint3), nint2)),
               interval(c(time22, time32), c(time1, time21)))
  expect_equal(suppressMessages(union(c(nint1, nint3), c(nint2, nint1))),
               interval(c(time22, time32), c(time1, time1)))


  expect_equal(suppressMessages(union(int1, nint2)),
               interval(time1, time22))
  expect_equal(suppressMessages(union(nint1, int2)),
               interval(time22, time1))
  expect_equal(suppressMessages(union(int1, nint3)),
               interval(time1, time32))
  expect_equal(suppressMessages(union(nint1, int3)),
               interval(time32, time1))
  expect_equal(suppressMessages(union(int3, nint1)),
               interval(time1, time32))
  expect_equal(suppressMessages(union(nint3, int1)),
               interval(time32, time1))
  expect_equal(suppressMessages(union(int1, c(nint2, nint3))),
               interval(c(time1, time1), c(time22, time32)))
  expect_equal(suppressMessages(union(nint1, c(int2, int3))),
               interval(c(time22, time32), c(time1, time1)))
  expect_equal(suppressMessages(union(nint1, c(int2, nint3))),
               interval(c(time22, time32), c(time1, time1)))
  expect_equal(suppressMessages(union(c(int1, int3), nint2)),
               interval(c(time1, time21), c(time22, time32)))
  expect_equal(suppressMessages(union(c(nint1, nint3), int2)),
               interval(c(time22, time32), c(time1, time21)))
  expect_equal(suppressMessages(union(c(int1, nint3), nint2)),
               interval(c(time1, time32), c(time22, time21)))
  expect_equal(suppressMessages(union(c(int1, int3), c(nint2, nint1))),
               interval(c(time1, time1), c(time22, time32)))
  expect_equal(suppressMessages(union(c(nint1, nint3), c(int2, int1))),
               interval(c(time22, time32), c(time1, time1)))
  expect_equal(suppressMessages(union(c(int1, nint3), c(nint2, int1))),
               interval(c(time1, time32), c(time22, time1)))
})

test_that("setdiff.Interval works as expected", {
  time1 <- as.POSIXct("2001-01-01", tz = "UTC")
  time2 <- as.POSIXct("2002-01-01", tz = "UTC")
  time21 <- as.POSIXct("2001-06-01", tz = "UTC")
  time22 <- as.POSIXct("2002-06-01", tz = "UTC")
  time31 <- as.POSIXct("2003-01-01", tz = "UTC")
  time32 <- as.POSIXct("2004-01-01", tz = "UTC")
  int1 <- interval(time1, time2)
  int2 <- interval(time21, time22)
  int3 <- interval(time31, time32)

  nint1 <- interval(time2, time1)
  nint2 <- interval(time22, time21)
  nint3 <- interval(time32, time31)

  arrive <- ymd_hms("2011-06-04 12:00:00",
    tz = "Pacific/Auckland")
  leave <- ymd_hms("2011-08-10 14:00:00",
    tz = "Pacific/Auckland")
  auckland <- interval(arrive, leave)
  jsm2 <- interval(ymd(20110720, tz = "Pacific/Auckland"),
    ymd(20110731, tz = "Pacific/Auckland"))

  expect_equal(setdiff(int1, int2), interval(time1, time21))
  expect_equal(setdiff(int1, int3), int1)
  expect_equal(setdiff(int1, c(int2, int3)), c(interval(time1, time21), int1))
  expect_equal(setdiff(c(int1, int3), int2), c(interval(time1, time21), int3))
  expect_equal(setdiff(c(int1, int3), c(int2, int2)), c(interval(time1, time21), int3))

  expect_equal(setdiff(nint1, nint2), interval(time21, time1))
  expect_equal(setdiff(nint1, nint3), nint1)
  expect_equal(setdiff(nint1, c(nint2, nint3)), c(interval(time21, time1), nint1))
  expect_equal(setdiff(c(nint1, nint3), nint2), c(interval(time21, time1), nint3))
  expect_equal(setdiff(c(nint1, nint3), c(nint2, nint2)), c(interval(time21, time1), nint3))

  expect_equal(setdiff(int1, nint2), interval(time1, time21))
  expect_equal(setdiff(nint1, int2), interval(time21, time1))
  expect_equal(setdiff(int1, nint3), int1)
  expect_equal(setdiff(nint1, int3), nint1)
  expect_equal(setdiff(int1, c(nint2, nint3)), c(interval(time1, time21), int1))
  expect_equal(setdiff(nint1, c(int2, int3)), c(interval(time21, time1), nint1))
  expect_equal(setdiff(int1, c(nint2, int3)), c(interval(time1, time21), int1))
  expect_equal(setdiff(nint1, c(int2, nint3)), c(interval(time21, time1), nint1))
  expect_equal(setdiff(c(int1, int3), nint2), c(interval(time1, time21), int3))
  expect_equal(setdiff(c(nint1, nint3), int2), c(interval(time21, time1), nint3))
  expect_equal(setdiff(c(nint1, int3), nint2), c(interval(time21, time1), int3))
  expect_equal(setdiff(c(int1, int3), c(nint2, nint2)), c(interval(time1, time21), int3))
  expect_equal(setdiff(c(nint1, nint3), c(int2, int2)), c(interval(time21, time1), nint3))
  expect_equal(setdiff(c(int1, nint3), c(nint2, int2)), c(interval(time1, time21), nint3))
  expect_error(setdiff(auckland, jsm2),
    "Cases 1 result in discontinuous intervals.")

})

test_that("%within% works as expected", {
    time1 <- as.POSIXct("2001-01-01", tz = "UTC")
    time2 <- as.POSIXct("2003-01-01", tz = "UTC")
    time3 <- as.POSIXct("2001-06-01", tz = "UTC")
    time4 <- as.POSIXct("2002-06-01", tz = "UTC")
    time5 <- as.POSIXct("2003-01-01", tz = "UTC")
    time6 <- as.POSIXct("2004-01-01", tz = "UTC")
    time7 <- as.POSIXct("2003-01-02", tz = "UTC")
    base <- interval(time1, time2)
    ins <- interval(time3, time4)
    bord <- interval(time5, time6)
    olap <- interval(time4, time6)
    outs <- interval(time7, time6)

    nbase <- interval(time2, time1)
    nins <- interval(time4, time3)
    nbord <- interval(time6, time5)
    nolap <- interval(time6, time4)
    nouts <- interval(time6, time7)

    expect_true(ins %within% base)
    expect_false(outs %within% base)
    expect_false(bord %within% base)
    expect_false(olap %within% base)

    expect_true(nins %within% nbase)
    expect_false(nouts %within% nbase)
    expect_false(nbord %within% nbase)
    expect_false(nolap %within% nbase)

    expect_true(ins %within% nbase)
    expect_false(outs %within% nbase)
    expect_false(bord %within% nbase)
    expect_false(olap %within% nbase)

    expect_true(nins %within% base)
    expect_false(nouts %within% base)
    expect_false(nbord %within% base)
    expect_false(nolap %within% base)

})


test_that("%with% recycles both arguments", {
  blackouts<- c(interval(ymd("2014-12-30"), ymd("2014-12-31")),
                interval(ymd("2014-12-30"), ymd("2015-01-03")))
  testdates <-c(ymd("2014-12-20", ymd("2014-12-30"), ymd("2015-01-01"), ymd("2015-01-03")))
  expect_equal(testdates %within% blackouts, c(F, T, F, T))
})

test_that("%with% works with list of intervals", {

  testdates <-ymd(c("2014-12-20", "2014-12-30", "2015-01-01", "2015-01-03"))
  blackouts<- list(interval(ymd("2014-12-30"), ymd("2014-12-31")),
                   interval(ymd("2014-12-30"), ymd("2015-01-03")))
  expect_equal(testdates %within% blackouts, c(F, T, T, T))
  testdates <-c(ymd(c("2014-12-20", "2014-12-30", "2015-01-01", "2015-01-03"), tz = "UTC"))
  blackouts<- list(interval(ymd("2014-12-30"), ymd("2014-12-31")),
                   interval(ymd("2014-12-30"), ymd("2015-01-03")))
  expect_equal(testdates %within% blackouts, c(F, T, T, T))

})

test_that("%% on interval uses m+ arithmetic", {

  ## From https://github.com/tidyverse/lubridate/issues/633
  start <- c("2016-04-29 12:00:00 GMT", "2013-10-31 12:00:00 GMT", "2012-05-31 12:00:00 GMT", "2010-06-29 12:00:00 GMT",
             "2014-12-31 12:00:00 GMT", "2015-08-31 12:00:00 GMT", "2013-03-29 12:00:00 GMT", "2014-07-31 12:00:00 GMT")
  end <- c("2017-03-25", "2014-03-16", "2012-12-15", "2011-03-25", "2015-10-16", "2016-03-16", "2014-03-28", "2015-07-22")

  x <- as.POSIXct(start)
  int <- interval(x, end)
  n <- int %/% months(1)
  expect_true(!any(is.na(int %% months(1))))

})

test_that("summary.Interval creates useful summary", {
  time1 <- as.POSIXct("2001-01-01", tz = "UTC")
  time2 <- as.POSIXct("2003-01-01", tz = "UTC")
  int <- interval(time1, time2)

  text <- structure(c("1", "2001-01-01", "2003-01-01", "UTC", "1"),
    .Names = c("Intervals", "Earliest endpoint", "Latest endpoint", "Time zone",
               "NA's"))

  expect_equal(summary(c(int, NA)), text)
})

test_that("intersect on intervals propagates NAs (#226)", {
  expect_equal(intersect(c(interval("2014-01-15", "2014-01-16"),
                           interval("2014-01-15", "2014-01-16")),
                         c(interval(NA, NA), interval(NA, NA))),
               c(interval(NA, NA), interval(NA, NA)))
  expect_equal(intersect(c(interval("2014-01-15", "2014-01-16"),
                           interval("2014-01-15", "2014-01-16"),
                           interval("2014-01-01", "2014-01-30")),
                         c(interval(NA, NA), interval(NA, NA),
                           interval("2014-01-15", "2014-02-16"))),
               c(interval(NA, NA), interval(NA, NA), interval("2014-01-15", "2014-01-30")))
})

test_that("Reduce works with intervals (#348)", {

  ints <- c(
    interval(ymd("2001-01-01"), ymd("2002-01-01")),
    interval(ymd("2001-01-01"), ymd("2004-01-01")),
    interval(ymd("2001-02-01"), ymd("2002-01-01"))
  )

  expect_equal(Reduce(union, ints),
               interval(ymd("2001-01-01"), ymd("2004-01-01")))

})

test_that("Intervals handles missing numbers", {

  int <- new("Interval"
           , .Data = c(NA, NA, NA, 123552000, 71020800, 82425600)
           , start = structure(c(NA, NA, NA, 1174953600, 1364428800, 1183334400),
                               class = c("POSIXct", "POSIXt"), tzone = "UTC")
           , tzone = "UTC")

  out <- new("Interval"
           , .Data = c(NA, NA, NA, 31622400, NA, 31622400)
           , start = structure(c(NA, NA, NA, 1199145600, NA, 1199145600), tzone = "UTC",
                               class = c("POSIXct", "POSIXt"))
           , tzone = "UTC")

  expect_equal(intersect(int, interval("2008-01-01", "2009-01-01")), out)

  expect_equal(intersect(int, int), int)

})
