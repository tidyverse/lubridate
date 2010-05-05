context("utilities tests")

test_that("leap.year correctly identifies leap years",{
	x <- as.POSIXct("2009-08-03 12:01:59")
	y <- as.POSIXct("2008-08-03 12:01:59")
	
	expect_that(leap.year(x), is_false())
	expect_that(leap.year(y), is_true())
})

is_true_false <- function(){
	function(x) {
		expectation(
			identical(x, c("TRUE", "FALSE")),
			"isn't true"
		)
	}
}

test_that("leap.year handles vectors",{
	x <- c(as.POSIXct("2008-08-03 12:01:59"), 
		as.POSIXct("2009-08-03 12:01:59"))
	
	expect_that(leap.year(x), is_true_false())
	expect_that(leap.year(as.Date(x)), is_true_false())
})

test_that("leap.year handles various classes of date-time object",{
	x <- c(as.POSIXct("2008-08-03 12:01:59"), 
		as.POSIXct("2009-08-03 12:01:59"))
	
	expect_that(leap.year(x), is_true_false())
	expect_that(leap.year(as.Date(x)), is_true_false())
	expect_that(leap.year(as.POSIXlt(x)), is_true_false())
})

test_that("now() works correctly",{
	expect_that(now(), equals(Sys.time())
})

test_that("now() handles time zone input correctly",{
	expect_that(now("UTC"), equals(as.POSIXct(format(
		as.POSIXct(Sys.time()), tz = "UTC"), tz = "UTC"))
})

test_that("today() works correctly",{
	expect_that(today(), equals(Sys.Date())
})

test_that("am and pm correctly identify time of day",{
	x <- as.POSIXct("2009-08-03 13:01:59")
	y <- as.POSIXct("2008-08-03 10:01:59")
	
	expect_that(am(x), is_false())
	expect_that(am(y), is_true())
	
	expect_that(pm(x), is_true())
	expect_that(pm(y), is_false())
})

test_that("am and pm handle vectors",{
	x <- c(as.POSIXct("2009-08-03 13:01:59"), 
		as.POSIXct("2008-08-03 10:01:59"))
	y <- c(as.POSIXct("2009-08-03 10:01:59"), 
		as.POSIXct("2008-08-03 13:01:59"))
	
	expect_that(pm(x), is_true_false())
	expect_that(am(y), is_true_false())
})

test_that("am and pm handle various classes of date-time object",{
	x <- c(as.POSIXct("2008-08-03 13:01:59"), 
		as.POSIXct("2009-08-03 10:01:59"))
	
	expect_that(pm(x), is_true_false())
	expect_that(pm(as.Date(x[1])), is_false())
	expect_that(pm(as.POSIXlt(x)), is_true_false())
})


test_that("with_tz works as expected", {
	x <- as.POSIXct("2008-08-03 10:01:59")
	
	expect_that(with_tz(x, "UTC"), equals(as.POSIXct(format(
		as.POSIXct(x), tz = "UTC"), tz = "UTC"))
})

test_that("with_tz handles vectors", {
	x <- c(as.POSIXct("2008-08-03 13:01:59"), 
		as.POSIXct("2009-08-03 10:01:59"))
	
	expect_that(with_tz(x, "UTC"), equals(as.POSIXct(format(
		as.POSIXct(x), tz = "UTC"), tz = "UTC"))
})

test_that("with_tz handles various date-time classes", {
	x <- as.POSIXct("2008-08-03 13:01:59")
	
	expect_that(with_tz(as.POSIXlt(x), "UTC"), 
		equals(as.POSIXlt(format(
			as.POSIXct(x), tz = "UTC"), tz = "UTC"))
})

test_that("force_tz works as expected", {
	x <- as.POSIXct("2008-08-03 10:01:59")
	
	expect_that(force_tz(x, "UTC"), 
		equals(as.POSIXct(format(as.POSIXct(x)), tz = "UTC"))
})

test_that("force_tz handles vectors", {
	x <- c(as.POSIXct("2008-08-03 13:01:59"), 
		as.POSIXct("2009-08-03 10:01:59"))
	
	expect_that(force_tz(x, "UTC"), 
		equals(as.POSIXct(format(as.POSIXct(x)), tz = "UTC"))
})

test_that("force_tz handles various date-time classes", {
	x <- as.POSIXct("2008-08-03 13:01:59")
	
	expect_that(force_tz(as.POSIXlt(x), "UTC"), 
		equals(as.POSIXlt(format(as.POSIXct(x)), tz = "UTC"))
})


test_that("decimal_date works as expected",{
	x <- as.POSIXct("2008-08-03 10:01:59")
	
	expect_that(decimal_date(x), equals(2008.58846))
})

test_that("decimal_date works handles vectors",{
	x <- c(as.POSIXct("2008-08-03 13:01:59"), 
		as.POSIXct("2009-08-03 10:01:59"))
	
	expect_that(decimal_date(x), equals(c(2008.58846, 2009.5873325))
	
})