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

  ## VC: Next doesn't parse on my machine. It's OS specific.
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


test_that("hms functions return NA on incompatible inputs", {
  expect_that(is.na(hms("3:3:3:4", quiet = TRUE)), is_true())
  expect_that(is.na(hms("03:03", quiet = TRUE)), is_true())
  expect_that(is.na(ms("03:02:01", quiet = TRUE)), is_true())
  expect_that(is.na(ms("03", quiet = TRUE)), is_true())
  expect_that(is.na(hm("03:03:01", quiet = TRUE)), is_true())
  expect_that(is.na(hm("03", quiet = TRUE)), is_true())
})

test_that("hms functions give warning on incompatible inputs", {
  expect_warning(hms("3:3:3:4"))
  expect_warning(hms("03:03"))
  expect_warning(ms("03:02:01"))
  expect_warning(ms("03"))
  expect_warning(hm("03:03:01"))
  expect_warning(hm("03"))
})


test_that("heterogeneous formats are correctly parsed", {  
  expect_that(ymd(c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
                    "2009-1, 5", "2009....1--6", "200901-07", "200901-8")),
              equals(as.POSIXct(c("2009-01-01", "2009-01-02", "2009-01-03", "2009-01-04",
                                  "2009-01-05", "2009-01-06", "2009-01-07", "2009-01-08"), tz = "UTC")))


  expect_that({
    x <- c(20100101120101, "2009-01-02 12-01-02", "2009.01.03 12:01:03", "2009-1-4 12-1-4",
           "2009-1, 5 12:1, 5", "2009....1--6 - 12::1:6", "20090107 120107", "200901-08 1201-08",
           "10-01-09 12:01:09", "10-01-10 10:01:10 AM", "10-01-11 10:01:11 PM")
    ymd_hms(x)
  }, equals(as.POSIXct(c("2010-01-01 12:01:01", "2009-01-02 12:01:02", "2009-01-03 12:01:03", 
                         "2009-01-04 12:01:04", "2009-01-05 12:01:05", "2009-01-06 12:01:06", 
                         "2009-01-07 12:01:07", "2009-01-08 12:01:08", "2010-01-09 12:01:09", 
                         "2010-01-10 10:01:10", "2010-01-11 22:01:11"), tz = "UTC")))
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
  
  
test_that("ISO8601: %z format (aka lubridate %Ot, %OO and %Oo formats) is correctly parsed",{
  
  expect_that(
    parse_date_time("2012-12-04 15:06:06.95-0800", "YmdHMOSz"),
    equals(as.POSIXlt("2012-12-04 23:06:06.95 UTC", tz = "UTC")))
  
  expect_that(
    parse_date_time(c("2012-12-04 15:06:06.95-08", "2012-12-04 15:06:06.95+08:00"), "YmdHMOSz"),
    equals(as.POSIXlt(c("2012-12-04 23:06:06.95 UTC", "2012-12-04 07:06:06.95 UTC"), tz = "UTC")))
  
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

  expect_that(ymd_hms("2012-03-04T05:06:07-01:30", tz="America/Chicago"), 
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


## c("2012-12-04 15:06:06.952000-08:00", "2012-12-04 15:04:01.640000-08:00", 
##   "2012-12-02 17:58:31.141000-08:00", "2012-12-04 17:15:14.091000-08:00", 
##   "2012-12-04 17:16:05.097000-08:00")


## ### speed:
## options(digits.secs = 3)
## tt <- c(rep(as.character(Sys.time()), 1e5))#, "sfds", "sdfdsf")

## system.time(out <- as.POSIXct(tt, tz = "UTC"))
## system.time(out <- ymd_hms(tt))

## ttz <- paste(tt, "-0600", sep = "")
## system.time(parse_date_time(ttz, "YmdHMOSz"))
## head(parse_date_time(ttz, "YmdHMOSz"))
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

## tt <- rep("3:3:3", 10^5)
## system.time(out <- hms(tt))


## ## ** heterogenuous formats **
## x <- c(20100101120101, "dsf 09-01-02 12-01-02 dff", "2009.01.03 12:01:03",
##        "2009-1-4 12-1-4",
##        "2009-1, 5 12:1, 5",
##        "200901-08 1201-08",
##        "2009 arbitrary 1 non-decimal 6 chars 12 in between 1 !!! 6",
##        "OR collapsed formats: 20090107 120107 (as long as prefixed with zeros)",
##        "Automatic wday, Thu, detection, 10-01-10 10:01:10 and p format: AM sdf",
##        "Created on 10-01-11 at 10:01:11 PM")
## ymd_hms(x)

## guess_formats(x, "ymdHMS")

## tt <- rep.int(x, 1e4)
## system.time(as.POSIXct(tt))
## system.time(ymd_hms(tt))



## ## ** stamp ** functionality:
## Sys.setlocale("LC_TIME", "en_US.utf8")

## y <- c('February 20th 1973',
##        "february  14, 2004",
##        "01 3 2010",
##        "1 3 10",
##        "12/31/99", 
##        "DOB:12/11/00", 
##        'Thu, 1 July 2004 22:30:00',
##        "1979-05-27 05:00:59",
##        '00/13/10',
##        "03:23:22 pm")
## D <- as.POSIXct("2012-08-13 11:37:53", tz = "UTC")
## stamp(y[[7]])(D)
## cbind(y, unlist(lapply(y, function(x) stamp(x, quiet = TRUE)(D))))

## tt <- c(rep.int(as.character(Sys.Date()), 55),
##         rep.int(as.character(Sys.time()), 55))

## ## locales
## Sys.setlocale("LC_TIME", "zh_CN.utf8")
## format(Sys.time(), format = "%A %Y %B %d %I:%M:%S %p")

## Sys.setlocale("LC_TIME", "ru_RU.utf8")
## format(Sys.time(), format = "%a %Y %b %d %I:%M:%S %p")

## x_CN <- "星期二 2012 八月 14 12:07:40 下午"
## ymd_hms(x_CN, locale = "zh_CN.utf8")
## guess_formats(x_CN, "ymdT", locale = "zh_CN.utf8")
## x_RO <- "Ma 2012 august 14 11:28:30 "
## ymd_hms(x_RO, locale = "ro_RO.utf8")
## x_RU <- "Вт. 2012 Август 14 11:28:19 "
## x_RU2 <- "Вт. 2012 авг. 14 11:52:57 "
## ymd_hms(c(x_RU, x_RU2), locale = "ru_RU.utf8")


## gsub("([].|(){^$*+?[])", "\\\\\\1", "sdfs.")

## ## ** truncated time-dates **
## x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
## ymd_hms(x, missing = 3)

## ## x <- c("2011-12-31 12:59", "2010-01-01 12", "2010-01-01")
## ## ymd_hm(x, missing = 2)


## ## ** fractional seconds **
## library(devtools)
## install_github("lubridate", "vitoshka")
## library(lubridate)

## options(digits.secs = 3)
## x <- c("2011-12-31 12:59:59.23", "2010-01-01 12:11:10")
## ymd_hms(x)
## hms("3:3:3.34")

## ## ## New formats:
## ymd_hms("10-12-01 01:01:01 AM", "10-12-01 01:01:01 PM", 101010202020)
## guess_formats("101010202020", "ymdT")
## guess_formats("001020", "ymd")

## guess_formats("10 am", "r")
