context("Settors")

test_that("seconds settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 10
  second(posct) <- 10
  second(date) <- 10

  expect_that(second(poslt), equals(10))
  expect_that(second(posct), equals(10))
  expect_that(second(date), equals(10))

})

test_that("seconds settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 69
  second(posct) <- 69
  second(date) <- 69

  expect_that(second(poslt), equals(9))
  expect_that(minute(poslt), equals(0))
  expect_that(hour(poslt), equals(0))
  expect_that(mday(poslt), equals(1))
  expect_that(wday(poslt), equals(7))
  expect_that(yday(poslt), equals(1))
  expect_that(month(poslt), equals(1))
  expect_that(year(poslt), equals(2011))
  expect_that(tz(poslt), equals("UTC"))

  expect_that(second(posct), equals(9))
  expect_that(minute(posct), equals(0))
  expect_that(hour(posct), equals(0))
  expect_that(mday(posct), equals(1))
  expect_that(wday(posct), equals(7))
  expect_that(yday(posct), equals(1))
  expect_that(month(posct), equals(1))
  expect_that(year(posct), equals(2011))
  expect_that(tz(posct), equals("UTC"))

  expect_that(second(date), equals(9))
  expect_that(minute(date), equals(1))
  expect_that(hour(date), equals(0))
  expect_that(mday(date), equals(31))
  expect_that(wday(date), equals(6))
  expect_that(yday(date), equals(365))
  expect_that(month(date), equals(12))
  expect_that(year(date), equals(2010))
  expect_that(tz(date), equals("UTC"))

})

test_that("seconds settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 1
  second(posct) <- 1
  second(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  second(poslt) <- 69
  second(posct) <- 69
  second(date) <- 69

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})


test_that("seconds settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  posxct <- as.POSIXct(poslt)

  second(poslt) <- 69
  second(posxct) <- 69

  expect_true(is.na(poslt))
  expect_true(is.na(posxct))

})

test_that("seconds settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 10
  second(posct) <- 10
  day(date) <- 10

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

  second(poslt) <- 70
  second(posct) <- 70
  day(date) <- 32

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

})



test_that("minutes settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  minute(poslt) <- 10
  minute(posct) <- 10
  minute(date) <- 10

  expect_that(minute(poslt), equals(10))
  expect_that(minute(posct), equals(10))
  expect_that(minute(date), equals(10))

})

test_that("minutes settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  minute(poslt) <- 69
  minute(posct) <- 69
  minute(date) <- 69

  expect_that(second(poslt), equals(59))
  expect_that(minute(poslt), equals(9))
  expect_that(hour(poslt), equals(0))
  expect_that(mday(poslt), equals(1))
  expect_that(wday(poslt), equals(7))
  expect_that(yday(poslt), equals(1))
  expect_that(month(poslt), equals(1))
  expect_that(year(poslt), equals(2011))
  expect_that(tz(poslt), equals("UTC"))

  expect_that(second(posct), equals(59))
  expect_that(minute(posct), equals(9))
  expect_that(hour(posct), equals(0))
  expect_that(mday(posct), equals(1))
  expect_that(wday(posct), equals(7))
  expect_that(yday(posct), equals(1))
  expect_that(month(posct), equals(1))
  expect_that(year(posct), equals(2011))
  expect_that(tz(posct), equals("UTC"))

  expect_that(second(date), equals(0))
  expect_that(minute(date), equals(9))
  expect_that(hour(date), equals(1))
  expect_that(mday(date), equals(31))
  expect_that(wday(date), equals(6))
  expect_that(yday(date), equals(365))
  expect_that(month(date), equals(12))
  expect_that(year(date), equals(2010))
  expect_that(tz(date), equals("UTC"))

})

test_that("minutes settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

    minute(poslt) <- 1
  minute(posct) <- 1
  minute(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  minute(poslt) <- 70
  minute(posct) <- 70
  minute(date) <- 70

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})


