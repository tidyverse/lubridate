test_that("seconds settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 10
  second(posct) <- 10
  second(date) <- 10

  expect_equal(second(poslt), 10)
  expect_equal(second(posct), 10)
  expect_equal(second(date), 10)
})

test_that("seconds settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 69
  second(posct) <- 69
  second(date) <- 69

  expect_equal(second(poslt), 9)
  expect_equal(minute(poslt), 0)
  expect_equal(hour(poslt), 0)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 9)
  expect_equal(minute(posct), 0)
  expect_equal(hour(posct), 0)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 9)
  expect_equal(minute(date), 1)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 31)
  expect_equal(wday(date), 6)
  expect_equal(yday(date), 365)
  expect_equal(month(date), 12)
  expect_equal(year(date), 2010)
  expect_equal(tz(date), "UTC")
})

test_that("seconds settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
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
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posxct <- as.POSIXct(poslt)

  second(poslt) <- 69
  second(posxct) <- 69

  expect_true(is.na(poslt))
  expect_true(is.na(posxct))
})

test_that("seconds settor retains object class for datetimes", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)

  second(poslt) <- 10
  second(posct) <- 10

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")

  second(poslt) <- 70
  second(posct) <- 70

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
})

test_that("seconds settor makes POSTXct from Date", {
  date <- as.Date("2010-02-14", tz = "GMT", format = "%Y-%m-%d")

  second(date) <- 10

  expect_s3_class(date, "POSIXct")

  second(date) <- 70

  expect_s3_class(date, "POSIXct")
})


test_that("minutes settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  minute(poslt) <- 10
  minute(posct) <- 10
  minute(date) <- 10

  expect_equal(minute(poslt), 10)
  expect_equal(minute(posct), 10)
  expect_equal(minute(date), 10)
})

test_that("minutes settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  minute(poslt) <- 69
  minute(posct) <- 69
  minute(date) <- 69

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 9)
  expect_equal(hour(poslt), 0)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 9)
  expect_equal(hour(posct), 0)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 9)
  expect_equal(hour(date), 1)
  expect_equal(mday(date), 31)
  expect_equal(wday(date), 6)
  expect_equal(yday(date), 365)
  expect_equal(month(date), 12)
  expect_equal(year(date), 2010)
  expect_equal(tz(date), "UTC")
})

test_that("minutes settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
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
  poslt <- as.POSIXlt("2010-03-14 01:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  minute(poslt) <- 70
  minute(posct) <- 70

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("minutes settor retains object class for datetimes", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)

  minute(poslt) <- 1
  minute(posct) <- 1

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")

  minute(poslt) <- 70
  minute(posct) <- 70

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
})

test_that("minutes settor makes POSIXct from Date", {
  date <- as.Date("2010-02-14", tz = "GMT", format = "%Y-%m-%d")

  minute(date) <- 70

  expect_s3_class(date, "POSIXct")
})


test_that("hours settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 10
  hour(posct) <- 10
  hour(date) <- 10

  expect_equal(hour(poslt), 10)
  expect_equal(hour(posct), 10)
  expect_equal(hour(date), 10)
})

test_that("hours settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  hour(poslt) <- 25
  hour(posct) <- 25
  hour(date) <- 25

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 1)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 1)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 1)
  expect_equal(mday(date), 1)
  expect_equal(wday(date), 7)
  expect_equal(yday(date), 1)
  expect_equal(month(date), 01)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")
})

test_that("hours settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format = "%Y-%m-%d %H:%M:%S")
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
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  hour(poslt) <- 2
  hour(posct) <- 2

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("hours settor retains object class for datetimes", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59", tz = "GMT", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)

  hour(poslt) <- 2
  hour(posct) <- 2

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")

  hour(poslt) <- 25
  hour(posct) <- 25

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
})

test_that("hours settor makes POSIXct from Date", {
  date <- as.Date("2010-02-14", tz = "GMT", format = "%Y-%m-%d")

  hour(date) <- 2

  expect_s3_class(date, "POSIXct")

  hour(date) <- 25

  expect_s3_class(date, "POSIXct")
})


test_that("mdays settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 10
  mday(posct) <- 10
  mday(date) <- 10

  expect_equal(mday(poslt), 10)
  expect_equal(mday(posct), 10)
  expect_equal(mday(date), 10)

  expect_equal(yday(poslt), 41)
  expect_equal(yday(posct), 41)
  expect_equal(yday(date), 41)

  expect_equal(wday(poslt), 4)
  expect_equal(wday(posct), 4)
  expect_equal(wday(date), 4)
})

test_that("mdays settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 32
  mday(posct) <- 32
  mday(date) <- 32

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 23)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 23)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 1)
  expect_equal(wday(date), 7)
  expect_equal(yday(date), 1)
  expect_equal(month(date), 1)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")
})

