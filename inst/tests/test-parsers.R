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




test_that("ymd.hms correctly throw errors", {
	
	expect_that(ymd.hms(20100102235959), throws_error())
	expect_that(ymd.hms("2010-01-023 23:59:59"), throws_error())
})

test_that("ymd.hms correctly handles a variety of formats", {
	expect_that(ymd.hms("2010-01-02 23:59:59"), equals(as.POSIXct(
		"2010-01-02 23:59:59", tz = "UTC")))
	expect_that(ymd.hms("2010,01,02 23.59.59"), equals(as.POSIXct(
		"2010-01-02 23:59:59", tz = "UTC")))
	expect_that(ymd.hms("2010/01/02 23/59/59"), equals(as.POSIXct(
		"2010-01-02 23:59:59", tz = "UTC")))
	expect_that(ymd.hms("2010:01:02-23:59:59"), equals(as.POSIXct(
		"2010-01-02 23:59:59", tz = "UTC")))
	expect_that(ymd.hms("2010-01-02 23:59:61"), equals(as.POSIXct(
		"2010-01-03 00:00:01", tz = "UTC")))
	expect_that(ymd.hms(c("2010-01-02 23:59:61", 
		"2010-01-02 00:00:00")), equals(as.POSIXct(
		c("2010-01-03 00:00:01", "2010-01-02 00:00:00"), tz = 
		"UTC")))
	expect_that(ymd.hms("10-01-02 23:59:59"), equals(as.POSIXct(
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
		"incorrect number of elements"))	
	expect_that(hms("03:03"), throws_error(
		"incorrect number of elements"))	
	expect_that(ms("03:02:01"), throws_error(
		"incorrect number of elements"))	
	expect_that(ms("03"), throws_error(
		"incorrect number of elements"))		
	expect_that(hm("03:03:01"), throws_error(
		"incorrect number of elements"))	
	expect_that(hm("03"), throws_error(
		"incorrect number of elements"))	
})