test_that("minutes settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  posct <- as.POSIXct(poslt)

  minute(poslt) <- 70
  minute(posct) <- 70

  expect_that(is.na(poslt), is_true())
  expect_that(is.na(posct), is_true())

})

test_that("minutes settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  minute(poslt) <- 1
  minute(posct) <- 1
  minute(date) <- 1

  expect_that("minute<-"(poslt, 1), is_a("POSIXlt"))
  expect_that("minute<-"(posct, 1), is_a("POSIXct"))
  expect_that("minute<-"(date, 1), is_a("POSIXlt"))

  minute(poslt) <- 70
  minute(posct) <- 70
  minute(date) <- 70

  expect_that("minute<-"(poslt, 70), is_a("POSIXlt"))
  expect_that("minute<-"(posct, 70), is_a("POSIXct"))
  expect_that("minute<-"(date, 70), is_a("POSIXlt"))

})

test_that("hours settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 10
  hour(posct) <- 10
  hour(date) <- 10

  expect_that(hour(poslt), equals(10))
  expect_that(hour(posct), equals(10))
  expect_that(hour(date), equals(10))

})

test_that("hours settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 25
  hour(posct) <- 25
  hour(date) <- 25

  expect_that(second(poslt), equals(59))
  expect_that(minute(poslt), equals(59))
  expect_that(hour(poslt), equals(1))
  expect_that(mday(poslt), equals(1))
  expect_that(wday(poslt), equals(7))
  expect_that(yday(poslt), equals(1))
  expect_that(month(poslt), equals(1))
  expect_that(year(poslt), equals(2011))
  expect_that(tz(poslt), equals("UTC"))

  expect_that(second(posct), equals(59))
  expect_that(minute(posct), equals(59))
  expect_that(hour(posct), equals(1))
  expect_that(mday(posct), equals(1))
  expect_that(wday(posct), equals(7))
  expect_that(yday(posct), equals(1))
  expect_that(month(posct), equals(1))
  expect_that(year(posct), equals(2011))
  expect_that(tz(posct), equals("UTC"))

  expect_that(second(date), equals(0))
  expect_that(minute(date), equals(0))
  expect_that(hour(date), equals(1))
  expect_that(mday(date), equals(1))
  expect_that(wday(date), equals(7))
  expect_that(yday(date), equals(1))
  expect_that(month(date), equals(01))
  expect_that(year(date), equals(2011))
  expect_that(tz(date), equals("UTC"))

})

test_that("hours settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 1
  hour(posct) <- 1
  hour(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  hour(poslt) <- 70
  hour(posct) <- 70
  hour(date) <- 70

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})


test_that("hours settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  posct <- as.POSIXct(poslt)

  hour(poslt) <- 2
  hour(posct) <- 2

  expect_that(is.na(poslt), is_true())
  expect_that(is.na(posct), is_true())

})

test_that("hours settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 2
  hour(posct) <- 2
  hour(date) <- 2

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("POSIXlt"))

  hour(poslt) <- 25
  hour(posct) <- 25
  hour(date) <- 25

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("POSIXlt"))

})



test_that("mdays settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 10
  mday(posct) <- 10
  mday(date) <- 10

  expect_that(mday(poslt), equals(10))
  expect_that(mday(posct), equals(10))
  expect_that(mday(date), equals(10))

  expect_that(yday(poslt), equals(41))
  expect_that(yday(posct), equals(41))
  expect_that(yday(date), equals(41))

  expect_that(wday(poslt), equals(4))
  expect_that(wday(posct), equals(4))
  expect_that(wday(date), equals(4))

})

