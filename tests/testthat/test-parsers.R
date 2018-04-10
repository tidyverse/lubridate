context("Parsing")
Sys.setlocale("LC_TIME", "C")

test_that("ymd functions correctly parse dates separated by -", {
  expect_that(ymd("2010-01-02"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("10-01-02"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("2010-02-01"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("01-02-2010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("01-2010-02"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02-01-2010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("02-2010-01"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("2010-01-02", "2010-01-03")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
})

test_that("ymd functions correctly parse dates separated by /", {
  expect_that(ymd("2010/01/02"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("10/01/02"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("2010/02/01"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("01/02/2010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("01/2010/02"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02/01/2010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("02/2010/01"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("2010/01/02", "2010/01/03")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
})


test_that("ymd functions correctly parse dates separated by .", {
  expect_that(ymd("2010.01.02"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("10.01.02"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("2010.02.01"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("01.02.2010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("01.2010.02"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02.01.2010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("02.2010.01"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("2010.01.02", "2010.01.03")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
})

test_that("ymd functions correctly parse dates separated by ,", {
  expect_that(ymd("2010,01,02"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("10,01,02"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("2010,02,01"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("01,02,2010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("01,2010,02"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02,01,2010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("02,2010,01"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("2010,01,02", "2010,01,03")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
})

test_that("ymd functions correctly parse dates separated by :", {
  expect_that(ymd("2010:01:02"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("10:01:02"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("2010:02:01"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("01:02:2010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("01:2010:02"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02:01:2010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("02:2010:01"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("2010:01:02", "2010:01:03")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
})

test_that("ymd functions correctly parse dates with no separators", {
  expect_that(ymd("20100102"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("20100201"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("01022010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("01201002"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02012010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("02201001"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("20100102", "20100103")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
  expect_that(ymd("100102"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("20100102"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("20100201"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("01022010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("01201002"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02012010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("02201001"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("20100102", "20100103")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
  expect_that(ymd("100102"),
              equals(as.Date("2010-01-02")))
})

test_that("ymd functions correctly parse dates with no separators", {
  expect_that(ymd("20100102"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("20100201"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("01022010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("01201002"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02012010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("02201001"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("20100102", "20100103")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
  expect_that(ymd("100102"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("20100102"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("20100201"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("01022010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("01201002"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02012010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("02201001"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("20100102", "20100103")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
  expect_that(ymd("100102"),
              equals(as.Date("2010-01-02")))
})

test_that("ymd parser warns on failed parsing", {
  expect_warning(ymd("2018-02-30", quiet = FALSE), ".*failed to parse")
})

test_that("ymd function correctly parse b and B formats", {
    expect_equal(ymd("2004-Jan-15"), as.Date("2004-01-15"))
    expect_equal(ymd("2004-January-15"),
                 as.Date("2004-01-15"))
    expect_equal(ymd("2004-Jan-15", "2004-Feb-15", "1904-Jan-15", "1904-Feb-15"),
                 as.Date(c("2004-01-15 UTC", "2004-02-15 UTC", "1904-01-15 UTC", "1904-02-15 UTC")))
    expect_equal(ymd("2004-Jan-15", "2004-Feb-15", "1904-January-15", "1904-February-15"),
                 as.Date(c("2004-01-15 UTC", "2004-02-15 UTC", "1904-01-15 UTC", "1904-02-15 UTC")))
    expect_equal(mdy("Jan-15-2004"), as.Date("2004-01-15"))
    expect_equal(mdy("January-15-2004"),
                 as.Date("2004-01-15"))
    expect_equal(mdy("Jan-15-2004", "Feb-15-2004", "Jan-15-1904", "Feb-15-1904"),
                 as.Date(c("2004-01-15 UTC", "2004-02-15 UTC", "1904-01-15 UTC", "1904-02-15 UTC")))
    expect_equal(mdy("Jan-15-2004", "Feb-15-2004", "January-15-1904", "February-15-1904"),
                 as.Date(c("2004-01-15 UTC", "2004-02-15 UTC", "1904-01-15 UTC", "1904-02-15 UTC")))
})

test_that("ymd function correctly parse b and B formats", {
  expect_equal(ymd("2004-Jan-15"), as.Date("2004-01-15"))
  expect_equal(ymd("2004-January-15"),
               as.Date("2004-01-15"))
  expect_equal(ymd("2004-Jan-15", "2004-Feb-15", "1904-Jan-15", "1904-Feb-15"),
               as.Date(c("2004-01-15 UTC", "2004-02-15 UTC", "1904-01-15 UTC", "1904-02-15 UTC")))
  expect_equal(ymd("2004-Jan-15", "2004-Feb-15", "1904-January-15", "1904-February-15"),
               as.Date(c("2004-01-15 UTC", "2004-02-15 UTC", "1904-01-15 UTC", "1904-02-15 UTC")))
  expect_equal(mdy("Jan-15-2004"), as.Date("2004-01-15"))
  expect_equal(mdy("January-15-2004"),
               as.Date("2004-01-15"))
  expect_equal(mdy("Jan-15-2004", "Feb-15-2004", "Jan-15-1904", "Feb-15-1904"),
               as.Date(c("2004-01-15 UTC", "2004-02-15 UTC", "1904-01-15 UTC", "1904-02-15 UTC")))
  expect_equal(mdy("Jan-15-2004", "Feb-15-2004", "January-15-1904", "February-15-1904"),
               as.Date(c("2004-01-15 UTC", "2004-02-15 UTC", "1904-01-15 UTC", "1904-02-15 UTC")))
})

test_that("ymd functions correctly parse dates with no separators and b and B formats", {
  expect_that(ymd("2010January02"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("201002January"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("January022010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("January201002"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02January2010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("022010January"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("2010January02", "2010January03")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
  expect_that(ymd("10January02"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("2010January02"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("201002January"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("January022010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("January201002"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02January2010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("022010January"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("2010January02", "2010January03")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
  expect_that(ymd("10January02"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("2010Jan02"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("201002Jan"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("Jan022010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("Jan201002"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02Jan2010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("022010Jan"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("2010Jan02", "2010Jan03")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
  expect_that(ymd("10Jan02"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd("2010Jan02"),
              equals(as.Date("2010-01-02")))
  expect_that(ydm("201002Jan"),
              equals(as.Date("2010-01-02")))
  expect_that(mdy("Jan022010"),
              equals(as.Date("2010-01-02")))
  expect_that(myd("Jan201002"),
              equals(as.Date("2010-01-02")))
  expect_that(dmy("02Jan2010"),
              equals(as.Date("2010-01-02")))
  expect_that(dym("022010Jan"),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c("2010Jan02", "2010Jan03")),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
  expect_that(ymd("10Jan02"),
              equals(as.Date("2010-01-02")))
})


test_that("ymd functions correctly parse dates with no separators and no quotes", {
  expect_that(ymd(20100102),
              equals(as.Date("2010-01-02")))
  expect_that(ydm(20100201),
              equals(as.Date("2010-01-02")))
  expect_that(mdy(01022010),
              equals(as.Date("2010-01-02")))
  expect_that(myd(01201002),
              equals(as.Date("2010-01-02")))
  expect_that(dmy(02012010),
              equals(as.Date("2010-01-02")))
  expect_that(dym(02201001),
              equals(as.Date("2010-01-02")))
  expect_that(ymd(c(20100102, 20100103)),
              equals(as.Date(c("2010-01-02", "2010-01-03"))))
  expect_that(ymd(100102),
              equals(as.Date("2010-01-02")))
  expect_that(ymd_hms(20100102235959),
              equals(as.POSIXct("2010-01-02 23:59:59", tz = "UTC")))
})

test_that("all numbers are correctly converted into character for parsing", {
  # Conversion to character of numbers with 000000 at the end with as.character()
  # may outputs scientific notation depending on the value of the 'scipen' option.
  # .num_to_date() uses format() to avoid that. Check that it does indeed work
  expect_that(ymd_hms(20100102000000),
              equals(as.POSIXct("2010-01-02 00:00:00", tz = "UTC")))
  expect_that(.num_to_date(20100102000000),
              equals("20100102000000"))
})

test_that("ymd functions parse absurd formats as NA's", {
  ## should not through errors, just as as.POSIX and strptime
  pna <- as.Date(NA)
  expect_that(ymd(201001023, quiet = TRUE), equals(pna))
  expect_that(ydm(20103201, quiet = TRUE),  equals(pna))
  expect_that(mdy(13022010, quiet = TRUE), equals(pna))
  expect_that(myd(01201033, quiet = TRUE), equals(pna))
  expect_that(dmy(02222010, quiet = TRUE), equals(pna))
  expect_that(dym(022010013, quiet = TRUE), equals(pna))
  pna <- with_tz(as.POSIXct(NA), "UTC")
  expect_that(ymd_hms("2010-01-023 23:59:59", quiet = TRUE), equals(pna))
  expect_that(ymd_hms("2010-01-023 23:59:59.34", quiet = TRUE), equals(pna))
  expect_that(ymd_hms("201001023235959.34", quiet = TRUE), equals(pna))
  expect_that(ymd(c(201001024, 20100103), quiet = TRUE),
              equals(as.Date(c(NA, "2010-01-03"))))
})

test_that("ymd functions give warning when parsing absurd formats", {
  ## should not through errors, just as as.POSIX and strptime
  expect_warning(ymd(201001023))
  expect_warning(ydm(20103201))
  expect_warning(mdy(13022010))
  expect_warning(myd(01201033))
  expect_warning(dmy(02222010))
  expect_warning(dym(022010013))
  expect_warning(ymd_hms("2010-01-023 23:59:59"))
  expect_warning(ymd_hms("2010-01-023 23:59:59.34"))
  expect_warning(ymd_hms("201001023235959.34"))
  expect_warning(ymd(c(201001024, 20100103)))
})

test_that("cutoff_2000 works as expected", {

  dates <- c("20-02-03", "67-02-03", "68-02-03", "69-02-03", "99-02-03", "00-02-03")

  expect_equal(parse_date_time2(dates, "ymd"),
               ymd(c("2020-02-03", "2067-02-03", "2068-02-03", "1969-02-03", "1999-02-03", "2000-02-03"), tz = "UTC"))

  expect_equal(parse_date_time2(dates, "ymd", cutoff_2000 = 67),
               ymd(c("2020-02-03", "2067-02-03", "1968-02-03", "1969-02-03", "1999-02-03", "2000-02-03"), tz = "UTC"))

  expect_equal(parse_date_time2(dates, "ymd", cutoff_2000 = 20),
               ymd(c("2020-02-03", "1967-02-03", "1968-02-03", "1969-02-03", "1999-02-03", "2000-02-03"), tz = "UTC"))

  expect_equal(parse_date_time2(dates, "ymd", cutoff_2000 = 0),
               ymd(c("1920-02-03", "1967-02-03", "1968-02-03", "1969-02-03", "1999-02-03", "2000-02-03"), tz = "UTC"))

  expect_equal(parse_date_time2(dates, "ymd", cutoff_2000 = -1),
               ymd(c("1920-02-03", "1967-02-03", "1968-02-03", "1969-02-03", "1999-02-03", "1900-02-03"), tz = "UTC"))

})

test_that("0 month and 0 day in date produces NA",
          {
              expect_equal(ymd(c("2013-1-1", "2013-0-1"), quiet = TRUE),
                           as.Date(c("2013-01-01", NA)))
              expect_equal(ymd(c("2013-1-1", "2013-1-0"), quiet = TRUE),
                           as.Date(c("2013-01-01", NA)))
              expect_equal(ymd("2013-1-0", quiet = TRUE),
                           as.Date(as.character(NA)))
          })

test_that("ymd_hms correctly handles a variety of formats", {
  expect_that(ymd_hms("2010-01-02 23:59:59"),
              equals(as.POSIXct("2010-01-02 23:59:59", tz = "UTC")))
  expect_that(ymd_hms("2010,01,02 23.59.59"),
              equals(as.POSIXct("2010-01-02 23:59:59", tz = "UTC")))
  expect_that(ymd_hms("2010,01,02 23.59.59.9"),
              equals(as.POSIXct("2010-01-02 23:59:59.9 UTC", tz = "UTC")))
  expect_that(ymd_hms("2010/01/02 23/59/59"),
              equals(as.POSIXct("2010-01-02 23:59:59", tz = "UTC")))
  expect_that(ymd_hms("2010:01:02-23:59:59"),
              equals(as.POSIXct("2010-01-02 23:59:59", tz = "UTC")))
  ## VS: Next doesn't parse on my machine. It's OS specific.
  ## expect_that(ymd_hms("2010-01-02 23:59:61"), equals(as.POSIXct(
  ##   "2010-01-03 00:00:01", tz = "UTC")))
  ## expect_that(ymd_hms(c("2010-01-02 23:59:61",
  ##   "2010-01-02 00:00:00")), equals(as.POSIXct(
  ##   c("2010-01-03 00:00:01", "2010-01-02 00:00:00"), tz =
  ##   "UTC")))
  expect_that(ymd_hms("10-01-02 23:59:59"),
              equals(as.POSIXct("2010-01-02 23:59:59", tz = "UTC")))
})

test_that("parse_date_time handles multiple month formats correctly", {

  dates <- c("09-01-17", "02-Sep-17")

  expect_equal(parse_date_time(dates, orders = c("dmy"), locale = "C"),
               ymd(c("2017-01-09", "2017-09-02"), tz = "UTC"))

  expect_equal(parse_date_time(dates, orders = c("dby"), locale = "C", quiet = T),
               ymd(c(NA, "2017-09-02"), tz = "UTC"))

  ## mdy & dby
  expect_equal(parse_date_time(dates, orders = c("mdy", "dby")),
               ymd(c("2017-09-01", "2017-09-02"), tz = "UTC"))

  ## mdY & dby/Y
  expect_equal(parse_date_time(c("09-01-2017", "02-Sep-17"), orders = c("mdY", "dby")),
               ymd(c("2017-09-01", "2017-09-02"), tz = "UTC"))

  expect_equal(parse_date_time(c("09-01-2017", "02-Sep-2017"), orders = c("mdY", "dbY")),
               ymd(c("2017-09-01", "2017-09-02"), tz = "UTC"))

  ## mdy/Y & dby/Y, with no mdy/Y in x
  expect_equal(parse_date_time("09-01-17", orders = c("mdy", "dby", "dbY")),
               ymd(c("2017-09-01"), tz = "UTC"))

})

test_that("parse_date_time handles multiple partial month formats correctly", {

  expect_equal(parse_date_time("May-2010", orders="%b-%Y"),
               ymd("2010-05-01", tz = "UTC"))

  expect_equal(parse_date_time(c("02-May-2010", "May-2010", "2010"), orders=c("dbY", "bY", "Y")),
               ymd(c("2010-05-02", "2010-05-01", "2010-01-01"), tz = "UTC"))

  expect_equal(parse_date_time(c("02-May-2010", "May-03-2010", "05-03-2010", "May-2010", "2010"),
                               orders=c("dbY", "bdY", "mdY", "bY", "Y")),
               ymd(c("2010-05-02", "2010-05-03", "2010-05-03", "2010-05-01", "2010-01-01"), tz = "UTC"))

})

test_that("parse_date_time gives higher priority to y than to Y format", {
  expect_equal(parse_date_time(c("apr.12.50","apr.2.2016"), orders = "mdy"),
               ymd(c("2050-04-12 UTC", "2016-04-02 UTC"), tz = "UTC"))
  expect_equal(parse_date_time(c("50.apr.12","2016.apr.2"), orders = "ymd"),
               ymd(c("2050-04-12 UTC", "2016-04-02 UTC"), tz = "UTC"))
})

test_that("C parser correctly handles month formats", {
  expect_equal(ymd_hms("2010-Jan-02 23:59:59"), as.POSIXct("2010-01-02 23:59:59", tz = "UTC"))
  expect_equal(ymd_hms("2010-January-02 23:59:59"), as.POSIXct("2010-01-02 23:59:59", tz = "UTC"))
  expect_equal(ymd_hms("2010-Dec-02 23:59:59"), as.POSIXct("2010-12-02 23:59:59", tz = "UTC"))
  expect_equal(ymd_hms("2010-Dec-02 23:59:59"), parse_date_time2("2010-Dec-02 23:59:59", "YOmdHMS"))
  expect_equal(ymd_hms("2010-Dec-02 23:59:59"), parse_date_time2("2010-Dec-02 23:59:59", "YbdHMS"))
  expect_equal(ymd_hms("2010-Dec-02 03:59:59 PM"), parse_date_time2("2010-Dec-02 15:59:59", "YbdHMS"))
  expect_equal(ymd_hms("2010-Dec-02 03:59:59 PM"), parse_date_time2("2010-Dec-02 03:59:59 PM", "YOmdHMSOp"))
  expect_equal(ymd_hms("2010-Dec-02 23:59:59"), parse_date_time2("2010-December-02 23:59:59", "YBdHMS"))

  yy <- c("10-Feb-28 23:59:59", "10-May-28 23:59:59", "10-September-28 23:59:59")
  zz <- c("2010-Feb-28 23:59:59", "2010-May-28 23:59:59", "2010-September-28 23:59:59")
  tt <- c("2010-02-28 23:59:59", "2010-05-28 23:59:59", "2010-09-28 23:59:59")

  expect_equal(parse_date_time2(yy, "ybdHMS"), as.POSIXct(tt, tz = "UTC"))
  expect_equal(parse_date_time2(zz, "YbdHMS"), as.POSIXct(tt, tz = "UTC"))
  expect_equal(parse_date_time2(yy, "ybdHMS"), as.POSIXct(tt, tz = "UTC"))
  expect_equal(parse_date_time2(yy, "ymdHMS"), as.POSIXct(tt, tz = "UTC"))
  expect_equal(parse_date_time2(zz, "YOmdHMS"), as.POSIXct(tt, tz = "UTC"))
  expect_equal(ymd_hms(c(yy, zz)), as.POSIXct(c(tt, tt), tz = "UTC"))
})


test_that("hms functions correctly handle : separators", {
  expect_that(hms("3:3:3"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(hms("03:03:03"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(ms("03:03"), equals(minutes(3) +
    seconds(3)))
  expect_that(hm("03:03"), equals(hours(3) + minutes(3)))
  expect_that(hm("03:3"), equals(hours(3) + minutes(3)))
})

test_that("hms functions correctly handle . separators", {
  expect_that(hms("3.3.3"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(hms("03.03.03"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(ms("03.03"), equals(minutes(3) +
    seconds(3)))
  expect_that(hm("03.03"), equals(hours(3) + minutes(3)))
  expect_that(hm("03.3"), equals(hours(3) + minutes(3)))
})

test_that("hms functions correctly handle space separators", {
  expect_that(hms("3 3 3"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(hms("03 03 03"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(ms("03 03"), equals(minutes(3) +
    seconds(3)))
  expect_that(hm("03 03"), equals(hours(3) + minutes(3)))
  expect_that(hm("03 3"), equals(hours(3) + minutes(3)))
})

test_that("hms functions correctly handle , separators", {
  expect_that(hms("3,3,3"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(hms("03,03,03"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(ms("03,03"), equals(minutes(3) +
    seconds(3)))
  expect_that(hm("03,03"), equals(hours(3) + minutes(3)))
  expect_that(hm("03,3"), equals(hours(3) + minutes(3)))
})

test_that("hms functions correctly handle / separators", {
  expect_that(hms("3/3/3"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(hms("00/00/00"), equals(hours(0) + minutes(0) +
    seconds(0)))
  expect_that(ms("03/03"), equals(minutes(3) +
    seconds(3)))
  expect_that(hm("03/03"), equals(hours(3) + minutes(3)))
  expect_that(hm("03/3"), equals(hours(3) + minutes(3)))
})


test_that("hms functions correctly roll", {
  expect_equal(hms("3:59:120", roll = T), period(hours = 4, minutes = 1))
  expect_equal(ms("59:125", roll = T), period(hours = 1, minutes = 1, seconds = 5))
  expect_equal(hm("159:125", roll = T), period(hours = 161, minutes = 5))
})

test_that("hms functions return NA on shorter inputs", {
  expect_that(is.na(hms("3:3:3:4", quiet = TRUE)), is_true())
  expect_that(is.na(hms("03:03", quiet = TRUE)), is_true())
  expect_that(is.na(ms("03:02:01", quiet = TRUE)), is_true())
  expect_that(is.na(ms("03", quiet = TRUE)), is_true())
  expect_that(is.na(hm("03:03:01", quiet = TRUE)), is_true())
  expect_that(is.na(hm("03", quiet = TRUE)), is_true())
})

test_that("hms functions give warning on shorter inputs", {
  expect_warning(hms("3:3:3:4"))
  expect_warning(hms("03:03"))
  expect_warning(ms("03:02:01"))
  expect_warning(ms("03"))
  expect_warning(hm("03:03:01"))
  expect_warning(hm("03"))
})

test_that("hms functions correctly negative components separators", {
  expect_that(hms("3-3-3"), equals(hours(3) - minutes(3) - seconds(3)))
  expect_that(hms("03-03-03"), equals(hours(3) - minutes(3) - seconds(3)))
  expect_that(ms("-03-03"), equals(-minutes(3) - seconds(3)))
  expect_that(hm("03-3"), equals(hours(3) -  minutes(3)))
})

test_that("AM/PM indicators are parsed correctly", {
  expect_equal(parse_date_time2("12/17/1996 04:00:00  PM", "mdYHMSp"),
               ymd_hms("1996-12-17 16:00:00"))
  expect_equal(parse_date_time2("12/17/1996 04:00:00  PM", "mdYHMSOp"),
               ymd_hms("1996-12-17 16:00:00"))
  expect_equal(parse_date_time2("12/17/1996 04:00:00  AM", "mdYHMSp"),
               ymd_hms("1996-12-17 04:00:00"))

  expect_equal(parse_date_time2("12/17/1996 04:00:00  PM", "mdYHMSp", tz = "CET"),
               ymd_hms("1996-12-17 16:00:00", tz = "CET"))

  expect_equal(parse_date_time2("12/17/1996 04:00:00  TM", "mdYHMSp"),
               make_datetime(NA))
  expect_equal(fast_strptime("1996-05-17 04:00:00 PM", "%Y-%m-%d %H:%M:%S %Op"),
               ymd_hms("1996-05-17 16:00:00"))
  expect_equal(ymd_hms("1996-05-17 04:00:00 PM"), ymd_hms("1996-05-17 16:00:00"))
  expect_equal(ydm_hms("1996-17-05 04:00:00 PM"), ydm_hms("1996-17-05 16:00:00"))
  expect_equal(dmy_hms("17-05-1996 04:00:00 PM"), dmy_hms("17-05-1996 16:00:00"))


  expect_equal(parse_date_time("2010-Dec-02 03:59:59 PM", "YmdT"),
               parse_date_time2("2010-12-02 15:59:59", "YmdHMS"))

  expect_equal(parse_date_time("2010-Dec-02 03:59:59 PM", "YmdT"),
               parse_date_time2("2010-12-02 15:59:59", "YmdHMS"))

  expect_equal(parse_date_time("2010-Dec-02 03:59 PM", "YmdR"),
               parse_date_time2("2010-12-02 15:59:00", "YmdHMS"))

  expect_equal(parse_date_time("2010-Dec-02 03 PM", "Ymdr"),
               parse_date_time2("2010-12-02 15:00:00", "YmdHMS"))

})

test_that("AM/PM is parse correctly", {

  raw <- c("09/17/2015 02:55:00 PM", "09/17/2015 04:22:00 PM", "09/17/2015 11:01:00 AM",
           "09/17/2015 08:11:00 PM", "09/17/2015 03:00:00 PM", "09/17/2015 12:43:00 AM",
           "09/17/2015 12:09:00 PM", "09/17/2015 04:57:00 PM", "09/17/2015 12:25:00 PM",
           "09/17/2015 06:52:00 AM", "09/17/2015 11:08:00 AM", "09/17/2015 10:25:00 AM",
           "09/17/2015 02:39:00 PM", "09/17/2015 10:28:00 AM", "09/17/2015 06:39:00 AM",
           "09/17/2015 09:41:00 AM", "09/17/2015 09:12:00 AM", "09/17/2015 12:40:00 AM",
           "09/17/2015 11:53:08 AM", "09/17/2015 04:40:30 PM", "09/17/2015 04:19:44 PM",
           "09/17/2015 08:26:00 AM", "09/17/2015 02:32:17 PM", "09/17/2015 06:09:00 PM",
           "09/17/2015 10:27:00 AM", "09/17/2015 12:59:00 PM", "09/17/2015 09:20:00 AM",
           "09/17/2015 07:25:00 AM", "09/17/2015 05:49:04 AM", "09/17/2015 04:58:18 PM",
           "09/17/2015 11:35:00 AM", "09/17/2015 10:21:48 AM", "09/17/2015 09:48:41 AM",
           "09/17/2015 01:11:00 PM", "09/17/2015 08:52:00 AM", "09/17/2015 05:49:00 AM",
           "09/17/2015 06:19:00 PM", "09/17/2015 10:17:19 AM", "09/17/2015 01:59:00 PM",
           "09/17/2015 11:08:00 AM", "09/17/2015 03:37:59 AM", "09/16/2015 07:00:00 AM",
           "09/17/2015 02:26:00 PM", "09/17/2015 10:58:00 AM", "09/17/2015 05:56:00 AM",
           "09/17/2015 05:01:00 PM", "09/17/2015 10:15:00 AM", "09/17/2015 10:02:00 AM",
           "09/17/2015 10:10:00 PM", "09/17/2015 12:56:00 PM", "09/17/2015 03:58:00 PM",
           "09/17/2015 05:23:00 PM", "09/17/2015 12:20:00 PM", "09/17/2015 07:48:00 PM",
           "09/17/2015 02:54:00 PM", "09/17/2015 10:02:00 PM", "09/17/2015 11:53:21 AM",
           "09/17/2015 10:15:59 AM", "09/17/2015 08:22:00 AM", "09/17/2015 04:33:00 PM",
           "09/17/2015 08:26:00 PM", "09/17/2015 08:01:00 AM", "09/17/2015 12:28:00 PM",
           "09/17/2015 11:07:00 PM", "09/17/2015 11:09:00 PM", "09/17/2015 03:08:32 PM",
           "09/17/2015 08:25:00 PM", "09/17/2015 01:45:00 PM", "09/17/2015 08:42:00 AM",
           "09/17/2015 03:25:00 PM", "09/17/2015 09:32:00 AM", "09/17/2015 10:13:13 AM",
           "09/17/2015 11:36:02 AM", "09/17/2015 03:23:00 PM", "09/17/2015 12:00:00 AM",
           "09/17/2015 07:19:19 PM", "09/17/2015 08:59:06 AM", "09/17/2015 09:14:00 PM",
           "09/17/2015 01:16:00 PM", "09/17/2015 08:54:35 AM", "09/17/2015 05:56:29 PM",
           "09/17/2015 03:56:51 PM", "09/17/2015 09:52:22 AM", "09/17/2015 03:49:28 PM",
           "09/17/2015 01:00:27 PM", "09/17/2015 09:52:32 PM", "09/17/2015 11:08:15 AM",
           "09/17/2015 05:26:26 PM", "09/17/2015 04:53:56 PM", "09/02/2015 10:33:00 AM",
           "09/17/2015 10:13:22 AM", "09/17/2015 12:50:00 PM", "09/17/2015 12:46:00 PM",
           "09/02/2015 06:44:00 PM", "09/17/2015 02:21:06 PM", "09/17/2015 01:56:00 PM",
           "09/17/2015 02:10:00 PM", "09/17/2015 05:43:28 AM", "09/17/2015 11:24:00 AM",
           "09/17/2015 10:56:00 AM")

  ## dput(as.character(parse_date_time2(raw, "mdYHMSp")))
  utc <- c("2015-09-17 14:55:00", "2015-09-17 16:22:00", "2015-09-17 11:01:00",
           "2015-09-17 20:11:00", "2015-09-17 15:00:00", "2015-09-17 00:43:00",
           "2015-09-17 12:09:00", "2015-09-17 16:57:00", "2015-09-17 12:25:00",
           "2015-09-17 06:52:00", "2015-09-17 11:08:00", "2015-09-17 10:25:00",
           "2015-09-17 14:39:00", "2015-09-17 10:28:00", "2015-09-17 06:39:00",
           "2015-09-17 09:41:00", "2015-09-17 09:12:00", "2015-09-17 00:40:00",
           "2015-09-17 11:53:08", "2015-09-17 16:40:30", "2015-09-17 16:19:44",
           "2015-09-17 08:26:00", "2015-09-17 14:32:17", "2015-09-17 18:09:00",
           "2015-09-17 10:27:00", "2015-09-17 12:59:00", "2015-09-17 09:20:00",
           "2015-09-17 07:25:00", "2015-09-17 05:49:04", "2015-09-17 16:58:18",
           "2015-09-17 11:35:00", "2015-09-17 10:21:48", "2015-09-17 09:48:41",
           "2015-09-17 13:11:00", "2015-09-17 08:52:00", "2015-09-17 05:49:00",
           "2015-09-17 18:19:00", "2015-09-17 10:17:19", "2015-09-17 13:59:00",
           "2015-09-17 11:08:00", "2015-09-17 03:37:59", "2015-09-16 07:00:00",
           "2015-09-17 14:26:00", "2015-09-17 10:58:00", "2015-09-17 05:56:00",
           "2015-09-17 17:01:00", "2015-09-17 10:15:00", "2015-09-17 10:02:00",
           "2015-09-17 22:10:00", "2015-09-17 12:56:00", "2015-09-17 15:58:00",
           "2015-09-17 17:23:00", "2015-09-17 12:20:00", "2015-09-17 19:48:00",
           "2015-09-17 14:54:00", "2015-09-17 22:02:00", "2015-09-17 11:53:21",
           "2015-09-17 10:15:59", "2015-09-17 08:22:00", "2015-09-17 16:33:00",
           "2015-09-17 20:26:00", "2015-09-17 08:01:00", "2015-09-17 12:28:00",
           "2015-09-17 23:07:00", "2015-09-17 23:09:00", "2015-09-17 15:08:32",
           "2015-09-17 20:25:00", "2015-09-17 13:45:00", "2015-09-17 08:42:00",
           "2015-09-17 15:25:00", "2015-09-17 09:32:00", "2015-09-17 10:13:13",
           "2015-09-17 11:36:02", "2015-09-17 15:23:00", "2015-09-17 00:00:00",
           "2015-09-17 19:19:19", "2015-09-17 08:59:06", "2015-09-17 21:14:00",
           "2015-09-17 13:16:00", "2015-09-17 08:54:35", "2015-09-17 17:56:29",
           "2015-09-17 15:56:51", "2015-09-17 09:52:22", "2015-09-17 15:49:28",
           "2015-09-17 13:00:27", "2015-09-17 21:52:32", "2015-09-17 11:08:15",
           "2015-09-17 17:26:26", "2015-09-17 16:53:56", "2015-09-02 10:33:00",
           "2015-09-17 10:13:22", "2015-09-17 12:50:00", "2015-09-17 12:46:00",
           "2015-09-02 18:44:00", "2015-09-17 14:21:06", "2015-09-17 13:56:00",
           "2015-09-17 14:10:00", "2015-09-17 05:43:28", "2015-09-17 11:24:00",
           "2015-09-17 10:56:00")

  tparse <- as.POSIXct(utc, tz = "UTC")
  ## DT(raw, tparse, R = parse_date_time(raw, "mdYT", locale = "C"))[, diff := R - tparse][diff != 0] %>% DF

  expect_equal(mdy_hms(raw), tparse)
  expect_equal(parse_date_time2(raw, "mdYHMSp"), tparse)
  expect_equal(parse_date_time2(raw, "mdYHMSp"), tparse)
  expect_equal(parse_date_time2(raw, "OmdYHMSOp"), tparse)
  ## this one ends in strptime
  expect_equal(parse_date_time(raw, "mdYT", locale = "C"), tparse)
})

test_that("heterogeneous formats are correctly parsed", {
  X <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4", "2009-1, 5", "2009....1--6", "200901-07", "200901-8")
  Y <- c("2009-01-01", "2009-01-02", "2009-01-03", "2009-01-04", "2009-01-05", "2009-01-06", "2009-01-07", "2009-01-08")
  expect_that(ymd(X), equals(as.Date(Y)))

  ## cbind(ymd(X), as.POSIXct(Y, tz = "UTC"))
  X <- c(20100101120101, "2009-01-02 12-01-02", "2009.01.03 12:01:03",
         "2009-1-4 12-1-4", "2009-1, 5 12:1, 5", "2009....1--6 - 12::1:6",
         "20090107 120107", "2009-01-08 1201-08", "2010-01-09 12:01:09",
         "2010-01-10 10:01:10 AM", "2010-01-11 10:01:11 PM")

  Y <- c("2010-01-01 12:01:01", "2009-01-02 12:01:02", "2009-01-03 12:01:03",
         "2009-01-04 12:01:04", "2009-01-05 12:01:05", "2009-01-06 12:01:06",
         "2009-01-07 12:01:07", "2009-01-08 12:01:08", "2010-01-09 12:01:09",
         "2010-01-10 10:01:10", "2010-01-11 22:01:11")

  ## cbind(as.character(ymd_hms(X)), as.character(as.POSIXct(Y, tz = "UTC")))
  expect_that(ymd_hms(X), equals(as.POSIXct(Y, tz = "UTC")))
})

test_that("truncated formats are correctly parsed", {
  x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")

  expect_that({
    ymd_hms(x, truncated = 3)
  }, equals(as.POSIXct(c("2011-12-31 12:59:59", "2010-01-01 12:11:00", "2010-01-01 12:00:00",
                         "2010-01-01 00:00:00"), tz = "UTC")))

  x <- c("2011-12-31 12", "2010-01-01 12", "2010-01-01 12")
  expect_equal(ymd_h(x),
               as.POSIXct(c("2011-12-31 12:00:00 UTC", "2010-01-01 12:00:00 UTC", "2010-01-01 12:00:00 UTC"),
                          tz = "UTC"))

  x <- c("2011-12-31 12:01", "2010-01-01 12:02", "2010-01-01 12:03")
  expect_equal(ymd_hm(x),
               as.POSIXct(c("2011-12-31 12:01:00 UTC", "2010-01-01 12:02:00 UTC", "2010-01-01 12:03:00 UTC"),
                          tz = "UTC"))


  expect_equal(dmy_h("05-07-2011 13"), ymd_hms("2011-07-05 13:00:00"))
  expect_equal(ymd_h("2011-07-05 13"), ymd_hms("2011-07-05 13:00:00"))
  expect_equal(dmy_hm("05-07-2011 13:02"), ymd_hms("2011-07-05 13:02:00"))
  expect_equal(ymd_hm("2011-07-05 13:02"), ymd_hms("2011-07-05 13:02:00"))
})

test_that("truncation on non-dates results in NAs indeed", {
  expect_warning(
      expect_true({
        tt <- c("NI PODATKA", "TUJINA", "GRAD")
        all(is.na(ymd_hms(tt, truncated = 3)))
      }))
})

test_that("missing months and days are allowed", {
  expect_equal(parse_date_time2("2016", orders = "Y"), ymd("2016-01-01", tz = "UTC"))
  expect_equal(parse_date_time2("2016-02", orders = "Ym"), ymd("2016-02-01", tz = "UTC"))
  expect_equal(parse_date_time("2016", orders = "Y"), ymd("2016-01-01", tz = "UTC"))
  expect_equal(parse_date_time("2016-02", orders = "Ym"), ymd("2016-02-01", tz = "UTC"))
  expect_equal(parse_date_time(c("3:15:00"), c("IMS")), as.POSIXct("00-01-01 03:15:00", tz = "UTC"))
  expect_equal(parse_date_time(c("3:15:00"), c("HMS")), as.POSIXct("00-01-01 03:15:00", tz = "UTC"))
  expect_equal(parse_date_time(c("3:15:00 PM"), c("HMSp")), as.POSIXct("00-01-01 15:15:00", tz = "UTC"))
  expect_equal(parse_date_time(c("3:15:00 PM"), c("IMSp")), as.POSIXct("00-01-01 15:15:00", tz = "UTC"))
})

test_that("fractional formats are correctly parsed", {
  expect_that({
    x <- c("2011-12-31 12:59:59.23", "2010-01-01 12:11:10")
    ymd_hms(x)
  }, equals(as.POSIXct(c("2011-12-31 12:59:59.23 UTC", "2010-01-01 12:11:10.00 UTC"), tz = "UTC")))
  expect_that(hms("3:0:3.34"), equals(hours(3) + minutes(0) + seconds(3.34)))
})

test_that("NA's are parsed as NA's", {
  expect_silent(ymd(NA, "2001-01-01"))
  expect_warning(ymd(NA, "2001-01-01 01"))
  expect_true(is.na(ymd(NA, quiet = TRUE)))
  expect_silent(ymd_hms(NA))
  expect_true(is.na(ymd_hms(NA, quiet = TRUE)))
  expect_silent(ymd_hm(NA, "01-01-01 0:0"))
  expect_warning(ymd_hm(NA, "01-01-01 0"))
  expect_true(is.na(ymd_hm(NA, quiet = TRUE)))
  expect_warning(hms(NA))
  expect_true(is.na(hms(NA, quiet = TRUE)))
  expect_warning(ms(NA))
  expect_true(is.na(ms(NA, quiet = TRUE)))
})

test_that("Quarters are parsed correctly", {
  qs <- c("2016.1", "2016:2", "2016-3", "2016 4", "2016.5")
  out <- ymd(c("2016-01-01 UTC", "2016-04-01 UTC", "2016-07-01 UTC", "2016-10-01 UTC", NA), tz = "UTC")
  expect_equal(parse_date_time2(qs, orders = "Yq"), out)
  expect_equal(parse_date_time(qs, orders = "Yq", quiet = T), out)
  expect_equal(yq(qs, tz = "UTC", quiet = T), out)
  expect_equal(yq("16.1", "17.3", "2016.1"), ymd(c("2016-01-01", "2017-07-01", "2016-01-01")))
})

test_that("Vectors of NA's are parsed as vectors of NA's", {
  mna <- as.POSIXct(as.POSIXlt(c(NA, NA, NA), tz = "UTC"))
  pna <- new("Period"
             , .Data = c(NA_real_, NA_real_, NA_real_)
             , year = c(0, 0, 0)
             , month = c(0, 0, 0)
             , day = c(0, 0, 0)
             , hour = c(NA_real_, NA_real_, NA_real_)
             , minute = c(NA_real_, NA_real_, NA_real_)
  )
  pna2 <- new("Period"
              , .Data = c(NA_real_, NA_real_, NA_real_)
              , year = c(0, 0, 0)
              , month = c(0, 0, 0)
              , day = c(0, 0, 0)
              , hour = c(0, 0, 0)
              , minute = c(NA_real_, NA_real_, NA_real_)
  )
  expect_silent(ymd(NA, NA, NA))
  expect_equal(ymd(NA, NA, NA, quiet = TRUE), as.Date(mna))
  expect_silent(ymd_hms(NA, NA, NA))
  expect_equal(ymd_hms(NA, NA, NA, quiet = TRUE), mna)
  expect_silent(ymd_hm(NA, NA, NA))
  expect_equal(ymd_hm(NA, NA, NA, quiet = TRUE), mna)
  expect_warning(hms(NA, NA, NA))
  expect_equal(hms(NA, NA, NA, quiet = TRUE), pna)
  expect_warning(ms(NA, NA, NA))
  expect_equal(ms(NA, NA, NA, quiet = TRUE), pna2)
  expect_silent(ymd(c(NA, NA, NA)))
  expect_equal(ymd(c(NA, NA, NA), quiet = TRUE), as.Date(mna))
  expect_silent(ymd_hms(c(NA, NA, NA)))
  expect_equal(ymd_hms(c(NA, NA, NA), quiet = TRUE), mna)
  expect_silent(ymd_hm(c(NA, NA, NA)))
  expect_equal(ymd_hm(c(NA, NA, NA), quiet = TRUE), mna)
  expect_warning(hms(c(NA, NA, NA)))
  expect_equal(hms(c(NA, NA, NA), quiet = TRUE), pna)
  expect_warning(ms(c(NA, NA, NA)))
  expect_equal(ms(c(NA, NA, NA), quiet = TRUE), pna2)
})

test_that("ISO8601: %z format (aka lubridate %Ou, %OO and %Oo formats) is correctly parsed", {
  expect_that(
    parse_date_time("2012-12-04 15:06:06.95-0800", "YmdHMOSz"),
    equals(as.POSIXct("2012-12-04 23:06:06.95 UTC", tz = "UTC")))
  expect_that(
    parse_date_time(c("2012-12-04 15:06:06.95-08", "2012-12-04 15:06:06.95+08:00"), "YmdHMOSz"),
    equals(as.POSIXct(c("2012-12-04 23:06:06.95 UTC", "2012-12-04 07:06:06.95 UTC"), tz = "UTC")))
  expect_that(
    fast_strptime("2014-03-12T09:32:44Z", "%Y-%m-%dT%H:%M:%S%z"),
    equals(as.POSIXct("2014-03-12 09:32:44 UTC", tz = "UTC")))
  expect_that(
    fast_strptime("2014-03-12T09:32:44.33Z", "%Y-%m-%dT%H:%M:%OS%z"),
    equals(as.POSIXct("2014-03-12 09:32:44.33 UTC", tz = "UTC")))
})

test_that("ISO8601: xxx_hms functions work correctly with z, Ou, OO and Oo formats.", {
  expect_that(
    ymd_hms(c("2013-01-24 19:39:07.880-0600",
              "2013-01-24 19:39:07.880", "2013-01-24 19:39:07.880-06:00",
              "2013-01-24 19:39:07.880-06", "2013-01-24 19:39:07.880Z")),
    equals(as.POSIXct(c("2013-01-25 01:39:07.88 UTC",
                        "2013-01-24 19:39:07.88 UTC", "2013-01-25 01:39:07.88 UTC",
                        "2013-01-25 01:39:07.88 UTC", "2013-01-24 19:39:07.88 UTC"), tz = "UTC")))
})

test_that("ymd_hms treats time zones correctly", {
  expect_that(ymd_hms("2012-03-03 23:06:07", tz = "America/Chicago"),
              equals(as.POSIXct("2012-03-03 23:06:07", tz = "America/Chicago")))
})

test_that("ymd_hms parses Ou format correctly ", {
  ## Correct usage
  expect_that(ymd_hms("2012-03-04T05:06:07Z"),
              equals(ymd_hms("2012-03-04 05:06:07", tz = "UTC")))
  expect_that(ymd_hms("2012-03-04T05:06:07Z", tz = "America/Chicago"),
              equals(ymd_hms("2012-03-03 23:06:07", tz = "America/Chicago")))

  ## check for message
  expect_that(ymd_hms("2012-03-04T05:06:07Z", tz = "America/Chicago"),
              shows_message("Date in ISO8601 format"))
})

test_that("ymd_hms parses OO and Oo formats correctly", {
  ## +00:00
  expect_that(ymd_hms("2012-03-04T05:06:07+00:00"),
              equals(ymd_hms("2012-03-04 05:06:07", tz = "UTC")))
  ## -HH
  expect_that(ymd_hms("2012-03-04T05:06:07-01"),
              equals(ymd_hms("2012-03-04 06:06:07", tz = "UTC")))
  ## -HHMM
  expect_that(ymd_hms("2012-03-04T05:06:07-0130"),
              equals(ymd_hms("2012-03-04 06:36:07", tz = "UTC")))
  ## -HH:MM
  expect_that(ymd_hms("2012-03-04T05:06:07-01:30"),
              equals(ymd_hms("2012-03-04 06:36:07", tz = "UTC")))
  ## +HH
  expect_that(ymd_hms("2012-03-04T05:06:07+01"),
              equals(ymd_hms("2012-03-04 04:06:07", tz = "UTC")))
  ## +HHMM
  expect_that(ymd_hms("2012-03-04T05:06:07+0130"),
              equals(ymd_hms("2012-03-04 03:36:07", tz = "UTC")))
  ## +HH:MM
  expect_that(ymd_hms("2012-03-04T05:06:07+01:30"),
              equals(ymd_hms("2012-03-04 03:36:07", tz = "UTC")))
  ## vectorizes
  expect_that(ymd_hms(c("2012-03-04T05:06:07+01", "2012-03-04T05:06:07+01:30")),
              equals(ymd_hms(c("2012-03-04 04:06:07", "2012-03-04 03:36:07"), tz = "UTC")))
  expect_that(ymd_hms("2012-03-04T05:06:07-01:30", tz = "America/Chicago", quiet = T),
              equals(ymd_hms("2012-03-04 00:36:07", tz = "America/Chicago")))
  expect_that(ymd_hms("2012-03-04T05:06:07-01:30", tz = "America/Chicago"),
              shows_message("Date in ISO8601 format"))
})

test_that("ymd parses mixed y an Y formats", {
  ## https://github.com/hadley/lubridate/issues/425
  d3 <- c("6/25/15", "6/25/2015")
  expect_equal(mdy(d3), as.Date(c("2015-06-25", "2015-06-25")))
  d6 <- c("25/6/15", "25/6/2015")
  expect_equal(dmy(d6), as.Date(c("2015-06-25", "2015-06-25")))
  d9 <- c("15/6/25", "2015/6/25")
  expect_equal(ymd(d9), as.Date(c("2015-06-25", "2015-06-25")))
})

test_that("ymd_hms parses mixed ISO-8601/non-ISO-8601 formats", {
  expect_that(ymd_hms(c("2012-03-04T05:06:07Z", "2001-02-03 04:05:06"),
                      tz = "America/Chicago"),
              equals(ymd_hms(c("2012-03-03 23:06:07", "2001-02-03 04:05:06"),
                             tz = "America/Chicago")))
})

test_that("parse_date_time2 and fast_strptime parse ISO8601 timezones", {
    tm <- "2001-02-03 11:22:33-0630"
    ptm <- as.POSIXct("2001-02-03 17:52:33", tz = "UTC")
    expect_equal(fast_strptime(tm, "%Y-%m-%d %H:%M:%S%Oz"), ptm)
    expect_equal(fast_strptime(tm, "%Y-%m-%d %H:%M:%S%z"), ptm)
    expect_equal(fast_strptime(tm, "%Y-%m-%d %H:%M:%OS%Oz"), ptm)
    expect_equal(fast_strptime(tm, "%Y-%m-%d %H:%M:%OS%z"), ptm)
    expect_equal(parse_date_time2(tm, "YmdHMSz"), ptm)
    expect_equal(parse_date_time2(tm, "YmdHMSOz"), ptm)
    expect_equal(parse_date_time2(tm, "YmdHMOSz"), ptm)
    expect_equal(parse_date_time2(tm, "YmdHMOSOz"), ptm)
    tm <- "2001-02-03 11:22:33-06:30"
    expect_equal(fast_strptime(tm, "%Y-%m-%d %H:%M:%OS%OO"), ptm)
    expect_equal(fast_strptime(tm, "%Y-%m-%d %H:%M:%OS%z"), ptm)
    expect_equal(parse_date_time2(tm, "YmdHMSz"), ptm)
    expect_equal(parse_date_time2(tm, "YmdHMSOO"), ptm)
})

test_that("parse_date_time2 and fast_strptime correctly work with timezones", {
  ## https://github.com/hadley/lubridate/issues/394
  expect_equal(parse_date_time("12/03/16 12:00",  "dmy HM", tz = "Europe/Zurich"),
               parse_date_time2("12/03/16 12:00",  "dmy HM", tz = "Europe/Zurich"))
  expect_equal(as.POSIXct(strptime("12/03/16 12:00",  "%d/%m/%y %H:%M", tz = "Europe/Zurich")),
               parse_date_time2("12/03/16 12:00",  "dmy HM", tz = "Europe/Zurich"))
  expect_equal(strptime("12/03/16 12:00",  "%d/%m/%y %H:%M", tz = "Europe/Zurich"),
               fast_strptime("12/03/16 12:00",  "%d/%m/%y %H:%M", tz = "Europe/Zurich"))
  expect_equal(strptime("12/03/16 12:00",  "%d/%m/%y %H:%M", tz = "America/New_York"),
               fast_strptime("12/03/16 12:00",  "%d/%m/%y %H:%M", tz = "America/New_York"))
})

test_that("parse_date_time2 and fast_strptime correctly return lt objects", {
  expect_is(parse_date_time2("12/03/16 12:00",  "dmy HM"), "POSIXct")
  expect_is(parse_date_time2("12/03/16 12:00",  "dmy HM", lt = TRUE), "POSIXlt")
  expect_is(fast_strptime("12/03/16 12:00",  "%d/%m/%y %H:%M"), "POSIXlt")
  expect_is(fast_strptime("12/03/16 12:00",  "%d/%m/%y %H:%M", lt = FALSE), "POSIXct")
})

test_that("ymd_hms, parse_date_time2, fast_strptime and base:strptime give the same result", {
  ## random times between 1400 and 3000
  set.seed(1000)
  X <- as.character(.POSIXct(runif(1000, -17987443200, 32503680000)))
  oposix <- as.POSIXct(X, tz = "UTC")
  opdt1 <- ymd_hms(X)
  opdt2 <- parse_date_time2(X, "YmdHMOS")
  ofstrptime <- fast_strptime(X, "%Y-%m-%d %H:%M:%OS")
  expect_equal(oposix, opdt1)
  expect_equal(oposix, opdt2)
  expect_equal(oposix, ofstrptime)
  tzs <- strptime(X, "%Y-%m-%d %H:%M:%OS", tz = "America/New_York")
  tzfs <- fast_strptime(X, "%Y-%m-%d %H:%M:%OS", tz = "America/New_York")
  expect_equal(tzs, tzfs)
})

test_that("fast_strptime and parse_date_time2 parse correctly verbose formats", {
  expect_equal(fast_strptime("aa 2000 bbb10ccc 12 zzz", "aa %Y bbb%mccc %d zzz"),
               as.POSIXct("2000-10-12", tz = "UTC"))
  expect_equal(fast_strptime("aa 2000 5555 bbb10ccc 12 zzz", "aa %Y 5555 bbb%mccc %d zzz"),
               as.POSIXct("2000-10-12", tz = "UTC"))
  expect_equal(parse_date_time2("aa 2000 bbb10ccc 12 zzz", "Ymd"),
               as.POSIXct("2000-10-12", tz = "UTC"))
  expect_equal(parse_date_time2("aa 2000 5555 bbb10ccc 12 zzz", "Ymd"),
               as.POSIXct(as.POSIXlt(NA, tz = "UTC")))
})

test_that("fast_strptime and parse_date_time2 deal correctly with leap years", {
  expect_equal(ymd(c("2000-02-29", "2100-02-29", "2400-02-29"), quiet = T),
               as.Date(c("2000-02-29 UTC", NA, "2400-02-29 UTC")))
})

test_that("fast_strptime and parse_date_time2 detect excesive days", {
  ## https://github.com/hadley/lubridate/issues/#289
  expect_equal(ymd(c("2000-01-32", "2000-02-30", "2100-03-32", "2400-12-32"), quiet = T),
               as.Date(c(NA, NA, NA, NA)), tz = "UTC")
})

test_that("fast_strptime and parse_date_time2 aggree with strptime", {
  date <- "1 7 97"
  expect_equal(fast_strptime(date, "%d %m %y"),
               strptime(date, "%d %m %y", tz = "UTC"))
  date <- "1 1 69"
  expect_equal(fast_strptime(date, "%d %m %y"),
               strptime(date, "%d %m %y", tz = "UTC"))
  date <- "1 1 68"
  expect_equal(fast_strptime(date, "%d %m %y"),
               strptime(date, "%d %m %y", tz = "UTC"))
  expect_equal(parse_date_time2(date, "dmy"),
               strptime(date, "%d %m %y", tz = "UTC"))
})

test_that("a and A formats are handled correctly (#254)", {
  dates <- c("Saturday 31 August 2013", "Sun 12 Jan 2014")
  expect_equal(parse_date_time(x = dates, orders = c("dby")),
               parse_date_time(x = dates, orders = c("adby")))
  expect_equal(parse_date_time(x = dates, orders = c("dby")),
               parse_date_time(x = dates, orders = c("Adby")))
})

test_that("`parse_date_time` parses heterogeneous formats with `exact=TRUE`", {
  ## https://github.com/hadley/lubridate/issues/326
  expect_equal(parse_date_time(c("12/17/1996 04:00:00", "4/18/1950 0130"),
                               c("%m/%d/%Y %I:%M:%S", "%m/%d/%Y %H%M"),
                               exact = T),
               as.POSIXct(c("1996-12-17 04:00:00 UTC", "1950-04-18 01:30:00 UTC"), tz = "UTC"))
  x <- c("09-01-01", "090102", "09-01 03", "09-01-03 12:02")
  expect_equal(parse_date_time(x, c("%m-%d-%y", "%m%d%y", "%m-%d-%y %H:%M"), exact = TRUE, quiet = T),
               as.POSIXct(c("2001-09-01 00:00:00 UTC", "2002-09-01 00:00:00 UTC",
                            NA,  "2003-09-01 12:02:00 UTC"),
                          tz = "UTC"))
})

test_that("parser ignores case", {
  ref <- ymd_hms("2016-01-04 07:40:00", "2016-01-04 07:40:00", "2016-01-04 07:40:00 UTC")
  dts <- c("04jan2016:07:40:00", "04JAN2016:07:40:00", "04Jan2016:07:40:00")
  expect_equal(ref, parse_date_time2(dts, "dBYHMS"))
  expect_equal(ref, dmy_hms(dts))
})

## library(microbenchmark)
## library(lubridate)

### PARSING
## options(digits.secs = 3)
## set.seed(100)
## tt <- as.character(.POSIXct(runif(1e6, -17987443200, 32503680000))) # random times between 1400 and 3000

## microbenchmark(#POSIXct = as.POSIXct(tt, tz = "UTC"),
##                ymd_hms =  ymd_hms(tt),
##                pdt2 = parse_date_time2(tt, "YmdHMOS"),
##                fstrptime = fast_strptime(tt, "%Y-%m-%d %H:%M:%OS", lt = FALSE),
##                readr = parse_datetime(tt, "%Y-%m-%d %H:%M:%OS"),
##                times = 10)

### MAKE DATETIMES
## N <- 1e4
## y <- as.integer(runif(N, 1800, 2200))
## m <- as.integer(runif(N, 1, 12))
## d <- as.integer(runif(N, 1, 28))
## H <- as.integer(runif(N, 0, 23))
## M <- as.integer(runif(N, 0, 59))
## S <- as.double(runif(N, 0, 59))
## ## S <- as.integer(S)

## microbenchmark(R = ISOdatetime(y, m, d, H, M, S, tz = "UTC"),
##                L = make_datetime(y, m, d, H, M, S))

## system.time(out1 <- ISOdatetime(y, m, d, H, M, S, tz = "UTC"))
## system.time(out2 <- make_datetime(y, m, d, H, M, S))
## all.equal(out1, out2)

## table(out1 == out2)
## tt <- cbind(y, m, d, H, M, S, as.character(out1), as.character(out2), out1 == out2)
## tt <- cbind(y, m, d, H, M, S, out1, out2, out1 - out2, out1 == out2)
## head(tt, 40)

## cbind(out1, out2)[which(out1 != out2), ]

## all.equal(out, out1)
## all.equal(out, out2)
## all.equal(out, out3)

## this one is very slow
## system.time(out <- ymd_hms(tt, tz = "America/Chicago"))

## ttz <- paste(tt, "-0600", sep = "")
## system.time(out <- parse_date_time(ttz, "YmdHMOSz"))
## system.time(out <- ymd_hms(ttz))
## head(ttz)
## head(out)
## system.time(out2 <- parse_date_time2(ttz, "YmdHMOSz"))
## system.time(out2 <- parse_date_time2(ttz, "YmdHMOSOz"))
## system.time(out3 <- fast_strptime(ttz, "%Y-%m-%d %H:%M:%OS%z"))
## all.equal(out, out2)
## all.equal(out, out3)

## fast_strptime(tm, "%Y-%m-%d %H:%M:%S%z")

## fast_strptime("2893-04-08 22:54:37+0635", "%Y-%m-%d %H:%M:%S%Oz")


## system.time(out <- ymd_hms(ttz, tz = ""))

## stamp_OO <- stamp("2013-01-01T00:00:00-06:00")
## stamp_Ou <- stamp("2013-01-01T06:00:00Z")
## stamp_Oo <- stamp("2013-01-01T00:00:00-06")
## stamp_Oz <- stamp("2013-01-01T00:00:00-0600")
## stamp_OO <- stamp("2013-01-01T00:00:00-06:00")

## stamp_simple <- stamp("2013-01-01T00:00:00")

## system.time(out_st <- stamp_simple(out))
## system.time(out_st <- stamp_Ou(out))
## system.time(out_st <- stamp_OO(out))
## system.time(out_st <- stamp_OO(out))
## system.time(out_st <- stamp_Oz(out))


## tt <- rep(c(as.character(Sys.time()), as.character(Sys.Date())), 5e5)
## system.time(out <- as.POSIXct(tt, tz = "UTC"))
## system.time(out <- ymd_hms(tt, tz = "UTC", truncated = 3))

## Rprof()
## system.time(out <- as.POSIXct(strptime(tt, "%Y-%m-%d %H:%M:%S", tz = "UTC")))
## Rprof(NULL)

## Rprof()
## system.time(out <- ymd_hms(tt))
## Rprof(NULL)
## summaryRprof()
