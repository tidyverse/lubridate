## This is for interactive tests mainly, (test-parser.R and test-stamp.R are ussing gueesser, so it should be enough)


## x <- c('February 20th 1973',
##        "february  14, 2004",
##        "Sunday, May 1, 2000",
##        "Sunday, May 1, 2000",
##        "february  14, 04",
##        'Feb 20th 73',
##        "January 5 1999 at 7 pm",
##        "January 5 1999 at7pm",
##        "jan 3 2010",
##        "Jan 1, 1999",
##        "jan 3   10",
##        "01 3 2010",
##        "1 3 10",
##        '1 13 89',
##        "5/27/1979",
##        "12/31/99",
##        "DOB:12/11/00",
##        "-----------",
##        'Thu, 1 July 2004 22:30:00',
##        'Thu, 1st of July 2004 at 22:30:00',
##        'Thu, 1July 2004 at 22:30:00',
##        'Thu, 1July2004 22:30:00',
##        "21 Aug 2011, 11:15:34 pm",
##        "-----------",
##        "1979-05-27 05:00:59",
##        "1979-05-27",
##        "-----------",
##        "3 jan 2000",
##        "17 april 85",
##        "27/5/1979",
##        '20 01 89',
##        '00/13/10',
##        "-------",
##        "14 12 00",
##        "03:23:22 pm")

## guess_formats(x, "BdY", print = T)
## guess_formats(x, "Bdy")
## guess_formats(x, "bdY")
## guess_formats(x, "bdy")
## guess_formats(x, "mdy", print = T)

## guess_formats(x, "T", print = T)

## guess_formats(x, c("mdY", "BdY", "Bdy", "bdY", "bdy"))
## guess_formats(x, c("dby", "dbY", "dBy", "dBY"))

## guess_formats(x, c("mdY", "mdy"))
## guess_formats(x, c("dmY", "dmy"))

## guess_formats(x, c("BdY H", "dBY HMS", "dbY HMS"))
## guess_formats(x, c("dBy HMS"))

## guess_formats(x, c("Ymd HMS"), print_matches=T)
## guess_formats(x, c("dmy HMS"), print_matches=T)
## guess_formats(x, c("mdY r"), print_matches=T)


## stamp(x, c("BdY", "bdY", "bd"))(Sys.time())
## system.time(stamp(x[1], "BdY", quiet = T))
## stamp(x, quiet = F)


## y <- rep(x, 3)
## f <- rep(c("BdY", "bdY", "bdy"), 10)
## system.time( for (i in 1:1) substitute_formats(y, f))

## reg <- c("\\b(?<Q>[0-2]?\\d)\\D*?(?<p>(AM|PM))",
##          "\\b(?<T>[0-2]?\\d)\\D*?(?<D>(DD|BB))")

## reg <- c("\\b((?<fixed>(?<Q_f>[0-2]?\\d)\\D*?(?<p_f>(AM|PM)))|(?<flex>(?<Q>[0-2]?\\d)\\D*?(?<p>(DD|BB))))")
## x <- c("aaa 12 DD aaa",
##        "bbb 22 AM bbb",
##        "ccc 14 PM ccc")
## ## gsub(reg , "####",x , ignore.case=T, perl = TRUE)
## regexpr(reg[[1]], x, perl=T)


context("Guessing format")

test_that(".get_train_set can find non NA dates", {
  x <- suppressWarnings(suppressMessages(ymd(c(rep(NA, 199), 20130213))))
  expect_equal(x, as.Date(as.POSIXct(c(rep(NA, 199), "2013-02-13"), tz = "UTC")))
})