test_that("mdays settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 32
  mday(posct) <- 32
  mday(date) <- 32

  expect_that(second(poslt), equals(59))
  expect_that(minute(poslt), equals(59))
  expect_that(hour(poslt), equals(23))
  expect_that(mday(poslt), equals(1))
  expect_that(wday(poslt), equals(7))
  expect_that(yday(poslt), equals(1))
  expect_that(month(poslt), equals(1))
  expect_that(year(poslt), equals(2011))
  expect_that(tz(poslt), equals("UTC"))

  expect_that(second(posct), equals(59))
  expect_that(minute(posct), equals(59))
  expect_that(hour(posct), equals(23))
  expect_that(mday(posct), equals(1))
  expect_that(wday(posct), equals(7))
  expect_that(yday(posct), equals(1))
  expect_that(month(posct), equals(1))
  expect_that(year(posct), equals(2011))
  expect_that(tz(posct), equals("UTC"))

  expect_that(second(date), equals(0))
  expect_that(minute(date), equals(0))
  expect_that(hour(date), equals(0))
  expect_that(mday(date), equals(1))
  expect_that(wday(date), equals(7))
  expect_that(yday(date), equals(1))
  expect_that(month(date), equals(1))
  expect_that(year(date), equals(2011))
  expect_that(tz(date), equals("UTC"))

})

test_that("mdays settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 1
  mday(posct) <- 1
  mday(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  mday(poslt) <- 32
  mday(posct) <- 32
  mday(date) <- 32

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})


test_that("mdays settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-13 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  posct <- as.POSIXct(poslt)

  mday(poslt) <- 14
  mday(posct) <- 14

  expect_that(is.na(poslt), is_true())
  expect_that(is.na(posct), is_true())

})

test_that("mdays settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 3
  mday(posct) <- 3
  mday(date) <- 3

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

  mday(poslt) <- 32
  mday(posct) <- 32
  mday(date) <- 32

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

})



test_that("ydays settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 41
  yday(posct) <- 41
  yday(date) <- 41

  expect_that(yday(poslt), equals(41))
  expect_that(yday(posct), equals(41))
  expect_that(yday(date), equals(41))

  expect_that(mday(poslt), equals(10))
  expect_that(mday(posct), equals(10))
  expect_that(mday(date), equals(10))

  expect_that(wday(poslt), equals(4))
  expect_that(wday(posct), equals(4))
  expect_that(wday(date), equals(4))
})

test_that("ydays settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 366
  yday(posct) <- 366
  yday(date) <- 366

  expect_that(second(poslt), equals(59))
  expect_that(minute(poslt), equals(59))
  expect_that(hour(poslt), equals(23))
  expect_that(mday(poslt), equals(1))
  expect_that(wday(poslt), equals(7))
  expect_that(yday(poslt), equals(1))
  expect_that(month(poslt), equals(1))
  expect_that(year(poslt), equals(2011))
  expect_that(tz(poslt), equals("UTC"))

  expect_that(second(posct), equals(59))
  expect_that(minute(posct), equals(59))
  expect_that(hour(posct), equals(23))
  expect_that(mday(posct), equals(1))
  expect_that(wday(posct), equals(7))
  expect_that(yday(posct), equals(1))
  expect_that(month(posct), equals(1))
  expect_that(year(posct), equals(2011))
  expect_that(tz(posct), equals("UTC"))

  expect_that(second(date), equals(0))
  expect_that(minute(date), equals(0))
  expect_that(hour(date), equals(0))
  expect_that(mday(date), equals(1))
  expect_that(wday(date), equals(7))
  expect_that(yday(date), equals(1))
  expect_that(month(date), equals(1))
  expect_that(year(date), equals(2011))
  expect_that(tz(date), equals("UTC"))

})

test_that("ydays settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 1
  yday(posct) <- 1
  yday(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  yday(poslt) <- 366
  yday(posct) <- 366
  yday(date) <- 366

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})


test_that("ydays settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-13 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  posct <- as.POSIXct(poslt)

  yday(poslt) <- 73
  yday(posct) <- 73

  expect_that(is.na(poslt), is_true())
  expect_that(is.na(posct), is_true())

})

test_that("ydays settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 3
  yday(posct) <- 3
  yday(date) <- 3

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

  yday(poslt) <- 366
  yday(posct) <- 366
  yday(date) <- 366

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

})



