context("Rounding")

test_that("floor_date works for each time element",{
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  
  expect_identical(floor_date(x, "second"), as.POSIXct(
  	"2009-08-03 12:01:59", tz = "UTC"))
  expect_identical(floor_date(x, "minute"), as.POSIXct(
  	"2009-08-03 12:01:00", tz = "UTC"))
  expect_identical(floor_date(x, "hour"), as.POSIXct(
  	"2009-08-03 12:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "day"), as.POSIXct(
  	"2009-08-03 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "week"), as.POSIXct(
  	"2009-08-02 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "month"), as.POSIXct(
  	"2009-08-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "quarter"), as.POSIXct(
    "2009-07-01 00:00:00", tz = "UTC"))
  expect_identical(floor_date(x, "year"), as.POSIXct(
  	"2009-01-01 00:00:00", tz = "UTC"))
})

test_that("ceiling_date works for each time element",{
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = 	"UTC")
  
  expect_identical(ceiling_date(x, "second"), as.POSIXct(
  	"2009-08-03 12:02:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "minute"), as.POSIXct(
  	"2009-08-03 12:02:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "hour"), as.POSIXct(
  	"2009-08-03 13:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "day"), as.POSIXct(
  	"2009-08-04 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "week"), as.POSIXct(
  	"2009-08-09 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "month"), as.POSIXct(
  	"2009-09-01 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "quarter"), as.POSIXct(
    "2009-10-01 00:00:00", tz = "UTC"))
  expect_identical(ceiling_date(x, "year"), as.POSIXct(
  	"2010-01-01 00:00:00", tz = "UTC"))
})

test_that("round_date works for each time element",{
  x <- as.POSIXct("2009-08-03 12:01:59.23", tz = "UTC")
  
  expect_identical(round_date(x, "second"),
                   as.POSIXct("2009-08-03 12:01:59", tz = "UTC"))
  expect_identical(round_date(x, "minute"), as.POSIXct(
  	"2009-08-03 12:02:00", tz = "UTC"))
  expect_identical(round_date(x, "hour"), as.POSIXct(
  	"2009-08-03 12:00:00", tz = "UTC"))
  expect_identical(round_date(x, "day"), as.POSIXct(
  	"2009-08-04 00:00:00", tz = "UTC"))
  expect_identical(round_date(x, "week"), as.POSIXct(
  	"2009-08-02 00:00:00", tz = "UTC"))
  expect_identical(round_date(x, "month"), as.POSIXct(
  	"2009-08-01 00:00:00", tz = "UTC"))
  expect_identical(round_date(x, "quarter"), as.POSIXct(
    "2009-07-01 00:00:00", tz = "UTC"))
  expect_identical(round_date(x, "year"), as.POSIXct(
  	"2010-01-01 00:00:00", tz = "UTC"))
})

test_that("floor_date handles vectors",{
  x <- as.POSIXct(c("2009-08-03 12:01:59.23", 
  	"2010-08-03 12:01:59.23"), tz = "UTC") 
  
  expect_identical(floor_date(x, "second"), as.POSIXct(c(
    "2009-08-03 12:01:59", "2010-08-03 12:01:59"), tz = 
    "UTC"))
  expect_identical(floor_date(x, "minute"), as.POSIXct(c(
  	"2009-08-03 12:01:00", "2010-08-03 12:01:00"), tz = 
  	"UTC"))
  expect_identical(floor_date(x, "hour"), as.POSIXct(c(
    "2009-08-03 12:00:00", "2010-08-03 12:00:00"), tz = 
    "UTC"))
  expect_identical(floor_date(x, "day"), as.POSIXct(c(
  	"2009-08-03 00:00:00", "2010-08-03 00:00:00"), tz = 
  	"UTC"))
  expect_identical(floor_date(x, "week"), as.POSIXct(c(
  	"2009-08-02 00:00:00", "2010-08-01 00:00:00"), tz = 
  	"UTC"))
  expect_identical(floor_date(x, "month"), as.POSIXct(c(
  	"2009-08-01 00:00:00", "2010-08-01 00:00:00"), tz = 
  	"UTC"))
  expect_identical(floor_date(x, "year"), as.POSIXct(c(
  	"2009-01-01 00:00:00", "2010-01-01 00:00:00"), tz = 
  	"UTC"))
})

