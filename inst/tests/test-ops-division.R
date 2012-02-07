context("Division operators")

test_that("division operations work for interval numerator",{
	int <- ymd("2010-01-01") - ymd("2009-02-03")
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(int/smaller_int, equals(28684800/2678400))
  expect_that(int/bigger_int, equals(28684800/34214400))
  
  expect_that(int/smaller_per, equals(10))
  expect_that(int/bigger_per, equals(0))
  
  expect_that(int/smaller_dur, equals(28684800/1742400))
  expect_that(int/bigger_dur, equals(28684800/31536002))
  
  expect_that(int/smaller_diff, equals(28684800/8640000))
  expect_that(int/bigger_diff, equals(28684800/34560000))
  
})

test_that("division works for interval numerator with vectors",{
	int1 <- ymd("2010-01-01") - ymd("2009-02-03")
	int2 <- ymd("2011-01-01") - ymd("2008-02-03")
	
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(c(int1, int2) / bigger_int, 
  	equals(c(28684800/34214400, 91843200/34214400)))
  expect_that(int1 / c(smaller_int, bigger_int),   	equals(c(28684800/2678400, 28684800/34214400)))
  
  expect_that(c(int1, int2) / bigger_per, equals(c(0,2)))
  expect_that(int1 / c(smaller_per, bigger_per), 	equals(c(10, 0)))
  
  expect_that(c(int1, int2) / bigger_dur,  
  	equals(c(28684800/31536002, 91843200/31536002)))
  expect_that(int1 / c(smaller_dur, bigger_dur),
	equals(c(28684800/1742400, 28684800/31536002)))
   	  
  expect_that(c(int1, int2) / bigger_diff, 
  	equals(c(28684800/34560000, 91843200/34560000)))
  expect_that(int1 / c(smaller_diff, bigger_diff),
	equals(c(28684800/8640000, 28684800/34560000)))
  
})


test_that("division operations work for period numerator",{
	per <- months(10) + days(29)
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(per/smaller_int, equals(28425600/2678400))
  expect_that(per/bigger_int, equals(28425600/34214400))
  
  expect_that(per/smaller_per, equals(28425600/2764800))
  expect_that(per/bigger_per, equals(28425600/31561920))
  
  expect_that(per/smaller_dur, equals(28425600/1742400))
  expect_that(per/bigger_dur, equals(28425600/31536002))
  
  expect_that(per/smaller_diff, equals(28425600/8640000))
  expect_that(per/bigger_diff, equals(28425600/34560000))
  
})

test_that("division works for period numerator with vectors",{
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
  
  expect_that(c(per1, per2) / bigger_int, 
  	equals(c(28425600/34214400, 91540800/34214400)))
  expect_that(per1 / c(smaller_int, bigger_int),   	equals(c(28425600/2678400, 28425600/34214400)))
  
  expect_that(c(per1, per2) / bigger_per, 
  	equals(c(28425600/31561920, 91540800/31561920)))
  expect_that(per1 / c(smaller_per, bigger_per), 	equals(c(28425600/2764800, 28425600/31561920)))
  
  expect_that(c(per1, per2) / bigger_dur,  
  	equals(c(28425600/31536002, 91540800/31536002)))
  expect_that(per1 / c(smaller_dur, bigger_dur),
	equals(c(28425600/1742400, 28425600/31536002)))
   	  
  expect_that(c(per1, per2) / bigger_diff, 
  	equals(c(28425600/34560000, 91540800/34560000)))
  expect_that(per1 / c(smaller_diff, bigger_diff),
	equals(c(28425600/8640000, 28425600/34560000)))
  
})

test_that("division operations work for duration numerator",{
	dur <- as.duration(ymd("2010-01-01") - ymd("2009-02-03"))
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(dur/smaller_int, equals(28684800/2678400))
  expect_that(dur/bigger_int, equals(28684800/34214400))
  
  expect_that(dur/smaller_per, equals(28684800/2764800))
  expect_that(dur/bigger_per, equals(28684800/31561920))
  
  expect_that(dur/smaller_dur, equals(28684800/1742400))
  expect_that(dur/bigger_dur, equals(28684800/31536002))
  
  expect_that(dur/smaller_diff, equals(28684800/8640000))
  expect_that(dur/bigger_diff, equals(28684800/34560000))
  
})



