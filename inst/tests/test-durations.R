context("Durations")

test_that("new_duration works as expected",{
  x <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  y <- difftime(x + 5 + 30*60 + 60*60 + 14*24*60*60, x, tz = "UTC", units = "weeks")
  attr(y, "tzone") <- NULL
  
  expect_that(new_duration(seconds = 5, minutes = 30, days = 0, 
    hour = 1, weeks = 2), equals(y))
})

test_that("new_duration handles vectors",{
  x <- as.POSIXct(c("2008-08-03 13:01:59", "2008-08-03 13:01:59"), tz = "UTC")
  y <- difftime(x + c(5 + 30*60 + 60*60 + 14*24*60*60, 
    1 + 3*24*60*60 + 60*60), x, tz = "UTC")
  attr(y, "tzone") <- NULL
  z <- difftime(x + c(5 + 30*60 + 60*60 + 14*24*60*60, 5 + 
    30*60 + 60*60 + 14*24*60*60 + 3*24*60*60), x, tz = "UTC", units = "weeks")
  attr(z, "tzone") <- NULL
    
  
  expect_that(new_duration(seconds = c(5, 1), minutes = c(30,
    0), days = c(0, 3), hour = c(1,1), weeks = c(2, 0)),
    equals(y))
    
  expect_that(new_duration(seconds = 5, minutes = 30, days = 
    c(0, 3), hour = 1, weeks = 2), equals(z))

})



test_that("as.duration handles vectors",{
  expect_that(as.duration(minutes(1:3)), equals(eminutes(1:3)))
})

test_that("as.duration handles periods",{
  
  expect_that(as.duration(seconds(1)), equals(eseconds(1)))
  expect_that(as.duration(minutes(2)), equals(eminutes(2)))
  expect_that(as.duration(hours(3)), equals(ehours(3)))
  expect_that(as.duration(days(4)), equals(edays(4)))
  expect_that(as.duration(weeks(5)), equals(eweeks(5)))
  expect_that(as.duration(years(1)), equals(eseconds(60*60*24*365)))
  expect_that(as.duration(seconds(1) + minutes(4)), equals(eseconds(1) + eminutes(4)))
})

test_that("as.duration gives error for months",{
  expect_that(as.duration(months(1)), throws_error("durations cannot estimate month length"))
})

test_that("as.duration handles intervals",{
	time1 <- as.POSIXct("2009-01-02 12:24:03", tz = "UTC")
	time2 <- as.POSIXct("2010-02-03 14:31:42", tz = "UTC")
	int <- new_interval(time2, time1)
    y <- difftime(time2, time1)
  
  expect_that(as.duration(int), equals(y))
})

test_that("as.duration handles difftimes",{
  x <- difftime(as.POSIXct("2010-02-03 14:31:42", tz = "UTC"),
    as.POSIXct("2009-01-02 12:24:03", tz = "UTC"), units = 
    "weeks" )
  attr(x, "tzone") <- NULL
  
  expect_that(as.duration(x), equals(x))
})


test_that("eobjects handle vectors",{
  x <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  expect_that(eseconds(c(1,3,4)), equals(difftime(x + c(1,3,4),
    x)))
})


test_that("is.instant/is.timepoint works as expected",{
  expect_that(is.instant(234), is_false())
  expect_that(is.instant(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_true())
  expect_that(is.instant(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_true())
  expect_that(is.instant(Sys.Date()), is_true())
  expect_that(is.instant(minutes(1)), is_false())
  expect_that(is.timespan(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})

test_that("is.instant/is.timepoint handle vectors",{
  expect_that(is.instant(minutes(1:2)), is_false())
  expect_that(is.instant(as.POSIXct(c("2008-08-03 13:01:59", 
  	"2008-08-03 13:01:59"), tz = "UTC")), is_true())
})


test_that("is.timespan works as expected",{
  expect_that(is.timespan(234), is_false())
  expect_that(is.timespan(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.timespan(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.timespan(Sys.Date()), is_false())
  expect_that(is.timespan(minutes(1)), is_true())
  expect_that(is.timespan(eminutes(1)), is_true())
  expect_that(is.timespan(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})

test_that("is.timespan handles vectors",{
  expect_that(is.timespan(minutes(1:3)), is_true())
})


test_that("is.POSIXt works as expected",{
  expect_that(is.POSIXt(234), is_false())
  expect_that(is.POSIXt(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_true())
  expect_that(is.POSIXt(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_true())
  expect_that(is.POSIXt(Sys.Date()), is_false())
  expect_that(is.POSIXt(minutes(1)), is_false())
  expect_that(is.POSIXt(eminutes(1)), is_false())
  expect_that(is.POSIXt(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_false())
})

test_that("is.POSIXt handles vectors",{
  expect_that(is.POSIXt(c(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})


test_that("is.difftime/is.duration works as expected",{
  ct_time <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  lt_time <- as.POSIXlt("2009-08-03 13:01:59", tz = "UTC")
	
  expect_that(is.difftime(234), is_false())
  expect_that(is.difftime(ct_time),
    is_false())
  expect_that(is.difftime(lt_time), 
    is_false())
  expect_that(is.difftime(Sys.Date()), is_false())
  expect_that(is.difftime(minutes(1)), is_false())
  expect_that(is.difftime(eminutes(1)), is_true())
  expect_that(is.difftime(new_interval(lt_time, ct_time)), is_true())
})

test_that("is.difftime/is.duration handle vectors",{
  expect_that(is.difftime(eminutes(1:3)), is_true())
})


test_that("is.Date works as expected",{
  expect_that(is.Date(234), is_false())
  expect_that(is.Date(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.Date(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.Date(Sys.Date()), is_true())
  expect_that(is.Date(minutes(1)), is_false())
  expect_that(is.Date(eminutes(1)), is_false())
  expect_that(is.Date(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_false())
})

test_that("is.Date handles vectors",{
  expect_that(is.Date(c(Sys.Date(), as.Date("2009-10-31"))),
    is_true())
})


test_that("is.period works as expected",{
  expect_that(is.period(234), is_false())
  expect_that(is.period(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.period(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.period(Sys.Date()), is_false())
  expect_that(is.period(minutes(1)), is_true())
  expect_that(is.period(eminutes(1)), is_false())
  expect_that(is.period(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_false())
})

test_that("is.period handles vectors",{
  expect_that(is.period(minutes(1:3)), is_true())
})


test_that("is.interval works as expected",{
  expect_that(is.interval(234), is_false())
  expect_that(is.interval(as.POSIXct("2008-08-03 13:01:59", tz = "UTC")),
    is_false())
  expect_that(is.interval(as.POSIXlt("2008-08-03 13:01:59", tz = "UTC")), 
    is_false())
  expect_that(is.interval(Sys.Date()), is_false())
  expect_that(is.interval(minutes(1)), is_false())
  expect_that(is.interval(eminutes(1)), is_false())
  expect_that(is.interval(new_interval(
    as.POSIXct("2008-08-03 13:01:59", tz = "UTC"), 
    as.POSIXct("2009-08-03 13:01:59", tz = "UTC") )), is_true())
})

test_that("is.interval handles vectors",{
  expect_that(is.interval(new_interval(
    as.POSIXct(c("2008-08-03 13:01:59", "2009-08-03 13:01:59"), tz = "UTC"),  
    as.POSIXct("2010-08-03 13:01:59", tz = "UTC"))), is_true())
})