test_that("ceiling_date handles vectors",{
  x <- as.POSIXct(c("2009-08-03 12:01:59.23", 
  	"2010-08-03 12:01:59.23"), tz = "UTC") 
  
  expect_identical(ceiling_date(x, "second"), as.POSIXct(c(
    "2009-08-03 12:02:00", "2010-08-03 12:02:00"), tz = 
    "UTC"))
  expect_identical(ceiling_date(x, "minute"), as.POSIXct(c(
  	"2009-08-03 12:02:00", "2010-08-03 12:02:00"), tz = 
  	"UTC"))
  expect_identical(ceiling_date(x, "hour"), as.POSIXct(c(
  	"2009-08-03 13:00:00", "2010-08-03 13:00:00"), tz = 
  	"UTC"))
  expect_identical(ceiling_date(x, "day"), as.POSIXct(c(
  	"2009-08-04 00:00:00", "2010-08-04 00:00:00"), tz = 
  	"UTC"))
  expect_identical(ceiling_date(x, "week"), as.POSIXct(c(
  	"2009-08-09 00:00:00", "2010-08-08 00:00:00"), tz = 
  	"UTC"))
  expect_identical(ceiling_date(x, "month"), as.POSIXct(c(
  	"2009-09-01 00:00:00", "2010-09-01 00:00:00"), tz = 
  	"UTC"))
  expect_identical(ceiling_date(x, "year"), as.POSIXct(c(
  	"2010-01-01 00:00:00", "2011-01-01 00:00:00"), tz = 
  	"UTC"))
})


test_that("round_date handles vectors",{
  x <- as.POSIXct(c("2009-08-03 12:01:59.23", 
  	"2010-08-03 12:01:59.23"), tz = "UTC") 
  
  expect_identical(round_date(x, "second"), 
    as.POSIXct(c("2009-08-03 12:01:59", 
      "2010-08-03 12:01:59"), tz = "UTC"))
  expect_identical(round_date(x, "minute"),
    as.POSIXct(c("2009-08-03 12:02:00", 
      "2010-08-03 12:02:00"), tz = "UTC"))
  expect_identical(round_date(x, "hour"), 
    as.POSIXct(c("2009-08-03 12:00:00", 
      "2010-08-03 12:00:00"), tz = "UTC"))
  expect_identical(round_date(x, "day"), 
    as.POSIXct(c("2009-08-04 00:00:00", 
      "2010-08-04 00:00:00"), tz = "UTC"))
  expect_identical(round_date(x, "week"), 
    as.POSIXct(c("2009-08-02 00:00:00", 
      "2010-08-01 00:00:00"), tz = "UTC"))
  expect_identical(round_date(x, "month"), 
    as.POSIXct(c("2009-08-01 00:00:00", 
      "2010-08-01 00:00:00"), tz = "UTC"))
  expect_identical(round_date(x, "year"), 
    as.POSIXct(c("2010-01-01 00:00:00", 
      "2011-01-01 00:00:00"), tz = "UTC"))
})

test_that("floor_date works for a variety of formats",{
  x <- as.POSIXct("2009-08-03 12:01:59", tz = "UTC")
  
  expect_identical(floor_date(x, "minute"), 
    as.POSIXct("2009-08-03 12:01:00", tz = "UTC"))
  expect_identical(floor_date(as.Date(x), "month"), 
    as.Date("2009-08-01"))
  expect_identical(floor_date(as.POSIXlt(x), "minute"), 
    as.POSIXlt(as.POSIXct("2009-08-03 12:01:00", tz = "UTC")))
})

