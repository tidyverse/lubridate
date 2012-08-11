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

test_that("ymd functions fail to parse absurd formats", {
  ## should not through errors, just as as.POSIX and strptime
  pna <- as.POSIXct(as.POSIXlt(NA, tz = "UTC"))
  expect_that(ymd(201001023), equals(pna))
  expect_that(ydm(20103201),  equals(pna))
  expect_that(mdy(13022010), equals(pna))
  expect_that(myd(01201033), equals(pna))
  expect_that(dmy(02222010), equals(pna))
  expect_that(dym(022010013), equals(pna))
  expect_that(ymd_hms("2010-01-023 23:59:59"), equals(pna))
  expect_that(ymd_hms("2010-01-023 23:59:59.34"), equals(pna))
  expect_that(ymd_hms("201001023235959.34"), equals(pna))
  expect_that(ymd(c(201001024, 20100103)),
              equals(as.POSIXct(c(NA, "2010-01-03"), tz = "UTC")))
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
  expect_that(is.na(hms("3:3:3:4")), is_true())
  expect_that(is.na(hms("03:03")), is_true())
  expect_that(is.na(ms("03:02:01")), is_true())
  expect_that(is.na(ms("03")), is_true())
  expect_that(is.na(hm("03:03:01")), is_true())
  expect_that(is.na(hm("03")), is_true())
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





## ## ### speed:
## options(digits.secs = 0)
## tt <- rep(as.character(Sys.time()), 1e5)

## ## system.time(out <- lubridate::ymd_hms(tt))
## system.time(out <- ymd_hms(tt))

## tt <- rep(as.character(Sys.time()), 10^7)
## system.time(as.POSIXct(tt, tz = "UTC"))

## Rprof()
## system.time(out <- as.POSIXct(strptime(tt, "%Y-%m-%d %H:%M:%S", tz = "UTC")))
## Rprof(NULL)

## Rprof()
## system.time(out <- ymd_hms(tt))
## Rprof(NULL)
## summaryRprof()

## tt <- rep("3:3:3", 10^5)
## system.time(out <- lubridate:::hms(tt))
## system.time(out <- hms(tt))


## ## ** heterogenuous formats **
## x <- c(20100101120101, "2009-01-02 12-01-02", "2009.01.03 12:01:03",
##        "2009-1-4 12-1-4",
##        "2009-1, 5 12:1, 5",
##        "200901-08 1201-08",
##        "2009 arbitrary 1 non-decimal 6 chars 12 in between 1 !!! 6",
##        "OR collapsed formats: 20090107 120107 (as long as prefixed with zeros)",
##        "Automatic wday, Thu, detection, 10-01-10 10:01:10 and p format: AM",
##        "Created on 10-01-11 at 10:01:11 PM")
## ymd_hms(x)

## tt <- rep.int(x, 1e4)
## system.time(as.POSIXct(tt))
## system.time(ymd_hms(tt))

## tt <- c(rep.int(as.character(Sys.Date()), 55),
##         rep.int(as.character(Sys.time()), 55))


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



