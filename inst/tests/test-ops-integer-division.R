context("integer division operations")

test_that("integer division works for interval numerator",{
	int1 <- ymd("2010-01-01") %--% ymd("2011-01-01") 
	int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
  
  expect_equal(int2 %/% int1, 2)
  expect_equal(int1 %/% int2, 0)
  
  expect_equal(int1 %/% months(1), 12)
  expect_equal(months(12) %/% int1, 1)
  
  expect_equal(int1 %/% edays(1), 365)
  expect_equal(edays(365) %/% int1, 1)
  
})


test_that("integer division works for interval numerator with vectors",{
	int1 <- ymd("2010-01-01") %--% ymd("2011-01-01") 
	int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")
	int3 <- ymd("2009-01-01") %--% ymd("2010-01-01")


  expect_equal(int2 %/% c(int1, int3), c(2, 2))
  expect_equal(c(int1, int2) %/% int3, c(1, 2))
  
  expect_equal(int1 %/% months(1:2), c(12, 6))
  expect_equal(months(c(6, 12)) %/% int1, c(0, 1))
  
  expect_equal(int1 %/% edays(1:2), c(365, 182))
  expect_equal(edays(c(365, 365*2)) %/% int1, c(1, 2))
  
})


test_that("integer division works for period numerator",{
	int1 <- ymd("2010-01-01") %--% ymd("2011-01-01") 
	int2 <- ymd("2009-01-01") %--% ymd("2011-01-01")


  expect_equal(years(2) %/% c(int1, int2), c(2, 1))
  expect_equal(years(1:2) %/% int1, c(1, 2))
  
  expect_equal(years(1) %/% months(1:2), c(12, 6))
  expect_equal(months(c(6, 12)) %/% years(1), c(0, 1))
  
  expect_equal(int1 %/% edays(1:2), c(365, 182))
  expect_equal(edays(c(365, 365*2)) %/% int1, c(1, 2))
	
	per <- as.period(ymd("2010-01-01") - ymd("2009-02-03"))
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(per %/% smaller_int, equals(10))
  expect_that(per %/% bigger_int, equals(0))
  
  expect_that(per %/% smaller_per, equals(10))
  expect_that(per %/% bigger_per, equals(0))
  
  expect_that(per %/% smaller_dur, equals(16))
  expect_that(per %/% bigger_dur, equals(0))
  
  expect_that(per %/% smaller_diff, equals(3))
  expect_that(per %/% bigger_diff, equals(0))
  
})

test_that("integer division works for period numerator with vectors",{
	per1 <- as.period(ymd("2010-01-01") - ymd("2009-02-03"))
	per2 <- as.period(ymd("2011-01-01") - ymd("2008-02-03"))
	
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(c(per1, per2) %/% bigger_int, equals(c(0,2)))
  expect_that(per1 %/% c(smaller_int, bigger_int), 	equals(c(10,0)))
  
  expect_that(c(per1, per2) %/% bigger_per, equals(c(0,2)))
  expect_that(per1 %/% c(smaller_per, bigger_per), 	equals(c(10,0)))
  
  expect_that(c(per1, per2) %/% bigger_dur, equals(c(0,2)))
  expect_that(per1 %/% c(smaller_dur, bigger_dur), 	equals(c(16,0)))
  
  expect_that(c(per1, per2) %/% bigger_diff, equals(c(0,2)))
  expect_that(per1 %/% c(smaller_diff, bigger_diff), 
  	equals(c(3,0)))
  
})

test_that("integer division works for duration numerator",{
	dur <- as.duration(ymd("2010-01-01") - ymd("2009-02-03"))
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(dur %/% smaller_int, equals(10))
  expect_that(dur %/% bigger_int, equals(0))
  
  expect_that(dur %/% smaller_per, equals(10))
  expect_that(dur %/% bigger_per, equals(0))
  
  expect_that(dur %/% smaller_dur, equals(16))
  expect_that(dur %/% bigger_dur, equals(0))
  
  expect_that(dur %/% smaller_diff, equals(3))
  expect_that(dur %/% bigger_diff, equals(0))
  
})

test_that("integer division works for duration numerator with vectors",{
	dur1 <- as.duration(ymd("2010-01-01") - ymd("2009-02-03"))
	dur2 <- as.duration(ymd("2011-01-01") - ymd("2008-02-03"))
	
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(c(dur1, dur2) %/% bigger_int, equals(c(0,2)))
  expect_that(dur1 %/% c(smaller_int, bigger_int), 	equals(c(10,0)))
  
  expect_that(c(dur1, dur2) %/% bigger_per, equals(c(0,2)))
  expect_that(dur1 %/% c(smaller_per, bigger_per), 	equals(c(10,0)))
  
  expect_that(c(dur1, dur2) %/% bigger_dur, equals(c(0,2)))
  expect_that(dur1 %/% c(smaller_dur, bigger_dur), 	equals(c(16,0)))
  
  expect_that(c(dur1, dur2) %/% bigger_diff, equals(c(0,2)))
  expect_that(dur1 %/% c(smaller_diff, bigger_diff), 
  	equals(c(3,0)))
  
})

test_that("integer division works for difftime numerator",{
	diff <- make_difftime(as.duration(ymd("2010-01-01") - 		ymd("2009-02-03")))
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(diff %/% smaller_int, equals(10))
  expect_that(diff %/% bigger_int, equals(0))
  
  expect_that(diff %/% smaller_per, equals(10))
  expect_that(diff %/% bigger_per, equals(0))
  
  expect_that(diff %/% smaller_dur, equals(16))
  expect_that(diff %/% bigger_dur, equals(0))
  
  expect_that(diff %/% smaller_diff, equals(3))
  expect_that(diff %/% bigger_diff, equals(0))
  
})

test_that("integer division works for difftime numerator with vectors",{
	diff1 <- make_difftime(as.duration(ymd("2010-01-01") - 		ymd("2009-02-03")))
	diff2 <- make_difftime(as.duration(ymd("2011-01-01") - 		ymd("2008-02-03")))
	
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(c(diff1, diff2) %/% bigger_int, equals(c(0,2)))
  expect_that(diff1 %/% c(smaller_int, bigger_int), 	equals(c(10,0)))
  
  expect_that(c(diff1, diff2) %/% bigger_per, equals(c(0,2)))
  expect_that(diff1 %/% c(smaller_per, bigger_per), 	equals(c(10,0)))
  
  expect_that(c(diff1, diff2) %/% bigger_dur, equals(c(0,2)))
  expect_that(diff1 %/% c(smaller_dur, bigger_dur), 	equals(c(16,0)))
  
  expect_that(c(diff1, diff2) %/% bigger_diff, equals(c(0,2)))
  expect_that(diff1 %/% c(smaller_diff, bigger_diff), 
  	equals(c(3,0)))
  
})