test_that("wdays settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 5
  wday(posct) <- 5
  wday(date) <- 5

  expect_that(wday(poslt), equals(5))
  expect_that(wday(posct), equals(5))
  expect_that(wday(date), equals(5))

  expect_that(mday(poslt), equals(4))
  expect_that(mday(posct), equals(4))
  expect_that(mday(date), equals(4))

  expect_that(mday(poslt), equals(4))
  expect_that(mday(posct), equals(4))
  expect_that(mday(date), equals(4))

})

test_that("wdays settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 8
  wday(posct) <- 8
  wday(date) <- 8

  expect_that(second(poslt), equals(59))
  expect_that(minute(poslt), equals(59))
  expect_that(hour(poslt), equals(23))
  expect_that(mday(poslt), equals(2))
  expect_that(wday(poslt), equals(1))
  expect_that(yday(poslt), equals(2))
  expect_that(month(poslt), equals(1))
  expect_that(year(poslt), equals(2011))
  expect_that(tz(poslt), equals("UTC"))

  expect_that(second(posct), equals(59))
  expect_that(minute(posct), equals(59))
  expect_that(hour(posct), equals(23))
  expect_that(mday(posct), equals(2))
  expect_that(wday(posct), equals(1))
  expect_that(yday(posct), equals(2))
  expect_that(month(posct), equals(1))
  expect_that(year(posct), equals(2011))
  expect_that(tz(posct), equals("UTC"))

  expect_that(second(date), equals(0))
  expect_that(minute(date), equals(0))
  expect_that(hour(date), equals(0))
  expect_that(mday(date), equals(2))
  expect_that(wday(date), equals(1))
  expect_that(yday(date), equals(2))
  expect_that(month(date), equals(1))
  expect_that(year(date), equals(2011))
  expect_that(tz(date), equals("UTC"))

})

test_that("wdays settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 2
  wday(posct) <- 2
  wday(date) <- 2

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

  wday(poslt) <- 8
  wday(posct) <- 8
  wday(date) <- 8

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})


test_that("wdays settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-13 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  posct <- as.POSIXct(poslt)

  wday(poslt) <- 8
  wday(posct) <- 8

  expect_that(is.na(poslt), is_true())
  expect_that(is.na(posct), is_true())

})

test_that("wdays settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 3
  wday(posct) <- 3
  wday(date) <- 3

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

  wday(poslt) <- 8
  wday(posct) <- 8
  wday(date) <- 8

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

})


test_that("months settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  month(poslt) <- 5
  month(posct) <- 5
  month(date) <- 5

  expect_that(month(poslt), equals(5))
  expect_that(month(posct), equals(5))
  expect_that(month(date), equals(5))
})

test_that("months settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

    month(poslt) <- 13
  month(posct) <- 13
  month(date) <- 13

  expect_that(second(poslt), equals(59))
  expect_that(minute(poslt), equals(59))
  expect_that(hour(poslt), equals(23))
  expect_that(mday(poslt), equals(31))
  expect_that(wday(poslt), equals(2))
  expect_that(yday(poslt), equals(31))
  expect_that(month(poslt), equals(1))
  expect_that(year(poslt), equals(2011))
  expect_that(tz(poslt), equals("UTC"))

  expect_that(second(posct), equals(59))
  expect_that(minute(posct), equals(59))
  expect_that(hour(posct), equals(23))
  expect_that(mday(posct), equals(31))
  expect_that(wday(posct), equals(2))
  expect_that(yday(posct), equals(31))
  expect_that(month(posct), equals(1))
  expect_that(year(posct), equals(2011))
  expect_that(tz(posct), equals("UTC"))

  expect_that(second(date), equals(0))
  expect_that(minute(date), equals(0))
  expect_that(hour(date), equals(0))
  expect_that(mday(date), equals(31))
  expect_that(wday(date), equals(2))
  expect_that(yday(date), equals(31))
  expect_that(month(date), equals(1))
  expect_that(year(date), equals(2011))
  expect_that(tz(date), equals("UTC"))

})

