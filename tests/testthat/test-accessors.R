context("Accessors")

test_that("seconds accessor extracts correct second", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(second(poslt), 59)
  expect_equal(second(posct), 59)
  expect_equal(second(date), 0)

})

test_that("minutes accessor extracts correct minute", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(minute(poslt), 45)
  expect_equal(minute(posct), 45)
  expect_equal(minute(date), 0)

})

test_that("hours accessor extracts correct hour", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(hour(poslt), 13)
  expect_equal(hour(posct), 13)
  expect_equal(hour(date), 0)

})

test_that("days accessors extract correct days", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(day(poslt), 3)
  expect_equal(day(posct), 3)
  expect_equal(day(date), 3)

  expect_equal(mday(poslt), 3)
  expect_equal(mday(posct), 3)
  expect_equal(mday(date), 3)

  expect_equal(yday(poslt), 34)
  expect_equal(yday(posct), 34)
  expect_equal(yday(date), 34)

  expect_equal(wday(poslt), 4)
  expect_equal(wday(posct), 4)
  expect_equal(wday(date), 4)

  expect_equal(qday(poslt), 34)
  expect_equal(qday(poslt), 34)
  expect_equal(qday(poslt), 34)
})

test_that("empty argument date() works", {
  expect_silent(date())
})

test_that("day accessors work on character inputs", {
  x <- "2017-05-07 GMT"
  d <- ymd(x)
  expect_equal(wday(x), wday(d))
  expect_equal(mday(x), mday(d))
  expect_equal(qday(x), qday(d))
  expect_equal(yday(x), yday(d))
})

test_that("wday works with various start values", {

  days <- days2 <-
    ymd(c("2005-01-01", "2005-01-02", "2005-12-31", "2007-01-01", "2007-12-30",
          "2007-12-31", "2008-01-01", "2008-12-28", "2008-12-29", "2008-12-30",
          "2008-12-31", "2009-01-01", "2009-12-31", "2010-01-01", "2010-01-02"))

  expect_equal(as.character(wday(days, label = T, week_start = 1)),
               as.character(wday(days, label = T, week_start = 3)))

  expect_equal(as.character(wday(days, label = T, week_start = 1)),
               as.character(wday(days, label = T, week_start = 7)))

  expect_equal(as.character(wday(days, label = T, locale = "C"))[1], "Sat")
  expect_equal(as.character(wday(days, label = T, abbr = FALSE, locale = "C"))[1], "Saturday")

  expect_equal(wday(days, label = F, week_start = 1),
               c(6, 7, 6, 1, 7, 1, 2, 7, 1, 2, 3, 4, 4, 5, 6))

  expect_equal(wday(days, label = F, week_start = 7),
               c(7, 1, 7, 2, 1, 2, 3, 1, 2, 3, 4, 5, 5, 6, 7))

  set.seed(1000)
  new_days <- sample(1:7, length(days2), replace = T)
  wday(days2, week_start = 1) <- new_days
  expect_equal(wday(days2, week_start = 1), new_days)
  wday(days2, week_start = 7) <- new_days
  expect_equal(wday(days2, week_start = 7), new_days)
  wday(days2, week_start = 3) <- new_days
  expect_equal(wday(days2, week_start = 3), new_days)
})

test_that("weeks accessor extracts correct week", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(week(poslt), 5)
  expect_equal(week(posct), 5)
  expect_equal(week(date), 5)

})

