context("accessor tests")

test_that("seconds accessor extracts correct second",{
	poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
		 = "%Y-%m-%d %H:%M:%S")
	posct <- as.POSIXct(poslt)
	date <- as.Date(poslt)
	
	expect_that(second(poslt), equals(59))
	expect_that(second(posct), equals(59))
	expect_that(second(date), equals(59))

})

test_that("minutes accessor extracts correct minute",{
	poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
		 = "%Y-%m-%d %H:%M:%S")
	posct <- as.POSIXct(poslt)
	date <- as.Date(poslt)
	
	expect_that(minute(poslt), equals(45))
	expect_that(minute(posct), equals(45))
	expect_that(minute(date), equals(45))

})

test_that("hours accessor extracts correct hour",{
	poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
		 = "%Y-%m-%d %H:%M:%S")
	posct <- as.POSIXct(poslt)
	date <- as.Date(poslt)
	
	expect_that(hour(poslt), equals(13))
	expect_that(hour(posct), equals(13))
	expect_that(hour(date), equals(13))

})

test_that("days accessors extract correct days",{
	poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
		 = "%Y-%m-%d %H:%M:%S")
	posct <- as.POSIXct(poslt)
	date <- as.Date(poslt)
	
	expect_that(day(poslt), equals(3))
	expect_that(day(posct), equals(3))
	expect_that(day(date), equals(3))
	
	expect_that(mday(poslt), equals(3))
	expect_that(mday(posct), equals(3))
	expect_that(mday(date), equals(3))
	
	expect_that(yday(poslt), equals(34))
	expect_that(yday(posct), equals(34))
	expect_that(yday(date), equals(34))
	
	expect_that(wday(poslt), equals(4))
	expect_that(wday(posct), equals(4))
	expect_that(wday(date), equals(4))
})

test_that("weeks accessor extracts correct week",{
	poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
		 = "%Y-%m-%d %H:%M:%S")
	posct <- as.POSIXct(poslt)
	date <- as.Date(poslt)
	
	expect_that(week(poslt), equals(5))
	expect_that(week(posct), equals(5))
	expect_that(week(date), equals(5))

})

test_that("months accessor extracts correct month",{
	poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
		 = "%Y-%m-%d %H:%M:%S")
	posct <- as.POSIXct(poslt)
	date <- as.Date(poslt)
	
	expect_that(month(poslt), equals(2))
	expect_that(month(posct), equals(2))
	expect_that(month(date), equals(2))

})

test_that("years accessor extracts correct year",{
	poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
		 = "%Y-%m-%d %H:%M:%S")
	posct <- as.POSIXct(poslt)
	date <- as.Date(poslt)
	
	expect_that(year(poslt), equals(2010))
	expect_that(year(posct), equals(2010))
	expect_that(year(date), equals(2010))

})

test_that("timezone accessor extracts correct timezone",{
	poslt <- as.POSIXlt("2010-02-03 13:45:59", tz = "UTC", format
		 = "%Y-%m-%d %H:%M:%S")
	posct <- as.POSIXct(poslt)
	date <- as.Date(poslt)
	
	expect_that(tz(poslt), matches("UTC"))
	expect_that(tz(posct), matches("UTC"))
	expect_that(tz(date), matches("UTC"))

})


test_that("accessors handle vectors",{ 
	poslt <- c(as.POSIXlt("2001-01-01 01:01:01", tz = "UTC", format =
		"%Y-%m-%d %H:%M:%S"), as.POSIXlt("2002-02-02 02:02:02", tz = 
		"UTC", format = "%Y-%m-%d %H:%M:%S"), as.POSIXlt("2003-03-03 
		03:03:03", tz = "UTC", format = "%Y-%m-%d %H:%M:%S"))
	posct <- as.POSIXct(poslt)
	date <- as.Date(poslt)
	
	expect_that(second(poslt), equals(c(1,2,3)))
	expect_that(second(posct), equals(c(1,2,3)))
	expect_that(second(date), equals(c(1,2,3)))
	
	expect_that(minute(poslt), equals(c(1,2,3)))
	expect_that(minute(posct), equals(c(1,2,3)))
	expect_that(minute(date), equals(c(1,2,3)))
	
	expect_that(hour(poslt), equals(c(1,2,3)))
	expect_that(hour(posct), equals(c(1,2,3)))
	expect_that(hour(date), equals(c(1,2,3)))
	
	expect_that(mday(poslt), equals(c(1,2,3)))
	expect_that(mday(posct), equals(c(1,2,3)))
	expect_that(mday(date), equals(c(1,2,3)))
	
	expect_that(wday(poslt), equals(c(1,6,1)))
	expect_that(wday(posct), equals(c(1,6,1)))
	expect_that(wday(date), equals(c(1,6,1)))
	
	expect_that(yday(poslt), equals(c(1,33,62)))
	expect_that(yday(posct), equals(c(1,33,62)))
	expect_that(yday(date), equals(c(1,33,62)))
	
	expect_that(week(poslt), equals(c(1,5,9)))
	expect_that(week(posct), equals(c(1,5,9)))
	expect_that(week(date), equals(c(1,5,9)))
	
	expect_that(month(poslt), equals(c(1,2,3)))
	expect_that(month(posct), equals(c(1,2,3)))
	expect_that(month(date), equals(c(1,2,3)))
	
	expect_that(year(poslt), equals(c(2001,2002,2003)))
	expect_that(year(posct), equals(c(2001,2002,2003)))
	expect_that(year(date), equals(c(2001,2002,2003)))
	
	expect_that(tz(poslt), matches("UTC"))
	expect_that(tz(posct), matches("UTC"))
	expect_that(tz(date), matches("UTC"))
})