test_that("ceiling_date works for a variety of formats",{
  x <- as.POSIXct("2009-08-03 12:01:59", tz = "UTC")
  
  expect_identical(ceiling_date(x, "minute"), 
    as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_identical(ceiling_date(as.Date(x), "month"), 
    as.Date("2009-09-01"))
  expect_identical(ceiling_date(as.POSIXlt(x), "minute"), 
    as.POSIXlt(as.POSIXct("2009-08-03 12:02:00", tz = 
    "UTC")))
})

test_that("round_date works for a variety of formats",{
  x <- as.POSIXct("2009-08-03 12:01:59", tz = "UTC")
  
  expect_identical(round_date(x, "minute"), 
    as.POSIXct("2009-08-03 12:02:00", tz = "UTC"))
  expect_identical(round_date(as.Date(x), "month"), 
    as.Date("2009-08-01"))
  expect_identical(round_date(as.POSIXlt(x), "minute"), 
    as.POSIXlt(as.POSIXct("2009-08-03 12:02:00", tz = 
    "UTC")))
})

test_that("ceiling_date does not round up dates that are already on a boundary",{
  expect_equal(ceiling_date(as.Date("2012-09-27"), 'day'), as.Date("2012-09-27"))
})

test_that("floor_date does not round down dates that are already on a boundary",{
  expect_equal(floor_date(as.Date("2012-09-27"), 'day'), as.Date("2012-09-27"))
})

test_that("round_date does not round dates that are already on a boundary",{
  expect_equal(round_date(as.Date("2012-09-27"), 'day'), as.Date("2012-09-27"))
})

test_that("ceiling_date returns input of length zero when given input of length zero",{
  x <- structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt"))
  
  expect_equal(ceiling_date(x), x)
})

test_that("floor_date returns input of length zero when given input of length zero",{
  x <- structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt"))
  
  expect_equal(floor_date(x), x)
})

test_that("round_date returns input of length zero when given input of length zero",{
  x <- structure(vector(mode = "numeric"), class = c("POSIXct", "POSIXt"))
  
  expect_equal(round_date(x), x)
})

test_that("round_date behaves correctly on 60th second (bug #217)", {
  x <- ymd_hms('2013-12-01 23:59:59.9999')

  expect_equal(round_date(x, unit = "second"),
               ymd("2013-12-02"))
  second(x) <-  60
  expect_equal(x, ymd("2013-12-02"))
})

test_that("round_date and ceiling_date skip day time gap (#240)", {
            tz <- "Europe/Amsterdam"
            times <- ymd_hms("2013-03-31 01:00:00 CET", "2013-03-31 01:15:00 CEST",
                             "2013-03-31 01:30:00 CEST", "2013-03-31 01:45:00 CEST",
                             "2013-03-31 03:00:00 CEST", "2013-03-31 03:15:00 CEST",
                             tz = tz)

            round <- ymd_hms("2013-03-31 01:00:00 CET",
                             "2013-03-31 01:00:00 CEST", "2013-03-31 03:00:00 CEST",
                             "2013-03-31 03:00:00 CEST", "2013-03-31 03:00:00 CEST",
                             "2013-03-31 03:00:00 CEST",
                             tz = tz)
            expect_equal(round_date(times, "hour"), round)
            
            ceiling <- ymd_hms("2013-03-31 01:00:00 CET",
                               "2013-03-31 03:00:00 CEST", "2013-03-31 03:00:00 CEST",
                               "2013-03-31 03:00:00 CEST", "2013-03-31 03:00:00 CEST",
                               "2013-03-31 04:00:00 CEST",
                               tz = tz)
            expect_equal(ceiling_date(times, "hour"), ceiling)

            
            tz <- "America/Chicago"

            x <- ymd_hms(c("2014-03-09 00:00:00", "2014-03-09 00:29:59", "2014-03-09 00:30:00",
                           "2014-03-09 00:59:59", "2014-03-09 01:35:00", "2014-03-09 03:15:00",
                           "2014-11-02 00:30:00", "2014-11-02 00:59:59", "2014-11-02 01:35:00",
                           "2014-11-02 02:15:00", "2014-11-02 02:45:00"),
                         tz = tz)
            
            y <- as.POSIXct(c("2014-03-09 00:00:00", "2014-03-09 00:00:00", "2014-03-09 01:00:00",
                              "2014-03-09 01:00:00", "2014-03-09 03:00:00", "2014-03-09 03:00:00",
                              "2014-11-02 01:00:00", "2014-11-02 01:00:00", "2014-11-02 02:00:00",
                              "2014-11-02 02:00:00", "2014-11-02 03:00:00"),
                            tz = tz)
            
            expect_equal(round_date(x, "hour"),  y)
          })