test_that("division works for duration numerator with vectors",{
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
  
  expect_that(c(dur1, dur2) / bigger_int, 
  	equals(c(28684800/34214400, 91843200/34214400)))
  expect_that(dur1 / c(smaller_int, bigger_int),   	equals(c(28684800/2678400, 28684800/34214400)))
  
  expect_that(c(dur1, dur2) / bigger_per, 
  	equals(c(28684800/31561920, 91843200/31561920)))
  expect_that(dur1 / c(smaller_per, bigger_per), 	equals(c(28684800/2764800, 28684800/31561920)))
  
  expect_that(c(dur1, dur2) / bigger_dur,  
  	equals(c(28684800/31536002, 91843200/31536002)))
  expect_that(dur1 / c(smaller_dur, bigger_dur),
	equals(c(28684800/1742400, 28684800/31536002)))
   	  
  expect_that(c(dur1, dur2) / bigger_diff, 
  	equals(c(28684800/34560000, 91843200/34560000)))
  expect_that(dur1 / c(smaller_diff, bigger_diff),
	equals(c(28684800/8640000, 28684800/34560000)))
  
})

test_that("division operations work for difftime numerator",{
	diff <- make_difftime(as.numeric(ymd("2010-01-01") - 		ymd("2009-02-03")))
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(diff/smaller_int, equals(28684800/2678400))
  expect_that(diff/bigger_int, equals(28684800/34214400))
  
  expect_that(diff/smaller_per, equals(28684800/2764800))
  expect_that(diff/bigger_per, equals(28684800/31561920))
  
  expect_that(diff/smaller_dur, equals(28684800/1742400))
  expect_that(diff/bigger_dur, equals(28684800/31536002))
  
  expect_that(diff/smaller_diff, equals(28684800/8640000))
  expect_that(diff/bigger_diff, equals(28684800/34560000))
  
})

test_that("division works for difftime numerator with vectors",{
	diff1 <- make_difftime(as.duration(ymd("2010-01-01") - 		ymd("2009-02-03")))
	diff2 <- make_difftime(as.duration(ymd("2011-01-01") - 
		ymd("2008-02-03")))
	
	smaller_int <- ymd("2010-01-01") - ymd("2009-12-01")
	bigger_int <- ymd("2010-02-01") - ymd("2009-01-01")
	
	smaller_per <- months(1) + days(2)
	bigger_per <- years(1) + minutes(72)
	
	smaller_dur <- ddays(20) + dhours(4)
	bigger_dur <- dyears(1) + dseconds(2)
	
	smaller_diff <- new_difftime(days = 100)
	bigger_diff <- new_difftime(days = 400)
  
  expect_that(c(diff1, diff2) / bigger_int, 
  	equals(c(28684800/34214400, 91843200/34214400)))
  expect_that(diff1 / c(smaller_int, bigger_int),   	equals(c(28684800/2678400, 28684800/34214400)))
  
  expect_that(c(diff1, diff2) / bigger_per, 
  	equals(c(28684800/31561920, 91843200/31561920)))
  expect_that(diff1 / c(smaller_per, bigger_per), 	equals(c(28684800/2764800, 28684800/31561920)))
  
  expect_that(c(diff1, diff2) / bigger_dur,  
  	equals(c(28684800/31536002, 91843200/31536002)))
  expect_that(diff1 / c(smaller_dur, bigger_dur),
	equals(c(28684800/1742400, 28684800/31536002)))
   	  
  expect_that(c(diff1, diff2) / bigger_diff, 
  	equals(c(28684800/34560000, 91843200/34560000)))
  expect_that(diff1 / c(smaller_diff, bigger_diff),
	equals(c(28684800/8640000, 28684800/34560000)))
  
})









test_that("division still works for numbers",{
  expect_that(6/2, equals(3))
  expect_that(c(4,6)/2, equals(c(2,3)))
  expect_that(3/2, is_a("numeric"))
  
})


# division for everything

test_that("division throws error for instants",{
  x <- as.POSIXct("2010-03-15 00:00:00", tz = "UTC")
  
  expect_that(3 / x, throws_error())
  expect_that(x / 3, throws_error())
  
})


test_that("division works as expected for periods",{
  
  expect_that(3/months(1), throws_error())
  expect_that(months(1)/3, throws_error(
    "periods must have integer values"))
  expect_that(months(9)/3, equals(months(3)))
  expect_that(months(9)/3, is_a("period"))
  
})

test_that("dividing vectors works for periods",{
  
  expect_that(c(2,3)/months(1), throws_error())
  expect_that(months(1)/c(2,3), throws_error(
    "periods must have integer values"))
  expect_that(months(9)/c(3,1), equals(months(c(3,9))))
  expect_that(months(9)/c(3,1), is_a("period"))
  
})

test_that("division works as expected for durations",{
    
  expect_that(3/ehours(1), throws_error())
  expect_that(ehours(9)/3, equals(ehours(3)))
  expect_that(ehours(9)/3, is_a("duration"))
  
})

test_that("dividing vectors works for durations",{
  
  expect_that(c(2,3)/ehours(1), throws_error())
  expect_that(ehours(9)/c(3,1), equals(ehours(c(3,9))))
  expect_that(ehours(9)/c(3,1), is_a("duration"))
  
})