test_that("mdays settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
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
  poslt <- as.POSIXlt("2010-03-13 02:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  mday(poslt) <- 14
  mday(posct) <- 14

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("mdays settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  mday(poslt) <- 3
  mday(posct) <- 3
  mday(date) <- 3

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")

  mday(poslt) <- 32
  mday(posct) <- 32
  mday(date) <- 32

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")
})



test_that("ydays settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 41
  yday(posct) <- 41
  yday(date) <- 41

  expect_equal(yday(poslt), 41)
  expect_equal(yday(posct), 41)
  expect_equal(yday(date), 41)

  expect_equal(mday(poslt), 10)
  expect_equal(mday(posct), 10)
  expect_equal(mday(date), 10)

  expect_equal(wday(poslt), 4)
  expect_equal(wday(posct), 4)
  expect_equal(wday(date), 4)
})

test_that("ydays settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 366
  yday(posct) <- 366
  yday(date) <- 366

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 23)
  expect_equal(mday(poslt), 1)
  expect_equal(wday(poslt), 7)
  expect_equal(yday(poslt), 1)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 23)
  expect_equal(mday(posct), 1)
  expect_equal(wday(posct), 7)
  expect_equal(yday(posct), 1)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 1)
  expect_equal(wday(date), 7)
  expect_equal(yday(date), 1)
  expect_equal(month(date), 1)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")
})

test_that("ydays settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
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
  poslt <- as.POSIXlt("2010-03-13 02:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  yday(poslt) <- 73
  yday(posct) <- 73

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("ydays settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  yday(poslt) <- 3
  yday(posct) <- 3
  yday(date) <- 3

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")

  yday(poslt) <- 366
  yday(posct) <- 366
  yday(date) <- 366

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")
})



test_that("wdays settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 5
  wday(posct) <- 5
  wday(date) <- 5

  expect_equal(wday(poslt), 5)
  expect_equal(wday(posct), 5)
  expect_equal(wday(date), 5)

  expect_equal(mday(poslt), 4)
  expect_equal(mday(posct), 4)
  expect_equal(mday(date), 4)

  expect_equal(mday(poslt), 4)
  expect_equal(mday(posct), 4)
  expect_equal(mday(date), 4)
})

test_that("wdays settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 8
  wday(posct) <- 8
  wday(date) <- 8

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 23)
  expect_equal(mday(poslt), 2)
  expect_equal(wday(poslt), 1)
  expect_equal(yday(poslt), 2)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 23)
  expect_equal(mday(posct), 2)
  expect_equal(wday(posct), 1)
  expect_equal(yday(posct), 2)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 2)
  expect_equal(wday(date), 1)
  expect_equal(yday(date), 2)
  expect_equal(month(date), 1)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")
})

test_that("wdays settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
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
  poslt <- as.POSIXlt("2010-03-13 02:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  wday(poslt) <- 8
  wday(posct) <- 8

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("wdays settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  wday(poslt) <- 3
  wday(posct) <- 3
  wday(date) <- 3

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")

  wday(poslt) <- 8
  wday(posct) <- 8
  wday(date) <- 8

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")
})


test_that("months settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  month(poslt) <- 5
  month(posct) <- 5
  month(date) <- 5

  expect_equal(month(poslt), 5)
  expect_equal(month(posct), 5)
  expect_equal(month(date), 5)
})