test_that("months settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

    month(poslt) <- 1
  month(posct) <- 1
  month(date) <- 1

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")

    month(poslt) <- 13
  month(posct) <- 13
  month(date) <- 13

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})


test_that("months settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-02-14 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  posct <- as.POSIXct(poslt)

    month(poslt) <- 3
  month(posct) <- 3

  expect_that(is.na(poslt), is_true())
  expect_that(is.na(posct), is_true())
})

test_that("months settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

    month(poslt) <- 1
  month(posct) <- 1
  month(date) <- 1

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

    month(poslt) <- 13
  month(posct) <- 13
  month(date) <- 13

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))

})


test_that("years settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  year(poslt) <- 2000
  year(posct) <- 2000
  year(date) <- 2000

  expect_that(year(poslt), equals(2000))
  expect_that(year(posct), equals(2000))
  expect_that(year(date), equals(2000))
})


test_that("years settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  year(poslt) <- 2000
  year(posct) <- 2000
  year(date) <- 2000

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})


test_that("years settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2009-03-14 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  posct <- as.POSIXct(poslt)

  year(poslt) <- 2010
  year(posct) <- 2010

  expect_that(is.na(poslt), is_true())
  expect_that(is.na(posct), is_true())

})

test_that("years settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  year(poslt) <- 2000
  year(posct) <- 2000
  year(date) <- 2000

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))
})


test_that("dates settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  date(poslt) <- as.Date("2000-01-01")
  date(posct) <- as.Date("2000-01-01")
  date(date) <- as.Date("2000-01-01")

  expect_that(date(poslt), equals(as.Date("2000-01-01")))
  expect_that(date(posct), equals(as.Date("2000-01-01")))
  expect_that(date(date), equals(as.Date("2000-01-01")))
})

test_that("dates settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  date(poslt) <- as.Date("2000-01-01")
  date(posct) <- as.Date("2000-01-01")
  date(date) <- as.Date("2000-01-01")

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})

test_that("dates settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2009-03-14 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  posct <- as.POSIXct(poslt)

  date(poslt) <- as.Date("2010-03-14")
  date(posct) <- as.Date("2010-03-14")

  expect_that(is.na(poslt), is_true())
  expect_that(is.na(posct), is_true())
})

test_that("dates settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  date(poslt) <- as.Date("2000-01-01")
  date(posct) <- as.Date("2000-01-01")
  date(date) <- as.Date("2000-01-01")

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))
})


test_that("time zone settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  tz(poslt) <- "GMT"
  tz(posct) <- "GMT"
  tz(date) <- "GMT" # dates do not have a tz attribute

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "UTC")
})


test_that("time zone settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 02:30:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)

  tz(poslt) <- "America/New_York"
  tz(posct) <- "America/New_York"

  expect_that(is.na(poslt), is_true())
  expect_that(is.na(posct), is_true())

})

test_that("time zone settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  tz(poslt) <- "GMT"
  tz(posct) <- "GMT"
  tz(date) <- "GMT"

  expect_that(poslt, is_a("POSIXlt"))
  expect_that(posct, is_a("POSIXct"))
  expect_that(date, is_a("Date"))
})


