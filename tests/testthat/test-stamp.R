context("Stamp")

test_that("stamp selects the correct format", {

  test_dates <- read.table(header = T, stringsAsFactors=F,
                           textConnection("
    date                                expected
   'February 20th 1973'                'August 13th 2012'
   ## 'february  14, 2004'                'August  13, 2012'
   'Sunday, May 1, 2000'               'Monday, Aug 13, 2012'
   'Sunday, May 1, 2000'               'Monday, Aug 13, 2012'
   'february  14, 04'                  'August  13, 12'
   'Feb 20th 73'                       'Aug 13th 12'
   'January 5 1999 at 7pm'             'August 13 2012 at 11AM'
   'jan 3 2010'                        'Aug 13 2012'
   'Jan 1, 1999'                       'Aug 13, 2012'
   'jan 3   10'                        'Aug 13   12'
   '01 3 2010'                         '08 13 2012'
   '1 3 10'                            '08 13 12'
   '1 13 89'                           '08 13 12'
   '5/27/1979'                         '08/13/2012'
   '12/31/99'                          '08/13/12'
   'DOB:12/11/00'                      'DOB:08/13/12'
   'Thu, 1 July 2004 22:30:00'         'Mon, 13 August 2012 11:37:53'
   'Thu, 1st of July 2004 at 22:30:00' 'Mon, 13st of August 2012 at 11:37:53'
   'Thu, 1July 2004 at 22:30:00'       'Mon, 13August 2012 at 11:37:53'
   'Thu, 1July2004 22:30:00'           'Mon, 13August2012 11:37:53'
   ## '21 Aug 2011, 11:15:34 pm'          '13 Aug 2012, 11:37:53 AM'
   '1979-05-27 05:00:59'               '2012-08-13 11:37:53'
   '1979-05-27'                        '2012-08-13'
   '3 jan 2000'                        '13 Aug 2012'
   '17 april 85'                       '13 August 12'
   '27/5/1979'                         '13/08/2012'
   '20 01 89'                          '13 08 12'
   '00/13/10'                          '12/13/08'
   '14 12 00'                          '13 08 12'
   ## '03:23:22 PM'                       '11:37:53 AM'
   '2001-12-31T04:05:06Z'              '2012-08-13T11:37:53Z'
    "))

  D <- as.POSIXct("2012-08-13 11:37:53", tz = "UTC")
  for (i in seq_along(test_dates$date)) {
    ## print(i)
    expect_equal(stamp(test_dates[[i, "date"]])(D), test_dates[[i, "expected"]])
  }

})

test_that(".format_offset works as expected", {

  df_winter <- data.frame(
    tz = c("America/Chicago", "UTC", "Europe/Paris"),
    Oo = c("-06", "+00", "+01"),
    Oz = c("-0600", "+0000", "+0100"),
    OO = c("-06:00", "+00:00", "+01:00"),
    stringsAsFactors = FALSE
  )

  with(df_winter,
       for (i in 1:nrow(df_winter)) {
           expect_equal(.format_offset(ymd("2013-01-01", tz = tz[i]), "%Oo"), Oo[i])
           expect_equal(.format_offset(ymd("2013-01-01", tz = tz[i]), "%Oz"), Oz[i])
           expect_equal(.format_offset(ymd("2013-01-01", tz = tz[i]), "%OO"), OO[i])
       })

  df_summer <- data.frame(
    tz = c("America/Chicago", "UTC", "Europe/Paris"),
    Oo = c("-05", "+00", "+02"),
    Oz = c("-0500", "+0000", "+0200"),
    OO = c("-05:00", "+00:00", "+02:00"),
    stringsAsFactors = FALSE
  )

  with(df_summer,
       for (i in 1:nrow(df_summer)) {
           expect_equal(.format_offset(ymd("2013-07-01", tz = tz[i]), "%Oo"), Oo[i])
           expect_equal(.format_offset(ymd("2013-07-01", tz = tz[i]), "%Oz"), Oz[i])
           expect_equal(.format_offset(ymd("2013-07-01", tz = tz[i]), "%OO"), OO[i])
       })

  ## half-hour timezone
  expect_warning(.format_offset(ymd("2013-07-01", tz = "Asia/Kolkata"), "%Oo"))
  expect_equal(suppressWarnings(.format_offset(ymd("2013-07-01", tz = "Asia/Kolkata"), "%Oo")), "+0530")
  expect_equal(.format_offset(ymd("2013-07-01", tz = "Asia/Kolkata"), "%Oz"), "+0530")
  expect_equal(.format_offset(ymd("2013-07-01", tz = "Asia/Kolkata"), "%OO"), "+05:30")
})

test_that("stamp works with ISO-8601 formats", {

  stamp_Ou <- stamp("2013-01-01T06:00:00Z")
  stamp_Oo <- stamp("2013-01-01T00:00:00-06")
  stamp_Oz <- stamp("2013-01-01T00:00:00-0600")
  stamp_OO <- stamp("2013-01-01T00:00:00-06:00")


  tz <- c("America/Chicago", "UTC", "Europe/Paris")
  Ou <- c("2013-01-01T06:00:00Z", "2013-01-01T00:00:00Z", "2012-12-31T23:00:00Z")
  Oo <- c("2013-01-01T00:00:00-06", "2013-01-01T00:00:00+00", "2013-01-01T00:00:00+01")
  Oz <- c("2013-01-01T00:00:00-0600", "2013-01-01T00:00:00+0000", "2013-01-01T00:00:00+0100")
  OO <- c("2013-01-01T00:00:00-06:00", "2013-01-01T00:00:00+00:00", "2013-01-01T00:00:00+01:00")

  ## cbind(tz, Ou, Oo, Oz, OO) # if you want to see them

  for (i in seq_along(tz)) {
    expect_equal(stamp_Ou(ymd("2013-01-01", tz = tz[i])), Ou[i])
    expect_equal(stamp_Oo(ymd("2013-01-01", tz = tz[i])), Oo[i])
    expect_equal(stamp_Oz(ymd("2013-01-01", tz = tz[i])), Oz[i])
    expect_equal(stamp_OO(ymd("2013-01-01", tz = tz[i])), OO[i])
  }

  ## half-hour timezone
  expect_equal(suppressWarnings(stamp_Ou(ymd("2013-01-01", tz = "Asia/Kolkata"))),
               "2012-12-31T18:30:00Z")
  expect_warning(stamp_Oo(ymd("2013-01-01", tz = "Asia/Kolkata")))
  expect_equal(suppressWarnings(stamp_Oo(ymd("2013-01-01", tz = "Asia/Kolkata"))),
               "2013-01-01T00:00:00+0530")
  expect_equal(stamp_Oz(ymd("2013-01-01", tz = "Asia/Kolkata")),
               "2013-01-01T00:00:00+0530")
  expect_equal(stamp_OO(ymd("2013-01-01", tz = "Asia/Kolkata")),
               "2013-01-01T00:00:00+05:30")

  ## vectorization
  expect_equal(stamp_OO(ymd(c("2013-01-01", "2010-01-01"), tz = "Asia/Kolkata")),
               c("2013-01-01T00:00:00+05:30", "2010-01-01T00:00:00+05:30"))

  ## format not at end of template (fails on windows 7, %z output format is
  ## completely screwed there)

  ## stamp_OO_strange <- stamp("2013-01-01T00:00:00-06:00 KK")

  ## expect_equal(stamp_OO_strange(ymd("2013-01-01", tz="Asia/Kolkata")),
  ##              "2012-12-31T18:30:00+0000 KK")
})

test_that("stamp recognizes correctly B orders", {
  formater <- stamp("Sunday, November 30, 23:15", "ABdHM")
  x <- ymd_hm(c("2017-01-20 15:15", "2017-02-11 10:10"))
  expect_equal(formater(x), c("Friday, January 20, 15:15", "Saturday, February 11, 10:10"))
})



## ## Don't delete this. We need it for interactive testing
## y <- c('February 20th 1973',
##        "february  14, 2004",
##        "Sunday, May 1, 2000",
##        "Sunday, May012000",
##        "february  14, 04",
##        'Feb 20th 73',
##        "January 5 1999 at 7pm",
##        "jan 3 2010",
##        "Jan 1, 1999",
##        "jan 3   10",
##        "01 3 2010",
##        "1 3 10",
##        '1 13 89',
##        "5/27/1979",
##        "12/31/99",
##        "DOB:12/11/00",
##        'Thu, 1 July 2004 22:30:00',
##        'Thu, 1st of July 2004 at 22:30:00',
##        'Thu, 1July 2004 at 22:30:00',
##        'Thu, 1July2004 22:30:00',
##        "21 Aug 2011, 11:15:34 pm",
##        "1979-05-27 05:00:59",
##        "1979-05-27",
##        "3 jan 2000",
##        "17 april 85",
##        "27/5/1979",
##        '20 01 89',
##        '00/13/10',
##        "14 12 00",
##        "03:23:22 pm")

## cbind(y, unlist(lapply(y, function(x) stamp(x)(D))))