test_that("isoweek accessor extracts correct ISO8601 week", {
  poslt <- as.POSIXlt("2010-01-01 13:45:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(isoweek(poslt), 53)
  expect_equal(isoweek(posct), 53)
  expect_equal(isoweek(date), 53)

  df <- read.table(textConnection(
    "Sat 1 Jan 2005 	2005-01-01 	2004-W53-6
     Sun 2 Jan 2005 	2005-01-02 	2004-W53-7
     Sat 31 Dec 2005 	2005-12-31 	2005-W52-6
     Mon 1 Jan 2007 	2007-01-01 	2007-W01-1 	Both years 2007 start with the same day.
     Sun 30 Dec 2007 	2007-12-30 	2007-W52-7
     Mon 31 Dec 2007 	2007-12-31 	2008-W01-1
     Tue 1 Jan 2008 	2008-01-01 	2008-W01-2 	Gregorian year 2008 is a leap year. ISO year 2008 is 2 days shorter: 1 day longer at the start, 3 days shorter at the end.
     Sun 28 Dec 2008 	2008-12-28 	2008-W52-7 	ISO year 2009 begins three days before the end of Gregorian 2008.
     Mon 29 Dec 2008 	2008-12-29 	2009-W01-1
     Tue 30 Dec 2008 	2008-12-30 	2009-W01-2
     Wed 31 Dec 2008 	2008-12-31 	2009-W01-3
     Thu 1 Jan 2009 	2009-01-01 	2009-W01-4
     Thu 31 Dec 2009 	2009-12-31 	2009-W53-4 	ISO year 2009 has 53 weeks and ends three days into Gregorian year 2010.
     Fri 1 Jan 2010 	2010-01-01 	2009-W53-5
     Sat 2 Jan 2010 	2010-01-02 	2009-W53-6
     Sun 3 Jan 2010 	2010-01-03 	2009-W53-7"),
    sep = "\t", fill = T, stringsAsFactors = F, header = F)

  names(df) <- c("Gregorian", "ymd", "iso", "note")

  df <- within(df, {
    ymd <- ymd(ymd)
    isoweek <- as.numeric(gsub(".*W([0-9]+).*", "\\1", iso))
    isoyear <- as.numeric(gsub("^([0-9]+).*", "\\1", iso))
  })

  expect_equal(isoweek(df$ymd), df$isoweek)
  expect_equal(isoyear(df$ymd), df$isoyear)
})

test_that("epiweek computes dates correctly", {

  df <- read.table(textConnection(
    "ew	date	year
     1	12/30/07	8
     2	01/06/08	8
     3	01/13/08	8
     52	01/02/10	9
     1	01/03/10	10
     2	01/10/10	10
     3	01/17/10	10
     4	01/24/10	10
     5	01/31/10	10
     1	01/04/09	9
     2	01/11/09	9
     3	01/18/09	9
     50 	12/13/09	9
     51 	12/20/09	9
     52 	12/27/09	9
     50 	12/12/10	10
     51 	12/19/10	10
     52 	12/26/10	10
     50 	12/07/08	8
     51 	12/14/08	8
     52 	12/21/08	8"),
    header = T, sep = "\t", stringsAsFactors = F)

  date <- mdy(df$date)
  expect_equal(epiweek(date), df$ew)
  expect_equal(epiyear(date), df$year + 2000)
})

test_that("isoweek returns correct value for non-UTC time zone (#311)", {
  cest <- ymd_hms("2015-04-14 16:45:00", tz = "Europe/Copenhagen")
  utc <-  ymd_hms("2015-04-14 16:45:00", tz = "UTC")
  expect_equal(isoweek(cest), 16L)
  expect_equal(isoweek(utc), 16L)
})

test_that("months accessor extracts correct month", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(month(poslt), 2)
  expect_equal(month(posct), 2)
  expect_equal(month(date), 2)

  expect_equal(as.character(month(date, label = TRUE, locale = "C")), "Feb")
  expect_equal(as.character(month(date, label = TRUE, abbr = FALSE, locale = "C")),
              "February")

})

test_that("quarters accessor extracts correct quarter", {
  posct <- ymd_hms("2010-11-03 13:45:59")
  poslt <- as.POSIXlt(posct)
  date <- as.Date(poslt)

  expect_equal(quarter(poslt), 4)
  expect_equal(quarter(poslt, with_year = TRUE), 2010.4)
  expect_equal(quarter(poslt, fiscal_start = 11), 1)
  expect_equal(quarter(poslt, with_year = TRUE, fiscal_start = -2), 2011.1)
  expect_equal(quarter(poslt, with_year = TRUE, fiscal_start = 11), 2011.1)

  expect_equal(quarter(posct), 4)
  expect_equal(quarter(posct, with_year = TRUE), 2010.4)
  expect_equal(quarter(posct, fiscal_start = 11), 1)
  expect_equal(quarter(posct, with_year = TRUE, fiscal_start = -2), 2011.1)
  expect_equal(quarter(posct, with_year = TRUE, fiscal_start = 11), 2011.1)

  expect_equal(quarter(date), 4)
  expect_equal(quarter(date, with_year = TRUE), 2010.4)
  expect_equal(quarter(date, fiscal_start = 11), 1)
  expect_equal(quarter(date, with_year = TRUE, fiscal_start = -2), 2011.1)
  expect_equal(quarter(date, with_year = TRUE, fiscal_start = 11), 2011.1)

  x <- ymd(c("2012-03-26", "2012-05-04", "2012-09-23", "2012-03-01", "2012-12-31"))
  expect_equal(quarter(x, with_year = TRUE, fiscal_start = 4),
               c(2011.4, 2012.1, 2012.2, 2011.4, 2012.3))
  expect_equal(quarter(x, with_year = TRUE, fiscal_start = 11),
               c(2012.2, 2012.3, 2012.4, 2012.2, 2013.1))
})

test_that("years accessor extracts correct year", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(year(poslt), 2010)
  expect_equal(year(posct), 2010)
  expect_equal(year(date), 2010)

})

test_that("isoyear accessor extracts correct ISO8601 year", {
  poslt <- c(as.POSIXlt("2014-12-28 13:45:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S"),
             as.POSIXlt("2014-12-29 01:12:08", tz = "UTC", format = "%Y-%m-%d %H:%M:%S"))
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(isoyear(poslt), c(2014, 2015))
  expect_equal(isoyear(posct), c(2014, 2015))
  expect_equal(isoyear(date), c(2014, 2015))

})

test_that("date accessor extracts correct date", {
  poslt <- as.POSIXlt("2010-02-03 23:45:59", tz = "Etc/GMT+8", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)

  date <- as.Date(poslt)
  expect_equal(date(poslt), as.Date("2010-02-03"))
  expect_equal(date(posct), as.Date("2010-02-03"))
  expect_equal(date(date), as.Date("2010-02-03"))
})

test_that("timezone accessor extracts correct timezone", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_match(tz(poslt), "UTC")
  expect_match(tz(posct), "UTC")
  expect_match(tz(date), "UTC")

})