test_that("settors handle vectors", {
  poslt <- as.POSIXlt(c("2010-02-14 01:59:59", "2010-02-15 01:59:59", "2010-02-16 01:59:59"),
                      tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 1
  second(posct) <- 1
  second(date) <- 1

  expect_that(second(poslt), equals(c(1, 1, 1)))
  expect_that(second(posct), equals(c(1, 1, 1)))
  expect_that(second(date), equals(c(1, 1, 1)))

  minute(poslt) <- 1
  minute(posct) <- 1
  minute(date) <- 1

  expect_that(minute(poslt), equals(c(1, 1, 1)))
  expect_that(minute(posct), equals(c(1, 1, 1)))
  expect_that(minute(date), equals(c(1, 1, 1)))

  hour(poslt) <- 1
  hour(posct) <- 1
  hour(date) <- 1

  expect_that(hour(poslt), equals(c(1, 1, 1)))
  expect_that(hour(posct), equals(c(1, 1, 1)))
  expect_that(hour(date), equals(c(1, 1, 1)))

  mday(poslt) <- 1
  mday(posct) <- 1
  mday(date) <- 1

  expect_that(mday(poslt), equals(c(1, 1, 1)))
  expect_that(mday(posct), equals(c(1, 1, 1)))
  expect_that(mday(date), equals(c(1, 1, 1)))

  wday(poslt) <- 1
  wday(posct) <- 1
  wday(date) <- 1

  expect_that(wday(poslt), equals(c(1, 1, 1)))
  expect_that(wday(posct), equals(c(1, 1, 1)))
  expect_that(wday(date), equals(c(1, 1, 1)))

  yday(poslt) <- 1
  yday(posct) <- 1
  yday(date) <- 1

  expect_that(yday(poslt), equals(c(1, 1, 1)))
  expect_that(yday(posct), equals(c(1, 1, 1)))
  expect_that(yday(date), equals(c(1, 1, 1)))

  week(poslt) <- 2
  week(posct) <- 2
  week(date) <- 2

  expect_that(week(poslt), equals(c(2, 2, 2)))
  expect_that(week(posct), equals(c(2, 2, 2)))
  expect_that(week(date), equals(c(2, 2, 2)))

  month(poslt) <- 10
  month(posct) <- 10
  month(date) <- 10

  expect_that(month(poslt), equals(c(10, 10, 10)))
  expect_that(month(posct), equals(c(10, 10, 10)))
  expect_that(month(date), equals(c(10, 10, 10)))

  year(poslt) <- 2001
  year(posct) <- 2001
  year(date) <- 2001

  expect_that(year(poslt), equals(c(2001, 2001, 2001)))
  expect_that(year(posct), equals(c(2001, 2001, 2001)))
  expect_that(year(date), equals(c(2001, 2001, 2001)))

  date(poslt) <- as.Date("2001-01-01")
  date(posct) <- as.Date("2001-01-01")
  date(date) <- as.Date("2001-01-01")

  expect_that(date(poslt), equals(as.Date(c("2001-01-01", "2001-01-01", "2001-01-01"))))
  expect_that(date(posct), equals(as.Date(c("2001-01-01", "2001-01-01", "2001-01-01"))))
  expect_that(date(date), equals(as.Date(c("2001-01-01", "2001-01-01", "2001-01-01"))))

  tz(poslt) <- "GMT"
  tz(posct) <- "GMT"
  tz(date) <- "GMT" # date has been made POSIXlt with sec, etc

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "GMT")
  })

test_that("qdays settors correctly performs simple updates and rolls over as expected", {
  poslt <- as.POSIXlt(c("2010-02-14 01:59:59", "2010-04-15 01:59:59", "2010-10-16
  01:59:59"), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  qday(poslt) <- 2
  qday(posct) <- 2
  qday(date) <- 2

  expect_equal(month(poslt), c(1, 4, 10))
  expect_equal(month(posct), c(1, 4, 10))
  expect_equal(month(date), c(1, 4, 10))

  expect_equal(mday(poslt), c(2, 2, 2))
  expect_equal(mday(posct), c(2, 2, 2))
  expect_equal(mday(date), c(2, 2, 2))

  qday(poslt) <- 95
  qday(posct) <- 95
  qday(date) <- 95

  expect_equal(month(poslt), c(4, 7, 1))
  expect_equal(month(posct), c(4, 7, 1))
  expect_equal(month(date), c(4, 7, 1))

  expect_equal(mday(poslt), c(5, 4, 3))
  expect_equal(mday(posct), c(5, 4, 3))
  expect_equal(mday(date), c(5, 4, 3))

  expect_equal(year(poslt), c(2010, 2010, 2011))
  expect_equal(year(posct), c(2010, 2010, 2011))
  expect_equal(year(date), c(2010, 2010, 2011))
})
