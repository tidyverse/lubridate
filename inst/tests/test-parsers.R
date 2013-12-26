context("Parsing")

test_that("ymd functions correctly parse dates separated by -", {
  expect_that(ymd("2010-01-02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd("10-01-02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ydm("2010-02-01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(mdy("01-02-2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(myd("01-2010-02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dmy("02-01-2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dym("02-2010-01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd(c("2010-01-02","2010-01-03")) ,
    equals(as.POSIXct(c("2010-01-02","2010-01-03"), tz =
    "UTC")))
})

test_that("ymd functions correctly parse dates separated by /", {
  expect_that(ymd("2010/01/02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd("10/01/02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ydm("2010/02/01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(mdy("01/02/2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(myd("01/2010/02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dmy("02/01/2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dym("02/2010/01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd(c("2010/01/02","2010/01/03")) ,
    equals(as.POSIXct(c("2010-01-02","2010-01-03"), tz =
    "UTC")))
})


test_that("ymd functions correctly parse dates separated by .", {
  expect_that(ymd("2010.01.02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd("10.01.02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ydm("2010.02.01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(mdy("01.02.2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(myd("01.2010.02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dmy("02.01.2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dym("02.2010.01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd(c("2010.01.02","2010.01.03")) ,
    equals(as.POSIXct(c("2010-01-02","2010-01-03"), tz =
    "UTC")))
})

test_that("ymd functions correctly parse dates separated by ,", {
  expect_that(ymd("2010,01,02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd("10,01,02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ydm("2010,02,01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(mdy("01,02,2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(myd("01,2010,02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dmy("02,01,2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dym("02,2010,01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd(c("2010,01,02","2010,01,03")) ,
    equals(as.POSIXct(c("2010-01-02","2010-01-03"), tz =
    "UTC")))
})

test_that("ymd functions correctly parse dates separated by :", {
  expect_that(ymd("2010:01:02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd("10:01:02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ydm("2010:02:01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(mdy("01:02:2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(myd("01:2010:02"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dmy("02:01:2010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dym("02:2010:01"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd(c("2010:01:02","2010:01:03")) ,
    equals(as.POSIXct(c("2010-01-02","2010-01-03"), tz =
    "UTC")))
})

test_that("ymd functions correctly parse dates with no separators", {
  expect_that(ymd("20100102"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ydm("20100201"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(mdy("01022010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(myd("01201002"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dmy("02012010"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dym("02201001"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd(c("20100102","20100103")) ,
    equals(as.POSIXct(c("2010-01-02","2010-01-03"), tz =
    "UTC")))
  expect_that(ymd("100102"),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
})

test_that("ymd functions correctly parse dates with no separators and no quotes", {
  expect_that(ymd(20100102),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ydm(20100201),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(mdy(01022010),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(myd(01201002),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dmy(02012010),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(dym(02201001),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd(c(20100102, 20100103)) ,
    equals(as.POSIXct(c("2010-01-02","2010-01-03"), tz =
    "UTC")))
  expect_that(ymd(100102),
    equals(as.POSIXct("2010-01-02", tz = "UTC")))
  expect_that(ymd_hms(20100102235959),
              equals(as.POSIXct("2010-01-02 23:59:59", tz = "UTC")))
})

test_that("ymd functions parse absurd formats as NA's", {
  ## should not through errors, just as as.POSIX and strptime
  pna <- as.POSIXct(as.POSIXlt(NA, tz = "UTC"))
  expect_that(ymd(201001023, quiet = TRUE), equals(pna))
  expect_that(ydm(20103201, quiet = TRUE),  equals(pna))
  expect_that(mdy(13022010, quiet = TRUE), equals(pna))
  expect_that(myd(01201033, quiet = TRUE), equals(pna))
  expect_that(dmy(02222010, quiet = TRUE), equals(pna))
  expect_that(dym(022010013, quiet = TRUE), equals(pna))
  expect_that(ymd_hms("2010-01-023 23:59:59", quiet = TRUE), equals(pna))
  expect_that(ymd_hms("2010-01-023 23:59:59.34", quiet = TRUE), equals(pna))
  expect_that(ymd_hms("201001023235959.34", quiet = TRUE), equals(pna))
  expect_that(ymd(c(201001024, 20100103), quiet = TRUE),
              equals(as.POSIXct(c(NA, "2010-01-03"), tz = "UTC")))
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


test_that("ymd_hms correctly handles a variety of formats", {
  expect_that(ymd_hms("2010-01-02 23:59:59"), equals(as.POSIXct(
    "2010-01-02 23:59:59", tz = "UTC")))
  expect_that(ymd_hms("2010,01,02 23.59.59"), equals(as.POSIXct(
    "2010-01-02 23:59:59", tz = "UTC")))
  expect_that(ymd_hms("2010,01,02 23.59.59.9"), equals(as.POSIXct(
    "2010-01-02 23:59:59.9 UTC", tz = "UTC")))
  expect_that(ymd_hms("2010/01/02 23/59/59"), equals(as.POSIXct(
    "2010-01-02 23:59:59", tz = "UTC")))
  expect_that(ymd_hms("2010:01:02-23:59:59"), equals(as.POSIXct(
    "2010-01-02 23:59:59", tz = "UTC")))
  ## VS: Next doesn't parse on my machine. It's OS specific.
  ## expect_that(ymd_hms("2010-01-02 23:59:61"), equals(as.POSIXct(
  ##   "2010-01-03 00:00:01", tz = "UTC")))
  ## expect_that(ymd_hms(c("2010-01-02 23:59:61",
  ##   "2010-01-02 00:00:00")), equals(as.POSIXct(
  ##   c("2010-01-03 00:00:01", "2010-01-02 00:00:00"), tz =
  ##   "UTC")))
  expect_that(ymd_hms("10-01-02 23:59:59"), equals(as.POSIXct(
    "2010-01-02 23:59:59", tz = "UTC")))
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

test_that("hms functions correctly handle - separators", {
  expect_that(hms("3-3-3"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(hms("03-03-03"), equals(hours(3) + minutes(3) +
    seconds(3)))
  expect_that(ms("03-03"), equals(minutes(3) +
    seconds(3)))
  expect_that(hm("03-03"), equals(hours(3) + minutes(3)))
  expect_that(hm("03-3"), equals(hours(3) + minutes(3)))
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


test_that("heterogeneous formats are correctly parsed", {
  X <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4", "2009-1, 5", "2009....1--6", "200901-07", "200901-8")
  Y <- c("2009-01-01", "2009-01-02", "2009-01-03", "2009-01-04", "2009-01-05", "2009-01-06", "2009-01-07", "2009-01-08")
  expect_that( ymd(X) ,equals( as.POSIXct(Y, tz = "UTC")))
  ## cbind(ymd(X), as.POSIXct(Y, tz = "UTC"))

  X <- c(20100101120101, "2009-01-02 12-01-02", "2009.01.03 12:01:03", "2009-1-4 12-1-4",
         "2009-1, 5 12:1, 5", "2009....1--6 - 12::1:6", "20090107 120107", "2009-01-08 1201-08",
         "2010-01-09 12:01:09", "2010-01-10 10:01:10 AM", "2010-01-11 10:01:11 PM")
  Y <- c("2010-01-01 12:01:01", "2009-01-02 12:01:02", "2009-01-03 12:01:03",
         "2009-01-04 12:01:04", "2009-01-05 12:01:05", "2009-01-06 12:01:06",
         "2009-01-07 12:01:07", "2009-01-08 12:01:08", "2010-01-09 12:01:09",
         "2010-01-10 10:01:10", "2010-01-11 22:01:11")
  expect_that( ymd_hms(X), equals(as.POSIXct(Y, tz = "UTC")))
  cbind(as.character(ymd_hms(X)), as.character(as.POSIXct(Y, tz = "UTC")))
})


test_that("truncated formats are correctly parsed", {
  expect_that({
    x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
    ymd_hms(x, truncated = 3)
  }, equals(as.POSIXct(c("2011-12-31 12:59:59", "2010-01-01 12:11:00", "2010-01-01 12:00:00",
                         "2010-01-01 00:00:00"), tz = "UTC")))
})


test_that("fractional formats are correctly parsed", {
  expect_that({
    x <- c("2011-12-31 12:59:59.23", "2010-01-01 12:11:10")
    ymd_hms(x)
  }, equals(as.POSIXct(c("2011-12-31 12:59:59.23 UTC", "2010-01-01 12:11:10.00 UTC"), tz = "UTC")))
  expect_that(hms("3:0:3.34"), equals(hours(3) + minutes(0) + seconds(3.34)))
})


test_that( "NA's are parsed as NA's", {
  expect_warning(ymd(NA))
  expect_true(is.na(ymd(NA, quiet = TRUE)))
  expect_warning(ymd_hms(NA))
  expect_true(is.na(ymd_hms(NA, quiet = TRUE)))
  expect_warning(ymd_hm(NA))
  expect_true(is.na(ymd_hm(NA, quiet = TRUE)))
  expect_warning(hms(NA))
  expect_true(is.na(hms(NA, quiet = TRUE)))
  expect_warning(ms(NA))
  expect_true(is.na(ms(NA, quiet = TRUE)))
})

test_that( "Vectors of NA's are parsed as vectors of NA's", {
  mna <- as.POSIXct(as.POSIXlt(c(NA,NA,NA), tz = "UTC"))
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

  expect_warning(ymd(NA, NA, NA))
  expect_equal(ymd(NA, NA, NA, quiet = TRUE), mna)
  expect_warning(ymd_hms(NA, NA, NA))
  expect_equal(ymd_hms(NA, NA, NA, quiet = TRUE), mna)
  expect_warning(ymd_hm(NA, NA, NA))
  expect_equal(ymd_hm(NA, NA, NA, quiet = TRUE), mna)
  expect_warning(hms(NA, NA, NA))
  expect_equal(hms(NA, NA, NA, quiet = TRUE), pna)
  expect_warning(ms(NA, NA, NA))
  expect_equal(ms(NA, NA, NA, quiet = TRUE), pna2)

  expect_warning(ymd(c(NA, NA, NA)))
  expect_equal(ymd(c(NA, NA, NA), quiet = TRUE), mna)
  expect_warning(ymd_hms(c(NA, NA, NA)))
  expect_equal(ymd_hms(c(NA, NA, NA), quiet = TRUE), mna)
  expect_warning(ymd_hm(c(NA, NA, NA)))
  expect_equal(ymd_hm(c(NA, NA, NA), quiet = TRUE), mna)
  expect_warning(hms(c(NA, NA, NA)))
  expect_equal(hms(c(NA, NA, NA), quiet = TRUE), pna)
  expect_warning(ms(c(NA, NA, NA)))
  expect_equal(ms(c(NA, NA, NA), quiet = TRUE), pna2)
})


test_that("ISO8601: %z format (aka lubridate %Ou, %OO and %Oo formats) is correctly parsed",{
  expect_that(
    parse_date_time("2012-12-04 15:06:06.95-0800", "YmdHMOSz"),
    equals(as.POSIXct("2012-12-04 23:06:06.95 UTC", tz = "UTC")))
  expect_that(
    parse_date_time(c("2012-12-04 15:06:06.95-08", "2012-12-04 15:06:06.95+08:00"), "YmdHMOSz"),
    equals(as.POSIXct(c("2012-12-04 23:06:06.95 UTC", "2012-12-04 07:06:06.95 UTC"), tz = "UTC")))
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
  expect_that(ymd_hms("2012-03-03 23:06:07", tz="America/Chicago"),
              equals(as.POSIXct("2012-03-03 23:06:07", tz = "America/Chicago")))
})

test_that("ymd_hms parses Ou format correctly ",{
  ## Correct usage
  expect_that(ymd_hms("2012-03-04T05:06:07Z"),
              equals(ymd_hms("2012-03-04 05:06:07", tz="UTC")))
  expect_that(ymd_hms("2012-03-04T05:06:07Z", tz="America/Chicago"),
              equals(ymd_hms("2012-03-03 23:06:07", tz="America/Chicago")))

  ## check for message
  expect_that(ymd_hms("2012-03-04T05:06:07Z", tz="America/Chicago"),
              shows_message("Date in ISO8601 format"))
})

test_that("ymd_hms parses OO and Oo formats correctly", {
  ## +00:00
  expect_that(ymd_hms("2012-03-04T05:06:07+00:00"),
              equals(ymd_hms("2012-03-04 05:06:07", tz="UTC")))
  ## -HH
  expect_that(ymd_hms("2012-03-04T05:06:07-01"),
              equals(ymd_hms("2012-03-04 06:06:07", tz="UTC")))
  ## -HHMM
  expect_that(ymd_hms("2012-03-04T05:06:07-0130"),
              equals(ymd_hms("2012-03-04 06:36:07", tz="UTC")))
  ## -HH:MM
  expect_that(ymd_hms("2012-03-04T05:06:07-01:30"),
              equals(ymd_hms("2012-03-04 06:36:07", tz="UTC")))
  ## +HH
  expect_that(ymd_hms("2012-03-04T05:06:07+01"),
              equals(ymd_hms("2012-03-04 04:06:07", tz="UTC")))
  ## +HHMM
  expect_that(ymd_hms("2012-03-04T05:06:07+0130"),
              equals(ymd_hms("2012-03-04 03:36:07", tz="UTC")))
  ## +HH:MM
  expect_that(ymd_hms("2012-03-04T05:06:07+01:30"),
              equals(ymd_hms("2012-03-04 03:36:07", tz="UTC")))
  ## vectorizes
  expect_that(ymd_hms(c("2012-03-04T05:06:07+01", "2012-03-04T05:06:07+01:30")),
              equals(ymd_hms(c("2012-03-04 04:06:07", "2012-03-04 03:36:07"), tz="UTC")))

  expect_that(ymd_hms("2012-03-04T05:06:07-01:30", tz="America/Chicago", quiet = T),
              equals(ymd_hms("2012-03-04 00:36:07", tz="America/Chicago")))

  expect_that(ymd_hms("2012-03-04T05:06:07-01:30", tz="America/Chicago"),
              shows_message("Date in ISO8601 format"))
})

test_that("ymd_hms parses mixed ISO-8601/non-ISO-8601 formats",{
  expect_that(ymd_hms(c("2012-03-04T05:06:07Z", "2001-02-03 04:05:06"),
                      tz="America/Chicago"),
              equals(ymd_hms(c("2012-03-03 23:06:07", "2001-02-03 04:05:06"),
                             tz="America/Chicago")))
})

test_that("parse_date_time2 and fast_strptime parse ISO8601 timezones",{
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


test_that("ymd_hms, parse_date_time2 and fast_strptime give the same result", {
  ## random times between 1400 and 3000
  X <- as.character(.POSIXct(runif(1000, -17987443200, 32503680000)))
  oposix <- as.POSIXct(X, tz = "UTC")
  opdt1 <- ymd_hms(X)
  opdt2 <- parse_date_time2(X, "YmdHMOS")
  ostrptime <- fast_strptime(X, "%Y-%m-%d %H:%M:%OS")
  expect_equal(oposix, opdt1)
  expect_equal(oposix, opdt2)
  expect_equal(oposix, ostrptime)
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


## c("2012-12-04 15:06:06.952000-08:00", "2012-12-04 15:04:01.640000-08:00",
##   "2012-12-02 17:58:31.141000-08:00", "2012-12-04 17:15:14.091000-08:00",
##   "2012-12-04 17:16:05.097000-08:00")

## ### speed:
## options(digits.secs = 3)
## ## random times between 1400 and 3000
## tt <- as.character(.POSIXct(runif(1e6, -17987443200, 32503680000)))
## system.time(out <- as.POSIXct(tt, tz = "UTC"))
## system.time(out1 <- ymd_hms(tt)) ## format learning overhead
## system.time(out2 <- parse_date_time2(tt, "YmdHMOS"))
## system.time(out3 <- fast_strptime(tt, "%Y-%m-%d %H:%M:%OS"))
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
