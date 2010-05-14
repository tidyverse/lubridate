context("Rounding")

test_that("floor_date works for each time element",{
	x <- as.POSIXct("2009-08-03 12:01:59.23")
	
	expect_that(floor_date(x, "second"), equals(as.POSIXct("2009-08-03 12:01:59")))
	expect_that(floor_date(x, "minute"), equals(as.POSIXct("2009-08-03 12:01:00")))
	expect_that(floor_date(x, "hour"), equals(as.POSIXct("2009-08-03 12:00:00")))
	expect_that(floor_date(x, "day"), equals(as.POSIXct("2009-08-03 00:00:00")))
	expect_that(floor_date(x, "week"), equals(as.POSIXct("2009-08-02 00:00:00")))
	expect_that(floor_date(x, "month"), equals(as.POSIXct("2009-08-01 00:00:00")))
	expect_that(floor_date(x, "year"), equals(as.POSIXct("2009-01-01 00:00:00")))
})

test_that("ceiling_date works for each time element",{
	x <- as.POSIXct("2009-08-03 12:01:59.23")
	
	expect_that(ceiling_date(x, "second"), equals(as.POSIXct("2009-08-03 12:02:00")))
	expect_that(ceiling_date(x, "minute"), equals(as.POSIXct("2009-08-03 12:02:00")))
	expect_that(ceiling_date(x, "hour"), equals(as.POSIXct("2009-08-03 13:00:00")))
	expect_that(ceiling_date(x, "day"), equals(as.POSIXct("2009-08-04 00:00:00")))
	expect_that(ceiling_date(x, "week"), equals(as.POSIXct("2009-08-09 00:00:00")))
	expect_that(ceiling_date(x, "month"), equals(as.POSIXct("2009-09-01 00:00:00")))
	expect_that(ceiling_date(x, "year"), equals(as.POSIXct("2010-01-01 00:00:00")))
})

test_that("round_date works for each time element",{
	x <- as.POSIXct("2009-08-03 12:01:59.23")
	
	expect_that(round_date(x, "second"), equals(as.POSIXct("2009-08-03 12:01:59")))
	expect_that(round_date(x, "minute"), equals(as.POSIXct("2009-08-03 12:02:00")))
	expect_that(round_date(x, "hour"), equals(as.POSIXct("2009-08-03 12:00:00")))
	expect_that(round_date(x, "day"), equals(as.POSIXct("2009-08-04 00:00:00")))
	expect_that(round_date(x, "week"), equals(as.POSIXct("2009-08-02 00:00:00")))
	expect_that(round_date(x, "month"), equals(as.POSIXct("2009-08-01 00:00:00")))
	expect_that(round_date(x, "year"), equals(as.POSIXct("2010-01-01 00:00:00")))
})

test_that("floor_date handles vectors",{
	x <- c(as.POSIXct("2009-08-03 12:01:59.23"),
		as.POSIXct("2010-08-03 12:01:59.23")) 
	
	expect_that(floor_date(x, "second"), 
		equals(as.POSIXct(c("2009-08-03 12:01:59", 
			"2010-08-03 12:01:59"))))
	expect_that(floor_date(x, "minute"),
		equals(as.POSIXct(c("2009-08-03 12:01:00", 
			"2010-08-03 12:01:00"))))
	expect_that(floor_date(x, "hour"), 
		equals(as.POSIXct(c("2009-08-03 12:00:00", 
			"2010-08-03 12:00:00"))))
	expect_that(floor_date(x, "day"), 
		equals(as.POSIXct(c("2009-08-03 00:00:00", 
			"2010-08-03 00:00:00"))))
	expect_that(floor_date(x, "week"), 
		equals(as.POSIXct(c("2009-08-02 00:00:00", 
			"2010-08-01 00:00:00"))))
	expect_that(floor_date(x, "month"), 
		equals(as.POSIXct(c("2009-08-01 00:00:00", 
			"2010-08-01 00:00:00"))))
	expect_that(floor_date(x, "year"), 
		equals(as.POSIXct(c("2009-01-01 00:00:00", 
			"2010-01-01 00:00:00"))))
})