test_that("accessors handle vectors", {
  poslt <- as.POSIXlt(c("2001-01-01 01:01:01",
    "2002-02-02 02:02:02", "2003-03-03 03:03:03"),
    tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  expect_equal(second(poslt), c(1, 2, 3))
  expect_equal(second(posct), c(1, 2, 3))
  expect_equal(second(date), c(0, 0, 0))

  expect_equal(minute(poslt), c(1, 2, 3))
  expect_equal(minute(posct), c(1, 2, 3))
  expect_equal(minute(date), c(0, 0, 0))

  expect_equal(hour(poslt), c(1, 2, 3))
  expect_equal(hour(posct), c(1, 2, 3))
  expect_equal(hour(date), c(0, 0, 0))

  expect_equal(mday(poslt), c(1, 2, 3))
  expect_equal(mday(posct), c(1, 2, 3))
  expect_equal(mday(date), c(1, 2, 3))

  expect_equal(wday(poslt), c(2, 7, 2))
  expect_equal(wday(posct), c(2, 7, 2))
  expect_equal(wday(date), c(2, 7, 2))

  expect_equal(yday(poslt), c(1, 33, 62))
  expect_equal(yday(posct), c(1, 33, 62))
  expect_equal(yday(date), c(1, 33, 62))

  expect_equal(week(poslt), c(1, 5, 9))
  expect_equal(week(posct), c(1, 5, 9))
  expect_equal(week(date), c(1, 5, 9))

  expect_equal(isoweek(poslt), c(1, 5, 10))
  expect_equal(isoweek(posct), c(1, 5, 10))
  expect_equal(isoweek(date), c(1, 5, 10))

  expect_equal(month(poslt), c(1, 2, 3))
  expect_equal(month(posct), c(1, 2, 3))
  expect_equal(month(date), c(1, 2, 3))

  expect_equal(year(poslt), c(2001, 2002, 2003))
  expect_equal(year(posct), c(2001, 2002, 2003))
  expect_equal(year(date), c(2001, 2002, 2003))

  expect_equal(date(poslt), as.Date(c("2001-01-01", "2002-02-02", "2003-03-03")))
  expect_equal(date(posct), as.Date(c("2001-01-01", "2002-02-02", "2003-03-03")))
  expect_equal(date(date), as.Date(c("2001-01-01", "2002-02-02", "2003-03-03")))

  expect_match(tz(poslt), "UTC")
  expect_match(tz(posct), "UTC")
  expect_match(tz(date), "UTC")
})

test_that("accessors handle Period objects", {
  per <- period(seconds = 1, minutes = 2, hours = 3, days = 4, months = 5,  years = 6)
  pers <- c(per, per)

  expect_equal(second(per), 1)
  expect_equal(minute(per), 2)
  expect_equal(hour(per), 3)
  expect_equal(day(per), 4)
  expect_equal(month(per), 5)
  expect_equal(year(per), 6)
  expect_error(date(per), "date is undefined for Period objects")

  expect_equal(second(pers), c(1, 1))
  expect_equal(minute(pers), c(2, 2))
  expect_equal(hour(pers), c(3, 3))
  expect_equal(day(pers), c(4, 4))
  expect_equal(month(pers), c(5, 5))
  expect_equal(year(pers), c(6, 6))
  expect_error(date(pers), "date is undefined for Period objects")

  second(per) <- 2
  minute(per) <- 3
  hour(per) <- 4
  day(per) <- 5
  month(per) <- 6
  year(per) <- 7

  expect_equal(per@.Data, 2)
  expect_equal(per@minute, 3)
  expect_equal(per@hour, 4)
  expect_equal(per@day, 5)
  expect_equal(per@month, 6)
  expect_equal(per@year, 7)

  second(pers) <- c(2, 3)
  minute(pers) <- c(3, 4)
  hour(pers) <- c(4, 5)
  day(pers) <- c(5, 6)
  month(pers) <- c(6, 7)
  year(pers) <- c(7, 8)

  expect_equal(pers@.Data, c(2, 3))
  expect_equal(pers@minute, c(3, 4))
  expect_equal(pers@hour, c(4, 5))
  expect_equal(pers@day, c(5, 6))
  expect_equal(pers@month, c(6, 7))
  expect_equal(pers@year, c(7, 8))

})



context("Test days_in_month")

test_that(
  "days in month works for non leap years",
{
  x <- seq(ymd("2011-01-01"), ymd("2011-12-01"), "1 month")
  expected <- c(
    Jan = 31L, Feb = 28L, Mar = 31L,
    Apr = 30L, May = 31L, Jun = 30L,
    Jul = 31L, Aug = 31L, Sep = 30L,
    Oct = 31L, Nov = 30L, Dec = 31L
  )
  expect_equal(days_in_month(x), expected)
}
)

test_that(
  "days in month works for leap years",
{
  x <- seq(ymd("2012-01-01"), ymd("2012-12-01"), "1 month")
  expected <- c(
    Jan = 31L, Feb = 29L, Mar = 31L,
    Apr = 30L, May = 31L, Jun = 30L,
    Jul = 31L, Aug = 31L, Sep = 30L,
    Oct = 31L, Nov = 30L, Dec = 31L
  )
  expect_equal(days_in_month(x), expected)
}
)
