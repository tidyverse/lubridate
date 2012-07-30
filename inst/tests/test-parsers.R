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



## x <- c("09-01-01 12:23", "09-01-02", "09-01-03")


## x <- c("02/11/92 23", "31/03/92 22", "01/10/92 01:03",
##        "02/02/92 18:21:03",  "02/01/92 16:56:26")


## parse_time(x, c("%d%m%y%H%M%S", "%d%m%y"))

## parse_time(x, c("%d%m%y%H%M%S"))
## parse_time(x, c("%d%m%y%H%M%S"), missing = 2)

## x <- c("11/92",  "92", "02/02/92",  "02/01/92")
## parse_time(x, "%d%m%y", missing = -2)

## x <- c("07-03-02",  "92", "02/02/92",  "02/01/92")
## ## gives junk
## parse_time(x, "%d%m%y", missing = -2)
## ## only reliable way is to specify formats explicitly:
## parse_time(x, c("%d/%m/%y", "%y-%m-%d", "%y"), sep = NULL)

## x <- c("02/11/92 23", "31/03/92 22", "01/10/92 01:03",
##        "02/02/92 18:21:03",  "02/01/92 16:56:26")

## dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")

## mdy(dates)

## options(digits.secs = 3)
## tt <- rep(as.character(Sys.time()), 10^6)
## system.time(out <- as.POSIXct(tt))
## system.time(out <- ymd_hms(tt))
## system.time(out <- ymd_hms(tt, frac = T))

## options(digits.secs = 0)
## tt <- rep(as.character(Sys.time()), 10^3)
## system.time(out <- ymd_hms(tt))
## str(out)

## system.time(ms <- as.numeric(gsub(".*\\.([^.]*)", "\\1", tt)))
## system.time(ms <- as.numeric(gsub("(.*)(\\.([^.]))?", "\\3", tt)))
## (gsub(".*\\.([^.]*)$", "", "2012-07-20 14:13:46"))

## system.time(parse_time(tt, "%Y%m%d", sep = "-"))
## system.time(parse_time(tt, list(c("%Y", "%m", "%d")), sep = "-"))

## system.time(parse_date(tt, list(c("%Y", "%m", "%d")), seps = "-"))

## tt <- rep("3.4.5", 10^6)

## system.time(out <- strsplitt(t, "[[:alnum:]]"))

## x <- c("1jan1960135412", "2jan1960", "31mar1960", "30jul1960")
## str(unclass(z <- strptime(x, "%d%b%Y%k%M%S")))

## x <- c("09:10:01", "09:10:02", "09:10:03")
## hms(x)

## x <- rep(c("1970-01-01 09:10:01"), 10^6)
## system.time(str(strptime(x, "%Y-%m-%d %H:%M:%S")))
## system.time(lubridate:::hms(x))

## x <- rep("7 6", 10^5)
## ms(x)


## y <- c("2011-12-31 12:9:23.3", "2011-12-31 2:9", "10-03-04 12:00", "10-03-04 12", "10-03-04 1204")
## strptime(y, format = "%y-%m-%d %H:%M") ## [1] NA "2010-03-04 12:00:00"
## strptime(y, format = "%Y-%m-%d %H:%M") ## [1] "2011-12-31 12:59:00" "10-03-04 12:00:00"  
## strptime(y, format = "%Y-%m-%d %H:%M") ## [1] "2011-12-31 12:59:00" "10-03-04 12:00:00"
## unclass(strptime(y, format = "%Y-%m-%d %H:%M:%OS")) ## [1] "2011-12-31 12:59:00" "10-03-04 12:00:00"  

## ymd_hm(y) ## [1] "2011-12-31 12:59:00 UTC" "2010-03-04 12:00:00 UTC"
## (ymd_hm(y, missing = 1))


## ymd_hms("2011-12-31 11:09:23PM")
## lubridate::ymd_hms("2011-12-31 11:09:23PM")


## ymd_hms("2011-12-31 11:9:23 PM")
## lubridate::ymd_hms("2011-12-31 11:9:23 PM")


