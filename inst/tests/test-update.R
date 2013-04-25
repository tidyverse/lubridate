context("Updating dates")

test_that("update.Date returns a date object",{
  date <- as.Date("05/05/2010", "%m/%d/%Y")
  
  expect_that(update(date, days = 1), is_a("Date"))
  expect_that(update(date, yday = 1), is_a("Date"))
  expect_that(update(date, mday = 1), is_a("Date"))
  expect_that(update(date, wday = 1), is_a("Date"))
  expect_that(update(date, month = 1), is_a("Date"))
  expect_that(update(date, year = 2001), is_a("Date"))
  expect_that(update(date, tz = "UTC"), is_a("Date"))
})
 
test_that("update.Date returns a posix object if time is manipulated",{
  date <- as.Date("05/05/2010", "%m/%d/%Y")
  
  expect_that(update(date, seconds = 1), is_a("POSIXt"))
  expect_that(update(date, minutes = 1), is_a("POSIXt"))
  expect_that(update(date, hours = 1), is_a("POSIXt"))
})

test_that("update.POSIXlt returns a POSIXlt object",{ 
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  
  expect_that(update(poslt, seconds = 1), is_a("POSIXlt"))
  expect_that(update(poslt, minutes = 1), is_a("POSIXlt"))
  expect_that(update(poslt, hours = 1), is_a("POSIXlt"))
  expect_that(update(poslt, days = 1), is_a("POSIXlt"))
  expect_that(update(poslt, yday = 1), is_a("POSIXlt"))
  expect_that(update(poslt, mday = 1), is_a("POSIXlt"))
  expect_that(update(poslt, wday = 1), is_a("POSIXlt"))
  expect_that(update(poslt, month = 1), is_a("POSIXlt"))
  expect_that(update(poslt, year = 2001), is_a("POSIXlt"))
  expect_that(update(poslt, tz = "UTC"), is_a("POSIXlt"))
})

