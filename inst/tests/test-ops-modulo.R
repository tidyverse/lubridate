context("modulo operations")

test_that("modulo operations return correct class",{
	int <- ymd("2010-01-01") %--% ymd("2011-01-01") 
	int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
	
	expect_is(int %% int2, "Interval")
	expect_is(int %% months(1), "Interval")
	expect_is(int %% edays(10), "Interval")	
	
	expect_is(months(3) %% int, "Period")
	expect_is(days(3) %% hours(2), "Period")
	expect_is(days(5) %% eminutes(300), "Period")	
	
	expect_is(eyears(3) %% int, "Duration")
	expect_is(edays(2) %% weeks(1), "Duration")
	expect_is(edays(3) %% edays(1), "Duration")		

})

	
test_that("modulo operations synchronize with integer division",{	
	int <- ymd("2010-01-01") %--% ymd("2011-01-01") 
	int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
	
	expect_equal(int2 %% int + int2 %/% int * int, int2)
	expect_equal(int %% years(2) + int %/% years(2) * years(2), int)
	expect_equal(int %% eweeks(20) + int %/% eweeks(20) * eweeks(20), int)	
	
	expect_equal(years(2) %% int + years(2) %/% int * int, years(2))
	expect_equal(years(2) %% months(5) + years(2) %/% months(5) * months(5), years(2))
	expect_equal(years(2) %% eweeks(20) + years(2) %/% eweeks(20) * eweeks(20), years(2))		
	
	expect_equal(eweeks(20) %% int + eweeks(20) %/% int * int, eweeks(20))
	expect_equal(eweeks(20) %% years(2) + eweeks(20) %/% years(2) * years(2), eweeks(20))
	expect_equal(eweeks(20) %% edays(20) + eweeks(20) %/% edays(20) * eweeks(20), eweeks(20))	

})	
	
	
test_that("modulo operations work for vectors",{	
	int <- ymd("2010-01-01") %--% ymd("2011-01-01") 
	int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
	int3 <- ymd("2008-01-01") %--% ymd("2009-02-01")
	
	expect_equal(c(int, int3) %% int2 + c(int, int3) %/% int2 * int2, c(int, int3))
	expect_equal(c(int, int3) %% years(2) + c(int, int3) %/% years(2) * years(2), c(int, int3))
	expect_equal(c(int, int3) %% eweeks(20) + c(int, int3) %/% eweeks(20) * eweeks(20), c(int, int3))	
	expect_equal(int %% c(int2, int3) + int %/% c(int2, int3) * c(int2, int3), c(int, int))
	expect_equal(int %% years(2:3) + int %/% years(2:3) * years(2:3), c(int, int))
	expect_equal(int %% eweeks(20:21) + int %/% eweeks(20:21) * eweeks(20:21), c(int, int))	
	
	expect_equal(years(2:3) %% int + years(2:3) %/% int * int,years(2:3))
	expect_equal(years(2:3) %% months(5) + years(2:3) %/% months(5) * months(5), years(2:3))
	expect_equal(years(2:3) %% eweeks(20) + years(2:3) %/% eweeks(20) * eweeks(20), years(2:3))
	expect_equal(years(2) %% c(int2, int3) + years(2) %/% c(int2, int3) * c(int2, int3), years(c(2,2)))
	expect_equal(years(2) %% months(5:6) + years(2) %/% months(5:6) * months(5:6), years(c(2,2)))
	expect_equal(years(2) %% eweeks(20:21) + years(2) %/% eweeks(20:21) * eweeks(20:21), years(c(2,2)))		
	
	expect_equal(eweeks(20:21) %% int + eweeks(20:21) %/% int * int, eweeks(20:21))
	expect_equal(eweeks(20:21) %% years(2) + eweeks(20:21) %/% years(2) * years(2), eweeks(20:21))
	expect_equal(eweeks(20:21) %% edays(20) + eweeks(20:21) %/% edays(20) * eweeks(20:21), eweeks(20:21))
	expect_equal(eweeks(20) %% c(int2, int3) + eweeks(20) %/% c(int2, int3) * c(int2, int3), c(eweeks(20), eweeks(20)))
	expect_equal(eweeks(20) %% years(2:3) + eweeks(20) %/% years(2:3) * years(2:3), c(eweeks(20), eweeks(20)))
	expect_equal(eweeks(20) %% edays(20:21) + eweeks(20) %/% edays(20:21) * edays(20:21), c(eweeks(20), eweeks(20)))	


})		
	
	
