context("Division operators")

test_that("division operations work for interval numerator", {
  int <- ymd("2009-02-03") %--% ymd("2010-01-01")
  smaller_int <- ymd("2009-12-01") %--% ymd("2010-01-01")
  bigger_int <- ymd("2009-01-01") %--% ymd("2010-02-01")
  smaller_dur <- ddays(20) + dhours(4)
  bigger_dur <- dyears(1) + dseconds(2)
  smaller_diff <- make_difftime(days = 100)
  bigger_diff <- make_difftime(days = 400)
  expect_error(int/smaller_int)
  expect_error(int/bigger_int)
  expect_equal(int_start(int) + days(int/days(1)), int_end(int))
  expect_equal(int_start(int) + ddays(int/ddays(1)), int_end(int))
  expect_equal(int/smaller_diff, 28684800/8640000)
  expect_equal(int/bigger_diff, 28684800/34560000)
})

test_that("division works for interval numerator with vectors", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  int3 <- ymd("2009-01-01") %--% ymd("2010-01-01")
  smaller_diff <- make_difftime(days = 365)
  expect_error(c(int1, int2) / int1)
  expect_error(int1/c(int1, int2))
  expect_equal(c(int1, int2) / years(1), c(1, 2))
  expect_equal(c(int1, int2) / dyears(1), c(1, 2))
  expect_equal(int1/years(1:2), c(1, 0.5))
  expect_equal(int1/dyears(1:2), c(1, 0.5))
  expect_equal(c(int1, int2) / smaller_diff, c(1, 2))
  expect_equal(int2/c(1, 2), c(int2, int3))
  expect_equal(c(int2, int2) / 2, c(int3, int3))
})

test_that("arguments are recycled in interval division", {
expect_equal(interval(c('2015-03-01', '2015-03-02', '2015-03-03'), '2016-10-01') / months(1),
             c(19.00000000, 18.96666667, 18.93333333))
expect_equal(interval(c('2015-03-01', '2015-03-02', '2015-03-03', '2015-03-04'), '2016-10-01') / months(1:2),
             interval(c('2015-03-01', '2015-03-02', '2015-03-03', '2015-03-04'), '2016-10-01') / months(c(1:2, 1:2)))
expect_equal(interval('2015-03-02', '2016-10-01') / months(1:3),
             interval(c('2015-03-02', '2015-03-02', '2015-03-02'), '2016-10-01') / months(1:3))
})

test_that("NA and Interval(0) propagate in interval division", {
  int0 <- interval(character(0), now())
  expect_equal(int0/days(3), numeric(0))
  intNA <- interval(NA, now())
  expect_equal(intNA/days(3), NA_real_)
})

test_that("division works for interval numerator with period denominator", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  int3 <- ymd("2009-01-01") %--% ymd("2010-01-01")
  expect_equal(c(int1, int2) / days(1), time_length(c(int1, int2), "days"))
  expect_equal(c(int1, int2) / minutes(1), time_length(c(int1, int2), "mins"))
  expect_equal(c(int1, int2) / months(1), c(12, 24))
  expect_equal(c(int1, int2) / months(6), c(2, 4))
  expect_equal(c(int1, int2) / years(1), c(1, 2))
  expect_equal(c(int1, int2) / years(2), c(.5, 1))
})

test_that("dividision works for interval vector with NAs", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  int3 <- ymd(NA, quiet = TRUE) %--% ymd(NA, quiet = TRUE)
  ints <- c(int1, int2, int3)
  nas <- as.numeric(c(NA, NA, NA))
  expect_equal(suppressMessages(ints / years(1)), c(1, 2, NA))
  expect_equal(suppressMessages(ints / dyears(1)), c(1, 2, NA))
  expect_equal(suppressMessages(ints / years(NA)), nas)
  expect_equal(suppressMessages(ints / dyears(NA)), nas)

})

test_that("division operations work for period numerator", {
  int1 <- ymd("2009-01-01") %--% ymd("2010-01-01")
  expect_error(years(2) / int1)
  expect_equal(days(2) / hours(12), 4)
  expect_equal(years(1) / months(1), 12)
  expect_error(days(2) / dhours(12))
  expect_error(days(1) / make_difftime(days = 1))
  expect_equal(days(2) / 2, days(1))
})

test_that("division works for period numerator with vectors", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  expect_error(years(1:2) / int2)
  expect_error(years(1) / c(int1, int2))
  expect_equal(days(1:2) / hours(12), c(2, 4))
  expect_equal(days(1) / hours(c(12, 24)), c(2, 1))
  expect_error(days(1:2) / dhours(12))
  expect_error(days(1) / dhours(c(12, 24)))
  expect_error(days(1:2) / make_difftime(days = 1))
  expect_equal(days(2) / c(1, 2), c(days(2), days(1)))
  expect_equal(days(c(2, 4)) / c(2), c(days(1), days(2)))

})

test_that("division operations work for duration numerator", {
  int <-  ymd("2009-12-01") %--% ymd("2010-01-01")
  expect_error(ddays(31)/int)
  expect_error(ddays(20)/ days(20))
  expect_equal(ddays(20)/ ddays(1), 20)
  expect_equal(ddays(20)/ make_difftime(days = 1), 20)
})

test_that("division works for duration numerator with vectors", {
  int1 <- ymd("2010-01-01") %--% ymd("2011-01-01")
  int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  expect_error(ddays(365*c(1:2)) / int2)
  expect_error(ddays(365) / c(int1, int2))
  expect_equal(ddays(1:2) / dhours(12), c(2, 4))
  expect_equal(ddays(1) / dhours(c(12, 24)), c(2, 1))
  expect_error(ddays(1:2) / hours(12))
  expect_error(ddays(1) / hours(c(12, 24)))
  expect_equal(ddays(1:2) / make_difftime(days = 1), c(1, 2))
  expect_equal(ddays(2) / c(1, 2), c(ddays(2), ddays(1)))
  expect_equal(ddays(c(2, 4)) / c(2), c(ddays(1), ddays(2)))
})

test_that("division operations work for difftime numerator", {
  diff <- make_difftime(days = 365)
  int <- ymd("2010-01-01") %--% ymd("2011-01-01")
  expect_error(diff/int)
  expect_error(diff/days(1))
  expect_equal(diff/ddays(365), 1)
})

test_that("division works as expected for periods", {
  expect_that(3/months(1), throws_error())
  expect_that(months(1)/3, throws_error())
  expect_that(months(9)/3, equals(months(3)))
  expect_that(months(9)/3, is_a("Period"))
})

test_that("dividing vectors works for periods", {
  expect_that(c(2, 3)/months(1), throws_error())
  expect_that(months(1)/c(2, 3), throws_error())
  expect_that(months(9)/c(3, 1), equals(months(c(3, 9))))
  expect_that(months(9)/c(3, 1), is_a("Period"))
})

test_that("division works as expected for durations", {
  expect_that(3/dhours(1), throws_error())
  expect_that(dhours(9)/3, equals(dhours(3)))
  expect_that(dhours(9)/3, is_a("Duration"))

})

test_that("dividing vectors works for durations", {
  expect_that(c(2, 3)/dhours(1), throws_error())
  expect_that(dhours(9)/c(3, 1), equals(dhours(c(3, 9))))
  expect_that(dhours(9)/c(3, 1), is_a("Duration"))
})