test_that("update.POSIXct returns a POSIXct object",{
  posct <- as.POSIXct("2010-02-03 13:45:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  
  expect_that(update(posct, seconds = 1), is_a("POSIXct"))
  expect_that(update(posct, minutes = 1), is_a("POSIXct"))
  expect_that(update(posct, hours = 1), is_a("POSIXct"))
  expect_that(update(posct, days = 1), is_a("POSIXct"))
  expect_that(update(posct, yday = 1), is_a("POSIXct"))
  expect_that(update(posct, mday = 1), is_a("POSIXct"))
  expect_that(update(posct, wday = 1), is_a("POSIXct"))
  expect_that(update(posct, month = 1), is_a("POSIXct"))
  expect_that(update(posct, year = 2001), is_a("POSIXct"))
  expect_that(update(posct, tz = "UTC"), is_a("POSIXct"))
})

test_that("update.Date performs simple operation as expected",{ 
  date <- as.Date("05/05/2010", "%m/%d/%Y")
  
  expect_that(second(update(date, seconds = 1)), equals(1))
  expect_that(minute(update(date, minutes = 1)), equals(1))
  expect_that(hour(update(date, hours = 1)), equals(1))
  expect_that(mday(update(date, mday = 1)), equals(1))
  expect_that(wday(update(date, mday = 1)), equals(7))
  expect_that(yday(update(date, mday = 1)), equals(121))
  expect_that(yday(update(date, yday = 1)), equals(1))
  expect_that(mday(update(date, yday = 1)), equals(1))
  expect_that(wday(update(date, yday = 1)), equals(6))
  expect_that(wday(update(date, wday = 1)), equals(1))
  expect_that(yday(update(date, wday = 1)), equals(122))
  expect_that(mday(update(date, wday = 1)), equals(2))
  expect_that(month(update(date, months = 1)), equals(1))
  expect_that(year(update(date, years = 2000)), equals(2000))
  expect_that(tz(update(date, tz = "UTC")), matches("UTC"))
})

test_that("update.POSIXt performs simple operation as expected",{ 
  poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct("2010-02-03 13:45:59", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  
  expect_that(second(update(poslt, seconds = 1)), equals(1))
  expect_that(minute(update(poslt, minutes = 1)), equals(1))
  expect_that(hour(update(poslt, hours = 1)), equals(1))
  expect_that(mday(update(poslt, mday = 1)), equals(1))
  expect_that(wday(update(poslt, mday = 1)), equals(2))
  expect_that(yday(update(poslt, mday = 1)), equals(32))
  expect_that(yday(update(poslt, yday = 1)), equals(1))
  expect_that(mday(update(poslt, yday = 1)), equals(1))
  expect_that(wday(update(poslt, yday = 1)), equals(6))
  expect_that(wday(update(poslt, wday = 1)), equals(1))
  expect_that(yday(update(poslt, wday = 1)), equals(31))
  expect_that(mday(update(poslt, wday = 1)), equals(31))
  expect_that(month(update(poslt, months = 1)), equals(1))
  expect_that(year(update(poslt, years = 2000)), equals(2000))
  expect_that(tz(update(poslt, tz = "UTC")), matches("UTC"))
  
  expect_that(second(update(posct, seconds = 1)), equals(1))
  expect_that(minute(update(posct, minutes = 1)), equals(1))
  expect_that(hour(update(posct, hours = 1)), equals(1))
  expect_that(mday(update(posct, mday = 1)), equals(1))
  expect_that(wday(update(posct, mday = 1)), equals(2))
  expect_that(yday(update(posct, mday = 1)), equals(32))
  expect_that(yday(update(posct, yday = 1)), equals(1))
  expect_that(mday(update(posct, yday = 1)), equals(1))
  expect_that(wday(update(posct, yday = 1)), equals(6))
  expect_that(wday(update(posct, wday = 1)), equals(1))
  expect_that(yday(update(posct, wday = 1)), equals(31))
  expect_that(mday(update(posct, wday = 1)), equals(31))
  expect_that(month(update(posct, months = 1)), equals(1))
  expect_that(year(update(posct, years = 2000)), equals(2000))
  expect_that(tz(update(posct, tz = "UTC")), matches("UTC"))
})


test_that("update performs roll overs correctly for Date objects",{
  date <- as.Date("05/05/2010", "%m/%d/%Y")
  
  expect_that(second(update(date, seconds = 61)), equals(1))
  expect_that(minute(update(date, seconds = 61)), equals(1))
  
  expect_that(minute(update(date, minutes = 61)), equals(1))
  expect_that(hour(update(date, minutes = 61)), equals(1))
  
  expect_that(hour(update(date, hours = 25)), equals(1))
  expect_that(mday(update(date, hours = 25)), equals(6))
  expect_that(yday(update(date, hours = 25)), equals(126))
  expect_that(wday(update(date, hours = 25)), equals(5))
  
  expect_that(mday(update(date, mday = 32)), equals(1))
  expect_that(month(update(date, mday = 32)), equals(6))
  
  expect_that(wday(update(date, wday = 31)), equals(3))
  expect_that(month(update(date, wday = 31)), equals(6))
  
  expect_that(yday(update(date, yday = 366)), equals(1))
  expect_that(month(update(date, yday = 366)), equals(1))
  
  expect_that(month(update(date, month = 13)), equals(1))
  expect_that(year(update(date, month = 13)), equals(2011))
  expect_that(tz(update(date, month = 13)), matches("UTC")) 
})

test_that("update performs roll overs correctly for POSIXlt objects",{ 
  poslt <- as.POSIXlt("2010-05-05 00:00:00", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  
  expect_that(second(update(poslt, seconds = 61)), equals(1))
  expect_that(minute(update(poslt, seconds = 61)), equals(1))
  
  expect_that(minute(update(poslt, minutes = 61)), equals(1))
  expect_that(hour(update(poslt, minutes = 61)), equals(1))
  
  expect_that(hour(update(poslt, hours = 25)), equals(1))
  expect_that(mday(update(poslt, hours = 25)), equals(6))
  expect_that(yday(update(poslt, hours = 25)), equals(126))
  expect_that(wday(update(poslt, hours = 25)), equals(5))
  
  expect_that(mday(update(poslt, mday = 32)), equals(1))
  expect_that(month(update(poslt, mday = 32)), equals(6))
  
  expect_that(wday(update(poslt, wday = 31)), equals(3))
  expect_that(month(update(poslt, wday = 31)), equals(6))
  
  expect_that(yday(update(poslt, yday = 366)), equals(1))
  expect_that(month(update(poslt, yday = 366)), equals(1))
  
  expect_that(month(update(poslt, month = 13)), equals(1))
  expect_that(year(update(poslt, month = 13)), equals(2011))
  expect_that(tz(update(poslt, month = 13)), matches("GMT"))
})

test_that("update performs roll overs correctly for POSIXct objects",{ 
  posct <- as.POSIXct("2010-05-05 00:00:00", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  
  expect_that(second(update(posct, seconds = 61)), equals(1))
  expect_that(minute(update(posct, seconds = 61)), equals(1))
  
  expect_that(minute(update(posct, minutes = 61)), equals(1))
  expect_that(hour(update(posct, minutes = 61)), equals(1))
  
  expect_that(hour(update(posct, hours = 25)), equals(1))
  expect_that(mday(update(posct, hours = 25)), equals(6))
  expect_that(yday(update(posct, hours = 25)), equals(126))
  expect_that(wday(update(posct, hours = 25)), equals(5))
  
  expect_that(mday(update(posct, mday = 32)), equals(1))
  expect_that(month(update(posct, mday = 32)), equals(6))
  
  expect_that(wday(update(posct, wday = 31)), equals(3))
  expect_that(month(update(posct, wday = 31)), equals(6))
  
  expect_that(yday(update(posct, yday = 366)), equals(1))
  expect_that(month(update(posct, yday = 366)), equals(1))
  
  expect_that(month(update(posct, month = 13)), equals(1))
  expect_that(year(update(posct, month = 13)), equals(2011))
  expect_that(tz(update(posct, month = 13)), matches("GMT"))
})

test_that("update performs consecutive roll overs correctly for 
  Date objects regardless of order",{ 
  date <- update(as.Date("11/01/2010", "%m/%d/%Y"),
    months = 13, days = 32, hours = 25, minutes = 61, seconds
     = 61)
  
  expect_that(second(date), equals(1))
  expect_that(minute(date), equals(2))
  expect_that(hour(date), equals(2))
  expect_that(mday(date), equals(2))
  expect_that(wday(date), equals(4))
  expect_that(yday(date), equals(33))
  expect_that(month(date), equals(2))
  expect_that(year(date), equals(2011))
  expect_that(tz(date), matches("UTC"))
  
  date2 <- update(as.Date("11/01/2010", "%m/%d/%Y"),
    seconds = 61, minutes = 61, hours = 25, days = 32, months
     = 13)
  
  expect_that(second(date2), equals(1))
  expect_that(minute(date2), equals(2))
  expect_that(hour(date2), equals(2))
  expect_that(mday(date2), equals(2))
  expect_that(wday(date2), equals(4))
  expect_that(yday(date2), equals(33))
  expect_that(month(date2), equals(2))
  expect_that(year(date2), equals(2011))
  expect_that(tz(date2), matches("UTC"))
})

test_that("update performs consecutive roll overs correctly for 
  POSIXlt objects",{ 
  posl <- as.POSIXlt("2010-11-01 00:00:00", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- update(posl, months = 13, days = 32, hours = 25, 
    minutes = 61, seconds = 61)
  
  expect_that(second(poslt), equals(1))
  expect_that(minute(poslt), equals(2))
  expect_that(hour(poslt), equals(2))
  expect_that(mday(poslt), equals(2))
  expect_that(wday(poslt), equals(4))
  expect_that(yday(poslt), equals(33))
  expect_that(month(poslt), equals(2))
  expect_that(year(poslt), equals(2011))
  expect_that(tz(poslt), matches("GMT"))
  
  poslt2 <- update(posl, seconds = 61, minutes = 61, hours = 25, 
    days = 32, months = 13)
  
  expect_that(second(poslt2), equals(1))
  expect_that(minute(poslt2), equals(2))
  expect_that(hour(poslt2), equals(2))
  expect_that(mday(poslt2), equals(2))
  expect_that(wday(poslt2), equals(4))
  expect_that(yday(poslt2), equals(33))
  expect_that(month(poslt2), equals(2))
  expect_that(year(poslt2), equals(2011))
  expect_that(tz(poslt2), matches("GMT"))
})

test_that("update performs consecutive roll overs correctly for POSIXct objects",{ 
  posc <- as.POSIXct("2010-11-01 00:00:00", tz = "GMT", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- update(posc, months = 13, days = 32, hours = 25, 
    minutes = 61, seconds = 61)
  
  expect_that(second(posct), equals(1))
  expect_that(minute(posct), equals(2))
  expect_that(hour(posct), equals(2))
  expect_that(mday(posct), equals(2))
  expect_that(wday(posct), equals(4))
  expect_that(yday(posct), equals(33))
  expect_that(month(posct), equals(2))
  expect_that(year(posct), equals(2011))
  expect_that(tz(posct), matches("GMT"))
  
  posct2 <- update(posc, seconds = 61, minutes = 61, hours = 25, 
    days = 32, months = 13)
  
  expect_that(second(posct2), equals(1))
  expect_that(minute(posct2), equals(2))
  expect_that(hour(posct2), equals(2))
  expect_that(mday(posct2), equals(2))
  expect_that(wday(posct2), equals(4))
  expect_that(yday(posct2), equals(33))
  expect_that(month(posct2), equals(2))
  expect_that(year(posct2), equals(2011))
  expect_that(tz(posct2), matches("GMT"))
})



test_that("update returns NA for date-times in the spring dst gap",{ 
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
     
  expect_that(is.na(update(poslt, seconds = 61)), is_true())
  expect_that(is.na(update(poslt, minutes = 61)), is_true())
  expect_that(is.na(update(poslt, hours = 2)), is_true())
  
  poslt <- as.POSIXlt("2010-03-13 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  
  expect_that(is.na(update(poslt, mday = 14)), is_true())
  expect_that(is.na(update(poslt, wday = 8)), is_true())
  expect_that(is.na(update(poslt, yday = 73)), is_true())
  
  poslt <- as.POSIXlt("2010-02-14 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  
  expect_that(is.na(update(poslt, months = 3)), is_true())
  
  poslt <- as.POSIXlt("2009-03-14 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  poslt <- force_tz(poslt, tz = "America/New_York")
  
  expect_that(is.na(update(poslt, years = 2010)), is_true())
  
  poslt <- as.POSIXlt("2010-03-14 02:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  
  expect_that(is.na(update(poslt, tz = "America/New_York")), is_true())
})


test_that("update handles vectors of dates",{ 
  poslt <- as.POSIXlt(c("2010-02-14 01:59:59", "2010-02-15 01:59:59", "2010-02-16 
    01:59:59"), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(second(update(poslt, seconds = 1)), equals(c(1,1,1)))
  expect_that(second(update(posct, seconds = 1)), equals(c(1,1,1)))
  expect_that(day(update(date, days = 1)), equals(c(1,1,1)))

})

test_that("update handles vectors of dates and conformable vector of inputs",{ 
  poslt <- as.POSIXlt(c("2010-02-14 01:59:59", "2010-02-15 01:59:59", "2010-02-16 
    01:59:59"), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(second(update(poslt, seconds = c(1, 2, 3))), 
    equals(c(1,2,3)))
  expect_that(second(update(posct, seconds = c(1, 2, 3))), 
    equals(c(1,2,3)))
  expect_that(day(update(date, days = c(1, 2, 3))), 
    equals(c(1,2,3)))
})

# test_that("update handles gives error for non-comformable date and input vectors",{ 
#   poslt <- as.POSIXlt(c("2010-02-14 01:59:59", "2010-02-15 01:59:59", "2010-02-16 
#    01:59:59"), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")
#  posct <- as.POSIXct(poslt)
#  date <- as.Date(poslt)
  
#  expect_that(second(update(poslt, seconds = c(1, 2))), 
#    throws_error())
#  expect_that(second(update(posct, seconds = c(1, 2))), 
#    throws_error())
#  expect_that(day(update(date, days = c(1, 2))), 
#    throws_error())
# })

test_that("update handles single vector of inputs",{ 
  poslt <- as.POSIXlt("2010-03-14 01:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(second(update(poslt, seconds = c(1, 2, 3))), 
    equals(c(1,2,3)))
  expect_that(second(update(posct, seconds = c(1, 2, 3))), 
    equals(c(1,2,3)))
  expect_that(day(update(date, days = c(1, 2, 3))), 
    equals(c(1,2,3)))

})

test_that("update handles conformable vectors of inputs",{ 
  poslt <- as.POSIXlt("2010-03-10 01:59:59", tz = "UTC", format
     = "%Y-%m-%d %H:%M:%S")
  posct <- as.POSIXct(poslt)
  date <- as.Date(poslt)
  
  expect_that(second(update(poslt, seconds = c(1,2), minutes = 
    c(1,2,3,4))), equals(c(1,2,1,2)))
  expect_that(second(update(posct, seconds = c(1,2), minutes = 
    c(1,2,3,4))), equals(c(1,2,1,2)))
  expect_that(day(update(date, days = c(1,2), months = 
    c(1,2,3,4))), equals(c(1,2,1,2)))
})

# test_that("update handles gives error for non-conformable vectors of inputs",{ 
#  poslt <- as.POSIXlt("2010-03-10 01:59:59", tz = "UTC", format
#     = "%Y-%m-%d %H:%M:%S")
#  posct <- as.POSIXct(poslt)
#  date <- as.Date(poslt)
  
#  expect_that(second(update(poslt, seconds = c(1,2), minutes = 
#    c(1,2,3))), throws_error())
#  expect_that(second(update(posct, seconds = c(1,2), minutes = 
#    c(1,2,3))), throws_error())
#  expect_that(day(update(date, days = c(1,2), months = 
#    c(1,2,3))), throws_error())
# })

test_that("update.POSIXct returns input of length zero when given input of length zero",{
  x <- structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt"))
  
  expect_equal(update(x, days = 1), x)
})

test_that("update.POSIXlt returns input of length zero when given input of length zero",{
  x <- as.POSIXlt(structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt")))
  
  expect_equal(update(x, days = 1), x)
})