test_that("months settor rolls over as expected", {
  poslt <- as.POSIXlt("2010-12-31 23:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  month(poslt) <- 13
  month(posct) <- 13
  month(date) <- 13

  expect_equal(second(poslt), 59)
  expect_equal(minute(poslt), 59)
  expect_equal(hour(poslt), 23)
  expect_equal(mday(poslt), 31)
  expect_equal(wday(poslt), 2)
  expect_equal(yday(poslt), 31)
  expect_equal(month(poslt), 1)
  expect_equal(year(poslt), 2011)
  expect_equal(tz(poslt), "UTC")

  expect_equal(second(posct), 59)
  expect_equal(minute(posct), 59)
  expect_equal(hour(posct), 23)
  expect_equal(mday(posct), 31)
  expect_equal(wday(posct), 2)
  expect_equal(yday(posct), 31)
  expect_equal(month(posct), 1)
  expect_equal(year(posct), 2011)
  expect_equal(tz(posct), "UTC")

  expect_equal(second(date), 0)
  expect_equal(minute(date), 0)
  expect_equal(hour(date), 0)
  expect_equal(mday(date), 31)
  expect_equal(wday(date), 2)
  expect_equal(yday(date), 31)
  expect_equal(month(date), 1)
  expect_equal(year(date), 2011)
  expect_equal(tz(date), "UTC")
})

test_that("months settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
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
  poslt <- as.POSIXlt("2010-02-14 02:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  month(poslt) <- 3
  month(posct) <- 3

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("months settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  month(poslt) <- 1
  month(posct) <- 1
  month(date) <- 1

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")

  month(poslt) <- 13
  month(posct) <- 13
  month(date) <- 13

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")
})


test_that("years settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  year(poslt) <- 2000
  year(posct) <- 2000
  year(date) <- 2000

  expect_equal(year(poslt), 2000)
  expect_equal(year(posct), 2000)
  expect_equal(year(date), 2000)
})


test_that("years settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
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
  poslt <- as.POSIXlt("2009-03-14 02:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  year(poslt) <- 2010
  year(posct) <- 2010

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("years settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  year(poslt) <- 2000
  year(posct) <- 2000
  year(date) <- 2000

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")
})


test_that("dates settor correctly performs simple updates", {
  poslt <- as.POSIXlt("2010-02-03 13:45:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  date(poslt) <- as.Date("2000-01-01")
  date(posct) <- as.Date("2000-01-01")
  date(date) <- as.Date("2000-01-01")

  expect_equal(date(poslt), as.Date("2000-01-01"))
  expect_equal(date(posct), as.Date("2000-01-01"))
  expect_equal(date(date), as.Date("2000-01-01"))
})

test_that("dates settor does not change time zone", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
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
  poslt <- as.POSIXlt("2009-03-14 02:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  poslt <- force_tz(poslt, tzone = "America/New_York")
  posct <- as.POSIXct(poslt)

  date(poslt) <- as.Date("2010-03-14")
  date(posct) <- as.Date("2010-03-14")

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("dates settor retains object class", {
  poslt <- as.POSIXlt("2010-02-14 01:59:59",
    tz = "GMT", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  date(poslt) <- as.Date("2000-01-01")
  date(posct) <- as.Date("2000-01-01")
  date(date) <- as.Date("2000-01-01")

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "Date")
})


test_that("time zone settor correctly performs simple updates", {
  posct <- ymd_hms("2010-02-03 13:45:59", tz = "UTC")
  poslt <- as.POSIXlt(posct)
  date <- as.Date(posct)

  tz(poslt) <- "GMT"
  tz(posct) <- "GMT"
  tz(date) <- "GMT"

  expect_s3_class(poslt, "POSIXlt")
  expect_s3_class(posct, "POSIXct")
  expect_s3_class(date, "POSIXct")

  expect_match(tz(poslt), "GMT")
  expect_match(tz(posct), "GMT")
  expect_match(tz(date), "GMT")
})

test_that("time zone settor returns NA for spring dst gap", {
  poslt <- as.POSIXlt("2010-03-14 02:30:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)

  tz(poslt) <- "America/New_York"
  tz(posct) <- "America/New_York"

  expect_true(is.na(poslt))
  expect_true(is.na(posct))
})

test_that("settors handle vectors", {
  poslt <- as.POSIXlt(c("2010-02-14 01:59:59", "2010-02-15 01:59:59", "2010-02-16 01:59:59"),
    tz = "UTC", format = "%Y-%m-%d %H:%M:%S"
  )
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)

  second(poslt) <- 1
  second(posct) <- 1
  second(date) <- 1

  expect_equal(second(poslt), c(1, 1, 1))
  expect_equal(second(posct), c(1, 1, 1))
  expect_equal(second(date), c(1, 1, 1))

  minute(poslt) <- 1
  minute(posct) <- 1
  minute(date) <- 1

  expect_equal(minute(poslt), c(1, 1, 1))
  expect_equal(minute(posct), c(1, 1, 1))
  expect_equal(minute(date), c(1, 1, 1))

  hour(poslt) <- 1
  hour(posct) <- 1
  hour(date) <- 1

  expect_equal(hour(poslt), c(1, 1, 1))
  expect_equal(hour(posct), c(1, 1, 1))
  expect_equal(hour(date), c(1, 1, 1))

  mday(poslt) <- 1
  mday(posct) <- 1
  mday(date) <- 1

  expect_equal(mday(poslt), c(1, 1, 1))
  expect_equal(mday(posct), c(1, 1, 1))
  expect_equal(mday(date), c(1, 1, 1))

  wday(poslt) <- 1
  wday(posct) <- 1
  wday(date) <- 1

  expect_equal(wday(poslt), c(1, 1, 1))
  expect_equal(wday(posct), c(1, 1, 1))
  expect_equal(wday(date), c(1, 1, 1))

  yday(poslt) <- 1
  yday(posct) <- 1
  yday(date) <- 1

  expect_equal(yday(poslt), c(1, 1, 1))
  expect_equal(yday(posct), c(1, 1, 1))
  expect_equal(yday(date), c(1, 1, 1))

  week(poslt) <- 2
  week(posct) <- 2
  week(date) <- 2

  expect_equal(week(poslt), c(2, 2, 2))
  expect_equal(week(posct), c(2, 2, 2))
  expect_equal(week(date), c(2, 2, 2))

  month(poslt) <- 10
  month(posct) <- 10
  month(date) <- 10

  expect_equal(month(poslt), c(10, 10, 10))
  expect_equal(month(posct), c(10, 10, 10))
  expect_equal(month(date), c(10, 10, 10))

  year(poslt) <- 2001
  year(posct) <- 2001
  year(date) <- 2001

  expect_equal(year(poslt), c(2001, 2001, 2001))
  expect_equal(year(posct), c(2001, 2001, 2001))
  expect_equal(year(date), c(2001, 2001, 2001))

  date(poslt) <- as.Date("2001-01-01")
  date(posct) <- as.Date("2001-01-01")
  date(date) <- as.Date("2001-01-01")

  expect_equal(date(poslt), as.Date(c("2001-01-01", "2001-01-01", "2001-01-01")))
  expect_equal(date(posct), as.Date(c("2001-01-01", "2001-01-01", "2001-01-01")))
  expect_equal(date(date), as.Date(c("2001-01-01", "2001-01-01", "2001-01-01")))

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


test_that("year<- and month<- roll but produce NAs on invalid days",  {
  dd <- ymd(c("2020-02-29", "2020-03-31"))
  pp <- ymd(c("2020-02-29", "2020-03-31"), tz = "America/New_York")

  dd1 <- dd
  year(dd1) <- 2021
  expect_equal(dd1, ymd(c(NA, "2021-03-31")))

  dd1 <- dd
  month(dd1) <- 4
  expect_equal(dd1, ymd(c("2020-04-29", NA)))

  dd1 <- dd
  month(dd1) <- 15
  expect_equal(dd1, ymd(c("2021-03-29", "2021-03-31")))

  dd1 <- dd
  month(dd1) <- 14
  expect_equal(dd1, ymd(c(NA, NA)))

  dd1 <- dd
  yday(dd1) <- 370
  expect_equal(dd1, ymd(c("2021-01-04", "2021-01-04")))

  dd1 <- dd
  day(dd1) <- c(30, 32)
  expect_equal(dd1, ymd(c("2020-03-01", "2020-04-01")))

  # update recycles instead of producing NAs
  expect_equal(
    update(dd, months = 4),
    ymd(c("2020-04-29", "2020-05-01")))
  expect_equal(
    update(dd, days = 31),
    ymd(c("2020-03-02", "2020-03-31")))
  expect_equal(
    update(dd, months = 4, days = 32),
    ymd(c("2020-05-02", "2020-05-02")))

  expect_equal(
    update(pp, months = 4),
    ymd(c("2020-04-29", "2020-05-01"), tz = "America/New_York"))
  expect_equal(
    update(pp, days = 31),
    ymd(c("2020-03-02", "2020-03-31"), tz = "America/New_York"))
  expect_equal(
    update(pp, months = 4, days = 32),
    ymd(c("2020-05-02", "2020-05-02"), tz = "America/New_York"))

})

test_that("year<- update rolls over dates but not update", {

  x <- ymd("2020-02-29")
  expect_equal(update(x, years = 2019), ymd("2019-03-01"))
  year(x) <- 2017
  expect_equal(x, NA_Date_)

  x <- ymd("2020-02-29", tz = "America/New_York")
  expect_equal(update(x, years = 2019), ymd("2019-03-01", tz = "America/New_York"))
  year(x) <- 2017
  expect_equal(x, with_tz(NA_POSIXct_, "America/New_York"))

})

test_that("day<- rolls over", {

  x <- ymd("2017-02-20")
  expect_equal(update(x, days = 29), ymd("2017-03-01"))
  expect_equal(update(x, days = 100), ymd("2017-05-11"))
  day(x) <- 29
  expect_equal(x, ymd("2017-03-01"))
  x <- ymd("2017-02-20")
  day(x) <- 100
  expect_equal(x, ymd("2017-05-11"))

  x <- ymd("2017-02-20", tz = "America/New_York")
  expect_equal(update(x, mdays = 29), ymd("2017-03-01", tz = "America/New_York"))
  expect_equal(update(x, mdays = 100), ymd("2017-05-11", tz = "America/New_York"))
  day(x) <- 29
  expect_equal(x, ymd("2017-03-01", tz = "America/New_York"))
  x <- ymd("2017-02-20", tz = "America/New_York")
  day(x) <- 100
  expect_equal(x, ymd("2017-05-11", tz = "America/New_York"))

})
