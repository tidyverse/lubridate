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

test_that("ymd functions correctly throw errors", {
  
  expect_that(ymd(201001023), throws_error())
  expect_that(ydm(20103201), throws_error())
  expect_that(mdy(13022010), throws_error())
  expect_that(myd(01201033), throws_error())
  expect_that(dmy(02222010), throws_error())
  expect_that(dym(022010013), throws_error())
  expect_that(ymd(c(201001024, 20100103)), equals(
    as.POSIXct(c(NA, "2010-01-03"), tz = "UTC")))
})




test_that("ymd_hms correctly throw errors", {
  expect_that(ymd_hms("2010-01-023 23:59:59"), throws_error())

  ## %OS. will always match this crap. FUCK :(
  ## ymd_hms("2010-01-023 23:59:59.34", frac = T)
  ## ymd_hms("201001023235959.34", frac = T)

})

test_that("ymd_hms correctly handles a variety of formats", {
  expect_that(ymd_hms("2010-01-02 23:59:59"), equals(as.POSIXct(
    "2010-01-02 23:59:59", tz = "UTC")))
  expect_that(ymd_hms("2010,01,02 23.59.59"), equals(as.POSIXct(
    "2010-01-02 23:59:59", tz = "UTC")))
  expect_that(ymd_hms("2010/01/02 23/59/59"), equals(as.POSIXct(
    "2010-01-02 23:59:59", tz = "UTC")))
  expect_that(ymd_hms("2010:01:02-23:59:59"), equals(as.POSIXct(
    "2010-01-02 23:59:59", tz = "UTC")))

  ## VC: This is an error on my machine
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


test_that("hms functions correctly throw errors", {
  expect_that(hms("3:3:3:4"), throws_error(
    "match any of the format orders"))
  expect_that(hms("03:03"), throws_error(
    "match any of the format orders"))
  expect_that(ms("03:02:01"), throws_error(
    "match any of the format orders"))
  expect_that(ms("03"), throws_error(
    "match any of the format orders"))
  expect_that(hm("03:03:01"), throws_error(
    "match any of the format orders"))
  expect_that(hm("03"), throws_error(
    "match any of the format orders"))
})



test_that("heterogeneous formats are correctly parsed", {
  
  expect_that(ymd(c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
                    "2009-1, 5", "2009....1--6", "200901-07", "200901-8")),
              equals(as.POSIXct(c("2009-01-01", "2009-01-02", "2009-01-03", "2009-01-04",
                                  "2009-01-05", "2009-01-06", "2009-01-07", "2009-01-08"), tz = "UTC")))


  expect_that({
    x <- c(20100101120101, "2009-01-02 12-01-02", "2009.01.03 12:01:03", "2009-1-4 12-1-4",
           "2009-1, 5 12:1, 5", "2009....1--6 - 12::1:6", "20090107 120107", "200901-08 1201-8",
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
    ymd_hms(x, missing = 3)
  }, equals(as.POSIXct(c("2011-12-31 12:59:59", "2010-01-01 12:11:00", "2010-01-01 12:00:00", 
                         "2010-01-01 00:00:00"), tz = "UTC")))

})


test_that("fractional formats are correctly parsed", {

  expect_that({
    x <- c("2011-12-31 12:59:59.23", "2010-01-01 12:11:10")
    ymd_hms(x, frac = TRUE)
  }, equals(as.POSIXct(c("2011-12-31 12:59:59.23 UTC", "2010-01-01 12:11:10.00 UTC"), tz = "UTC")))

  expect_that(hms("3:0:3.34", frac = T), equals(hours(3) + minutes(0) + seconds(3.34)))
})





## ### speed:
## options(digits.secs = 0)
## tt <- rep(as.character(Sys.time()), 10^5)

## system.time(out <- lubridate::ymd_hms(tt))
## system.time(out <- ymd_hms(tt))

## tt <- rep(as.character(Sys.time()), 10^6)
## system.time(out <- as.POSIXct(tt, tz = "UTC"))
## system.time(out <- ymd_hms(tt))


## tt <- rep("3:3:3", 10^5)
## system.time(out <- lubridate:::hms(tt))
## system.time(out <- hms(tt))


## ## ** heterogenuous formats **
## x <- c(20100101120101, "2009-01-02 12-01-02", "2009.01.03 12:01:03", "2009-1-4 12-1-4",
##        "2009-1, 5 12:1, 5", "2009....1--6 - 12::1:6", "20090107 120107", "200901-08 1201-8",
##        "10-01-09 12:01:09", "10-01-10 10:01:10 AM", "10-01-11 10:01:11 PM")
## ymd_hms(x)

## ## ** truncated time-dates **
## x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
## ymd_hms(x, missing = 3)

## x <- c("2011-12-31 12:59", "2010-01-01 12", "2010-01-01")
## ymd_hm(x, missing = 2)


## ## ** fractional seconds **
## library(devtools)
## install_github("lubridate", "vitoshka")
## library(lubridate)
## options(digits.secs = 3)
## x <- c("2011-12-31 12:59:59.23", "2010-01-01 12:11:10")
## ymd_hms(x, frac = TRUE)
## hms("3:3:3.34", frac = TRUE)

## ## New formats:
## ymd_hms("10-12-01 01:01:01 AM", "10-12-01 01:01:01 PM", 101010202020)