test_that("ceiling_date handles vectors",{
	x <- c(as.POSIXct("2009-08-03 12:01:59.23"),
		as.POSIXct("2010-08-03 12:01:59.23")) 
	
	expect_that(ceiling_date(x, "second"), 
		equals(as.POSIXct(c("2009-08-03 12:02:00", 
			"2010-08-03 12:02:00"))))
	expect_that(ceiling_date(x, "minute"),
		equals(as.POSIXct(c("2009-08-03 12:02:00", 
			"2010-08-03 12:02:00"))))
	expect_that(ceiling_date(x, "hour"), 
		equals(as.POSIXct(c("2009-08-03 13:00:00", 
			"2010-08-03 13:00:00"))))
	expect_that(ceiling_date(x, "day"), 
		equals(as.POSIXct(c("2009-08-04 00:00:00", 
			"2010-08-04 00:00:00"))))
	expect_that(ceiling_date(x, "week"), 
		equals(as.POSIXct(c("2009-08-09 00:00:00", 
			"2010-08-08 00:00:00"))))
	expect_that(ceiling_date(x, "month"), 
		equals(as.POSIXct(c("2009-09-01 00:00:00", 
			"2010-09-01 00:00:00"))))
	expect_that(ceiling_date(x, "year"), 
		equals(as.POSIXct(c("2010-01-01 00:00:00", 
			"2011-01-01 00:00:00"))))
})


test_that("round_date handles vectors",{
	x <- c(as.POSIXct("2009-08-03 12:01:59.23"),
		as.POSIXct("2010-08-03 12:01:59.23")) 
	
	expect_that(round_date(x, "second"), 
		equals(as.POSIXct(c("2009-08-03 12:01:59", 
			"2010-08-03 12:01:59"))))
	expect_that(round_date(x, "minute"),
		equals(as.POSIXct(c("2009-08-03 12:02:00", 
			"2010-08-03 12:02:00"))))
	expect_that(round_date(x, "hour"), 
		equals(as.POSIXct(c("2009-08-03 12:00:00", 
			"2010-08-03 12:00:00"))))
	expect_that(round_date(x, "day"), 
		equals(as.POSIXct(c("2009-08-04 00:00:00", 
			"2010-08-04 00:00:00"))))
	expect_that(round_date(x, "week"), 
		equals(as.POSIXct(c("2009-08-02 00:00:00", 
			"2010-08-01 00:00:00"))))
	expect_that(round_date(x, "month"), 
		equals(as.POSIXct(c("2009-08-01 00:00:00", 
			"2010-08-01 00:00:00"))))
	expect_that(round_date(x, "year"), 
		equals(as.POSIXct(c("2010-01-01 00:00:00", 
			"2011-01-01 00:00:00"))))
})

test_that("floor_date works for a variety of formats",{
	x <- as.POSIXct("2009-08-03 12:01:59")
	
	expect_that(floor_date(x, "minute"), equals(
		as.POSIXct("2009-08-03 12:01:00")))
	expect_that(floor_date(as.Date(x), "month"), equals(
		as.Date("2009-08-01")))
	expect_that(floor_date(as.POSIXlt(x), "minute"), equals(
		as.POSIXlt(as.POSIXct("2009-08-03 12:01:00"))))
})

test_that("ceiling_date works for a variety of formats",{
	x <- as.POSIXct("2009-08-03 12:01:59")
	
	expect_that(ceiling_date(x, "minute"), equals(
		as.POSIXct("2009-08-03 12:02:00")))
	expect_that(ceiling_date(as.Date(x), "month"), equals(
		as.Date("2009-09-01")))
	expect_that(ceiling_date(as.POSIXlt(x), "minute"), equals(
		as.POSIXlt(as.POSIXct("2009-08-03 12:02:00"))))
})

test_that("round_date works for a variety of formats",{
	x <- as.POSIXct("2009-08-03 12:01:59")
	
	expect_that(round_date(x, "minute"), equals(
		as.POSIXct("2009-08-03 12:02:00")))
	expect_that(round_date(as.Date(x), "month"), equals(
		as.Date("2009-08-01")))
	expect_that(round_date(as.POSIXlt(x), "minute"), equals(
		as.POSIXlt(as.POSIXct("2009-08-03 12:02:00"))))
})
