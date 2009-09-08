#' Get/set seconds component of a date-time.
#'
#' Date-time must be a  POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases .default second.zoo second.its second.ti second.timeseries second.fts second.irts second
#' @method second default 
#' @method second zoo 
#' @method second its 
#' @method second ti 
#' @method second timeseries 
#' @method second fts 
#' @method second irts
#' @param x a date-time object   
#' @return the seconds element of x as a decimal number
#' @keywords utilities manip chron methods
#' @examples
#' x <- Sys.time()
#' second(x)
#' second(x) <- 1
#' second(x) <- 61 
#' second(x) > 2
second <- function(x) 
  UseMethod("second")
  
second.default <- function(x)
    as.POSIXlt(x)$sec
    
second.zoo <- function(x)
  as.POSIXlt(index(x))$sec
  
second.its <- function(x)
  second.default(attr(x, "dates"))
  
second.ti <- second.jul <- function(x)
  tis::hms(x)$sec

second.timeSeries <- function(x)
  second.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))

second.fts <- function(x)
  second.default(dates(x))
  
second.irts <- function(x)
  second.default(x$time)


#' Get/set minutes component of a date-time.
#'
#' Date-time must be a  POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases minute.default minute.zoo minute.its minute.ti minute.timeseries minute.fts minute.irts minute
#' @method minute default 
#' @method minute zoo 
#' @method minute its 
#' @method minute ti 
#' @method minute timeseries 
#' @method minute fts 
#' @method minute irts
#' @param x a date-time object   
#' @keywords utilities manip chron methods
#' @return the minutes element of x as a decimal number
#' @examples
#' x <- Sys.time()
#' minute(x)
#' minute(x) <- 1
#' minute(x) <- 61 
#' minute(x) > 2
minute <- function(x) 
  UseMethod("minute")
  
minute.default <- function(x)
    as.POSIXlt(x)$min
    
minute.zoo <- function(x)
  as.POSIXlt(index(x))$min

minute.its <- function(x)
  minute.default(attr(x, "dates"))
  
minute.ti <- minute.jul <- function(x)
  tis::hms(x)$min

minute.timeSeries <- function(x)
  minute.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
  
minute.fts <- function(x)
  minute.default(dates(x))

minute.irts <- function(x)
  minute.default(x$time)


#' Get/set hours component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases hour.default hour.zoo hour.its hour.ti hour.timeseries hour.fts hour.irts hour
#' @method hour default 
#' @method hour zoo 
#' @method hour its 
#' @method hour ti 
#' @method hour timeseries 
#' @method hour fts 
#' @method hour irts
#' @param x a date-time object   
#' @keywords utilities manip chron methods
#' @return the hours element of x as a decimal number
#' @examples
#' x <- Sys.time()
#' hour(x)
#' hour(x) <- 1
#' hour(x) <- 61 
#' hour(x) > 2
hour <- function(x) 
  UseMethod("hour")
  
hour.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$hour
    
hour.zoo <- function(x)
  hour.default(index(x))
  
hour.its <- function(x)
  hour.default(attr(x, "dates"))
  
hour.ti <- hour.jul <- function(x)
  tis::hms(x)$hour
  
hour.timeSeries <- function(x)
  hour.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
  
hour.fts <- function(x)
  hour.default(dates(x))
  
hour.irts <- function(x)
  as.POSIXlt(x$time, tz = "GMT")$hour

#' Get/set days component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases yday.default yday.zoo yday.its yday.ti yday.timeseries yday.fts yday.irts wday.default wday.zoo wday.its wday.ti wday.timeseries wday.fts wday.irts mday.default mday.zoo mday.its mday.ti mday.timeseries mday.fts mday.irts yday mday wday
#' @method yday default 
#' @method yday zoo 
#' @method yday its 
#' @method yday ti 
#' @method yday timeseries 
#' @method wday fts 
#' @method wday irts   
#' @method wday default 
#' @method wday zoo 
#' @method wday its 
#' @method wday ti 
#' @method wday timeseries 
#' @method wday fts 
#' @method wday irts 
#' @method mday default 
#' @method mday zoo 
#' @method mday its 
#' @method mday ti 
#' @method mday timeseries 
#' @method mday fts 
#' @method mday irts 
#' @param x a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, or fts object. 
#' @param label logical. Only available for wday. TRUE will display the day of the week as a character string label such as "Sunday." FALSE will display the day of the week as a number.
#' @param abbr logical. Only available for wday. FALSE will display the day of the week as a character string label such as "Sunday." TRUE will display an abbreviated version of the label, such as "Sun". abbr is disregarded if label = FALSE.
#' @return yday returns the day of the year as a decimal number (01-366). mday returns the day of the month as a decimal number (01-31). wday returns the day of the week as a decimal number (01-07, Sunday is 1).
#' @keywords utilities manip chron methods
#' @examples
#' x <- as.Date("2009-09-02")
#' yday(x) #245
#' mday(x) #2
#' wday(x) #4
#' yday(x) <- 1  #"2009-01-01"
#' yday(x) <- 366 #"2010-01-01"
#' mday(x) > 3
#'
#' wday(ymd(080101))
#' # 3
#' wday(ymd(080101), label = T)
#' # "Tuesday"
#' wday(ymd(080101), label = T, abbr = T)
#' # "Tues"
#' wday(ymd(080101) + days(-2:4), label = T, abbr = T)
#' # "Sun"   "Mon"   "Tues"  "Wed"   "Thurs" "Fri"   "Sat" 
yday <- function(x) 
  UseMethod("yday")
  
yday.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$yday + 1
    
yday.zoo <- function(x)
  yday.default(index(x))

yday.its <- function(x)
  yday.default(attr(x, "dates"))
  
yday.ti <- yday.jul <- function(x)
  yday.default(as.Date(x))
  
yday.timeSeries <- function(x)
  yday.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
  
yday.fts <- function(x)
  yday.default(dates(x))
  
yday.irts <- function(x)
  as.POSIXlt(x$time, tz = "GMT")$yday + 1

wday <- function(x, label = FALSE, abbr = FALSE) 
  UseMethod("wday")
  
wday.default <- function(x, label = FALSE, abbr = FALSE){
  wday(as.POSIXlt(x, tz = tz(x))$wday + 1, label, abbr)
}

wday.numeric <- function(x, label = FALSE, abbr = FALSE) {
  if (!label) return(x)
  
  if (abbr) {
    labels <- c("Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat")
  } else {
    labels <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                "Friday", "Saturday")
  }
  ordered(x, labels = labels)  
}

wday.zoo <- function(x, label = FALSE, abbr = FALSE)
  wday.default(index(x), label, abbr)

wday.its <- function(x, label = FALSE, abbr = FALSE)
  wday.default(attr(x, "dates"), label, abbr)
  
wday.ti <- wday.jul <- function(x, label = FALSE, abbr = FALSE)
  wday.default(as.Date(x), label, abbr)
  
wday.timeSeries <- function(x, label = FALSE, abbr = FALSE)
  wday.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), label, abbr)
  
wday.fts <- function(x, label = FALSE, abbr = FALSE)
  wday.default(dates(x), label, abbr)
  
wday.irts <- function(x, label = FALSE, abbr = FALSE){
  wday(x$time, label, abbr)
}
  
mday <- day <- function(x) 
  UseMethod("mday")
  
mday.default <- function(x)
  as.POSIXlt(x, tz = tz(x))$mday
    
mday.zoo <- function(x)
  mday.default(index(x))

mday.its <- function(x)
  mday.default(attr(x, "dates"))
  
mday.ti <- mday.jul <- function(x)
  mday.default(as.Date(x))
  
mday.timeSeries <- function(x)
  mday.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
  
mday.fts <- function(x)
  mday.default(dates(x))
  
mday.irts <- function(x)
  as.POSIXlt(x$time, tz = "GMT")$mday

#' Get/set weeks component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. Weeks is 
#' the number of complete seven day periods that have occured between the date 
#' and  January 1st, plus one. 
#'
#' @param x a date-time object   
#' @return the weeks element of x as an integer number
#' @keywords utilities manip chron
#' @examples
#' x <- Sys.time()
#' week(x) 
#' week(x) <- 1  
#' week(x) <- 54
#' week(x) > 3
week <- function(x)
  yday(x) %/% 7 + 1


#' Get/set months component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' @aliases month.default month.zoo month.its month.ti month.timeseries month.fts month.irts month
#' @method month default 
#' @method month zoo 
#' @method month its 
#' @method month ti 
#' @method month timeseries 
#' @method month fts 
#' @method month irts 
#' @param x a date-time object  
#' @param label logical. TRUE will display the month as a character string such as "January." FALSE will display the month as a number.
#' @param abbr logical. FALSE will display the month as a character string label, such as "January". TRUE will display an abbreviated version of the label, such as "Jan". abbr is disregarded if label = FALSE. 
#' @return the months element of x as a number (1-12) or character string. 1 = January.
#' @keywords utilities manip chron methods
#' @examples
#' x <- Sys.time()
#' month(x) 
#' month(x) <- 1  
#' month(x) <- 13
#' month(x) > 3
#'
#' month(ymd(080101))
#' # 1
#' month(ymd(080101), label = T)
#' # "January"
#' month(ymd(080101), label = T, abbr = T)
#' # "Jan"
#' month(ymd(080101) + months(0:11), label = T, abbr = T)
#' # "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"
month <- function(x, label = FALSE, abbr = FALSE) 
  UseMethod("month")
  
month.default <- function(x, label = FALSE, abbr = FALSE)
  month(as.POSIXlt(x, tz = "GMT")$mon + 1, label, abbr)
  
month.numeric <- function(x, label = FALSE, abbr = FALSE) {
  if (!label) return(x)
  
  if (abbr) {
    labels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep",
                "Oct", "Nov", "Dec")
  } else {
    labels <- c("January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November",
                "December")
  }
  
  ordered(x, labels = labels)
}
    
month.zoo <- function(x, label = FALSE, abbr = FALSE)
  month.default(index(x), label, abbr)

month.its <- function(x, label = FALSE, abbr = FALSE)
  month.default(attr(x, "dates"), label, abbr)  

month.ti <- month.jul <- function(x, label = FALSE, abbr = FALSE)
  month.default(as.Date(x), label, abbr)
  
month.timeSeries <- function(x, label = FALSE, abbr = FALSE)
  month.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), label, abbr)
  
month.fts <- function(x, label = FALSE, abbr = FALSE)
  month.default(dates(x), label, abbr)
  
month.irts <- function(x, label = FALSE, abbr = FALSE)
  month(x$time)
  
#' Get/set years component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' year does not yet support years before 0 C.E.
#'
#' @aliases year year.default year.zoo year.its year.ti year.timeseries year.fts year.irts
#' @method year default 
#' @method year zoo 
#' @method year its 
#' @method year ti 
#' @method year timeseries 
#' @method year fts 
#' @method year irts 
#' @param x a date-time object   
#' @return the years element of x as a decimal number
#' @keywords utilities manip chron methods
#' @examples
#' x <- Sys.time()
#' year(x) 
#' year(x) <- 2001  
#' year(x) > 1995
year <- function(x) 
  UseMethod("year")
  
year.default <- function(x)
    as.POSIXlt(x, tz = tz(x))$year + 1900
    
year.zoo <- function(x)
  year.default(index(x))

year.its <- function(x)
  year.default(attr(x, "dates"))
  
year.ti <- year.jul <- function(x)
  year.default(as.Date(x))

year.timeSeries <- function(x)
  year.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))
  
year.fts <- function(x)
  year.default(dates(x))
  
year.irts <- function(x)
  as.POSIXlt(x$time, tz = "GMT")$year + 1900
  
  
#' Get/set time zone component of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
#'
#' Setting tz does not update a date-time to display the same moment as measured 
#' at a different time zone. See \code{link{with_tz}}. Setting a new time zone 
#' creates a new date-time. The numerical value of the hours element stays the 
#' same, only the time zone attribute is replaced.  This creates a new date-time 
#' that occurs an integer value of hours before or after the original date-time.  
#'
#' If x is of a class that displays all date-times in the GMT timezone, such as 
#' chron, then R will update the number in the hours element to display the new 
#' date-time in the GMT timezone. 
#'
#' For a description of the time zone attribute, see \code{\link[base]{DateTimeClasses}}. 
#'
#' @aliases tz tz.default tz.zoo tz.its tz.ti tz.timeseries tz.fts tz.irts 
#' @method tz default 
#' @method tz zoo 
#' @method tz its 
#' @method tz ti 
#' @method tz timeseries 
#' @method tz fts 
#' @method tz irts 
#' @param x a date-time object   
#' @return the first element of x's tzone attribute vector as a character string. If no tzone attribute exists, tz returns "GMT".
#' @keywords utilities manip chron methods
#' @examples
#' x <- Sys.time()
#' tz(x) 
#' tz(x) <- "GMT"  
#' x
#' tz(x) <- ""
#' x
#' Sys.setenv(TZ = "GMT")
#' x
#' tz(x)
#' Sys.unsetenv("TZ")
tz <- function (x) 
  UseMethod("tz")

tz.default <- function(x) {
  if (is.null(attr(x,"tzone")) && !is.POSIXt(x))
    return("GMT")
  tzs <- attr(as.POSIXlt(x),"tzone")
  tzs[1]
}

tz.zoo <- function(x){
  tzs <- attr(as.POSIXlt(index(x)), "tzone")
  tzs[1]
}

tz.its <- function(x)
  tz.default(attr(x, "dates"))

tz.ti <- tz.jul <- function(x)
  tz.default(as.Date(x))
  
tz.timeSeries <- function(x)
  x@FinCenter

tz.fts <- function(x)
  tz.default(dates(x))
  
tz.irts <- function(x)
  return("GMT")


#' Get Daylight Savings Time indicator of a date-time.
#'
#' Date-time must be a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, 
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects. 
#'
#' A date-time's daylight savings flag can not be set because it depends on the 
#' date-time's year, month, day, and hour values.
#'
#' @aliases dst dst.default dst.zoo dst.its dst.ti dst.timeseries dst.fts dst.irts
#' @method dst default 
#' @method dst zoo 
#' @method dst its 
#' @method dst ti 
#' @method dst timeseries 
#' @method dst fts 
#' @method dst irts 
#' @param x a date-time object   
#' @return Daylight savings time flag. Positive if in force, zero if not, negative if unknown.
#' @seealso \code{\link{DaylightSavingsTime}}
#' @keywords utilities chron methods
#' @examples
#' x <- Sys.time()
#' dst(x) 
dst <- function(x)
  UseMethod("dst")
  
dst.default <- function(x)
  as.POSIXlt(x)$isdst
    
dst.zoo <- function(x)
  as.POSIXlt(index(x))$isdst
  
dst.its <- function(x)
  dst.default(attr(x, "dates"))
  
dst.ti <- dst.jul <- function(x)
  tis::hms(x)$isdst

dst.timeSeries <- function(x)
  dst.default(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter))

dst.fts <- function(x)
  dst.default(dates(x))
  
dst.irts <- function(x)
  dst.default(x$time)

#' Internal function. Replaces the seconds element of a date with a specified 
#' value.
#' 
#' @method second<- default
#' @method second<- chron
#' @method second<- zoo
#' @method second<- its
#' @method second<- ti
#' @method second<- timeDate
#' @method second<- jul
#' @method second<- timeSeries
#' @method second<- fts
#' @method second<- irts
#' @param x a date-time object
#' @param value a number that will be substituted for the date's seconds component.   
#' @seealso \code{\link{second}}  
#' @keywords internal methods chron manip
"second<-" <- function(x, value){
  if (all(value == second(x)))
    return(x)
  UseMethod("second<-")
}

"second<-.default" <- function(x, value){
  new <- as.POSIXct(x) - (second(x) - value)
  DST(x, new)
}

"second<-.chron" <- "second<-.timeDate" <- function(x, value){
  date <- "second<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"second<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "second<-"(index(x), value)
  'index<-'(x, new)
}


"second<-.its" <- function(x, value){
  dates <- "second<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"second<-.ti" <- function(x, value){
  date <- "second<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"second<-.jul" <- function(x, value)
  x - (second(x) - value)/86400


"second<-.timeSeries" <- function(x, value){
  positions <- "second<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"second<-.fts" <- function(x, value){
  date <- "second<-.default"(dates(x), value)
  fts(x, date)
}

"second<-.irts" <- function(x, value){
  x$time <- "second<-.default"(x$time, value)
  x
}

#' Internal function. Replaces the minutes element of a date with a specified 
#' value.
#' 
#' @method minute<- default
#' @method minute<- chron
#' @method minute<- zoo
#' @method minute<- its
#' @method minute<- ti
#' @method minute<- timeDate
#' @method minute<- jul
#' @method minute<- timeSeries
#' @method minute<- fts
#' @method minute<- irts
#' @param x a date-time object
#' @param value a number that will be substituted for the date's minutes component.    
#' @seealso \code{\link{minute}} 
#' @keywords internal methods chron manip
"minute<-" <- function(x, value){
  if (all(value == minute(x)))
    return(x)
  UseMethod("minute<-")
}

"minute<-.default" <- function(x, value){
  new <- as.POSIXct(x) - (minute(x) - value) * 60
  DST(x, new)
}


"minute<-.chron" <- "minute<-.timeDate" <- function(x, value){
  date <- "minute<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"minute<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "minute<-"(index(x), value)
  'index<-'(x, new)
}

"minute<-.its" <- function(x, value){
  dates <- "minute<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"minute<-.ti" <- function(x, value){
  date <- "minute<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"minute<-.jul" <- function(x, value)
  x - (minute(x) - value)*60/86400

"minute<-.timeSeries" <- function(x, value){
  positions <- "minute<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"minute<-.fts" <- function(x, value){
  date <- "minute<-.default"(dates(x), value)
  fts(x, date)
}

"minute<-.irts" <- function(x, value){
  x$time <- "minute<-.default"(x$time, value)
  x
}

#' Internal function. Replaces the hours element of a date with a specified 
#' value.
#' 
#' @method hour<- default
#' @method hour<- chron
#' @method hour<- zoo
#' @method hour<- its
#' @method hour<- ti
#' @method hour<- timeDate
#' @method hour<- jul
#' @method hour<- timeSeries
#' @method hour<- fts
#' @method hour<- irts
#' @param x a date-time object
#' @param value a number that will be substituted for the date's hours component.  
#' @seealso \code{\link{hour}}   
#' @keywords internal methods chron manip
"hour<-" <- function(x, value) {
  if (all(value == hour(x)))
    return(x)
  UseMethod("hour<-")
}

"hour<-.default" <- function(x, value){
  new <- as.POSIXct(x, tz = tz(x)) - (hour(x) - value) * 3600
  DST(x, new)
}


"hour<-.chron" <- "hour<-.timeDate" <- function(x, value){
  date <- "hour<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"hour<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "hour<-"(index(x), value)
  'index<-'(x, new)
}

"hour<-.its" <- function(x, value){
  dates <- "hour<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"hour<-.ti" <- function(x, value){
  date <- "hour<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"hour<-.jul" <- function(x, value)
  x - (hour(x) - value)*3600/86400

"hour<-.timeSeries" <- function(x, value){
  positions <- "hour<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"hour<-.fts" <- function(x, value){
  date <- "hour<-.default"(dates(x), value)
  fts(x, date)
}

"hour<-.irts" <- function(x, value){
  x$time <- as.POSIXlt(x$time, tz = "GMT") - (hour(x) - value) * 3600
  x
}

#' Internal function. Replaces the ydays element of a date with a specified 
#' value.
#' 
#' @method yday<- default
#' @method yday<- Date
#' @method yday<- chron
#' @method yday<- zoo
#' @method yday<- its
#' @method yday<- ti
#' @method yday<- timeDate
#' @method yday<- jul
#' @method yday<- timeSeries
#' @method yday<- fts
#' @method yday<- irts
#' @param x a date-time object
#' @param value a number that will be substituted for the date's ydays component.   
#' @seealso \code{\link{yday}} 
#' @keywords internal methods chron manip
"yday<-" <- function(x, value){
  if (all(value == yday(x)))
    return(x)
  UseMethod("yday<-")
}

"yday<-.default" <- function(x, value){
  new <- as.POSIXct(x) - (yday(x) - value) * 3600 * 24
  DST(x, new)
}


"yday<-.Date" <- "yday<-.chron" <- "yday<-.timeDate" <- function(x, value){
  date <- "yday<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"yday<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "yday<-"(index(x), value)
  'index<-'(x, new)
}

"yday<-.its" <- function(x, value){
  dates <- "yday<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"yday<-.ti" <- function(x, value){
  date <- "yday<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"yday<-.jul" <- function(x, value)
  x - (yday(x) - value)*3600*24/86400

"yday<-.timeSeries" <- function(x, value){
  positions <- "yday<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"yday<-.fts" <- function(x, value){
  date <- "yday<-.default"(dates(x), value)
  fts(x, date)
}

"yday<-.irts" <- function(x, value){
  x$time <- as.POSIXlt(x$time, tz = "GMT") - (yday(x) - value) * 3600 * 24
  x
}

#' Internal function. Replaces the wdays element of a date with a specified 
#' value.
#' 
#' @method wday<- default
#' @method wday<- Date
#' @method wday<- chron
#' @method wday<- zoo
#' @method wday<- its
#' @method wday<- ti
#' @method wday<- timeDate
#' @method wday<- jul
#' @method wday<- timeSeries
#' @method wday<- fts
#' @method wday<- irts
#' @param x a date-time object
#' @param value a number that will be substituted for the date's wdays component.   
#' @seealso \code{\link{wday}} 
#' @keywords internal methods chron manip
"wday<-" <- function(x, value){
  if (all(value == wday(x)))
    return(x)
  UseMethod("wday<-")
}

"wday<-.default" <- function(x, value){
  new <- as.POSIXct(x) - (wday(x) - value) * 3600 * 24
  DST(x, new)
}

"wday<-.Date" <- "wday<-.chron" <- "wday<-.timeDate" <- function(x, value){
  date <- "wday<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"wday<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "wday<-"(index(x), value)
  'index<-'(x, new)
}


"wday<-.its" <- function(x, value){
  dates <- "wday<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"wday<-.ti" <- function(x, value){
  date <- "wday<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"wday<-.jul" <- function(x, value)
  x - (wday(x) - value)*3600*24/86400

"wday<-.timeSeries" <- function(x, value){
  positions <- "wday-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"wday<-.fts" <- function(x, value){
  date <- "wday<-.default"(dates(x), value)
  fts(x, date)
}

"wday<-.irts" <- function(x, value){
  x$time <- as.POSIXlt(x$time, tz = "GMT") - (wday(x) - value) * 3600 * 24
  x
}

#' Internal function. Replaces the mdays element of a date with a specified 
#' value.
#' 
#' @method mday<- default
#' @method mday<- Date
#' @method mday<- chron
#' @method mday<- zoo
#' @method mday<- its
#' @method mday<- ti
#' @method mday<- timeDate
#' @method mday<- jul
#' @method mday<- timeSeries
#' @method mday<- fts
#' @method mday<- irts
#' @param x a date-time object
#' @param value a number that will be substituted for the date's mdays component.   
#' @seealso \code{\link{mday}} 
#' @keywords internal methods chron manip
"mday<-" <- "day<-" <- function(x, value){
  if (all(value == mday(x)))
    return(x)
  UseMethod("mday<-")
}

"mday<-.default" <- function(x, value){
  new <- as.POSIXct(x) - (mday(x) - value) * 3600 * 24
  DST(x, new)
}

"mday<-.Date" <- "mday<-.chron" <- "mday<-.timeDate" <-function(x, value){
  date <- "mday<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"mday<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "mday<-"(index(x), value)
  'index<-'(x, new)
}

"mday<-.its" <- function(x, value){
  dates <- "mday<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"mday<-.ti" <- function(x, value){
  date <- "mday<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"mday<-.jul" <- function(x, value)
  x - (mday(x) - value)*3600*24/86400

"mday<-.timeSeries" <- function(x, value){
  positions <- "mday<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"mday<-.fts" <- function(x, value){
  date <- "mday<-.default"(dates(x), value)
  fts(x, date)
}

"mday<-.irts" <- function(x, value){
  x$time <- as.POSIXlt(x$time, tz = "GMT") - (mday(x) - value) * 3600 * 24  
  x
}

#' Internal function. Replaces the weeks element of a date with a specified 
#' value.
#' 
#' @method week<- default
#' @method week<- Date
#' @method week<- chron
#' @method week<- zoo
#' @method week<- its
#' @method week<- ti
#' @method week<- timeDate
#' @method week<- jul
#' @method week<- timeSeries
#' @method week<- fts
#' @method week<- irts
#' @param x a date-time object
#' @param value a number that will be substituted for the date's weeks component.   
#' @seealso \code{\link{week}} 
#' @keywords internal methods chron manip
"week<-" <- function(x, value){
  if (all(value == week(x)))
    return(x)
  UseMethod("week<-")
}

"week<-.default" <- function(x, value){
  new <- as.POSIXct(x) - (week(x) - value) * 3600 * 24 * 7
  DST(x, new)
}

"week<-.Date" <- "week<-.chron" <- "week<-.timeDate" <- function(x, value){
  date <- "week<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"week<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "week<-"(index(x), value)
  'index<-'(x, new)
}

"week<-.its" <- function(x, value){
  dates <- "week<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"week<-.ti" <- function(x, value){
  date <- "week<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"week<-.jul" <- function(x, value)
  x - (week(x) - value)*3600*24*7/86400

"week<-.timeSeries" <- function(x, value){
  positions <- "week<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"week<-.fts" <- function(x, value){
  date <- "week<-.default"(dates(x), value)
  fts(x, date)
}

"week<-.irts" <- function(x, value){
  x$time <- as.POSIXlt(x$time, tz = "GMT") - (week(x) - value) * 3600 * 24 * 7
  x
}

#' Internal function. Replaces the months element of a date with a specified 
#' value.
#' 
#' @method month<- default
#' @method month<- Date
#' @method month<- chron
#' @method month<- zoo
#' @method month<- its
#' @method month<- ti
#' @method month<- timeDate
#' @method month<- jul
#' @method month<- timeSeries
#' @method month<- fts
#' @method month<- irts
#' @method month<- yearmon
#' @param x a date-time object
#' @param value a number that will be substituted for the date's months component.   
#' @seealso \code{\link{month}} 
#' @keywords internal methods chron manip
"month<-" <- function(x, value) {
  if (all(value == month(x)))
    return(x)
  UseMethod("month<-")
}

"month<-.default" <- function(x, value){
  new <- ISOdatetime(
    year(x) + (value - 1) %/% 12,  
    (value - 1) %% 12 + 1, 
    mday(x), 
    hour(x), 
    minute(x), 
    second(x), 
    tz(x))
  
  warn <- FALSE
  
  for (i in 1:length(new)){
    n <- 1
    while (is.na(new[i])){
      warn <- TRUE
      new[i] <- ISOdatetime(
        year(x) + (value - 1) %/% 12,  
        (value - 1) %% 12 + 1, 
        mday(x) - n, 
        hour(x), 
        minute(x), 
        second(x), 
        tz(x))[i]
      n <- n + 1
    }
  }
    
  if (warn)
    message("Undefined date. Defaulting to last previous real day.")
    
  new
}


"month<-.Date" <- "month<-.chron" <- "month<-.yearmon" <- "month<-.timeDate" <- function(x, value){
  date <- "month<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"month<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "month<-"(index(x), value)
  'index<-'(x, new)
}

"month<-.its" <- function(x, value){
  dates <- "month<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"month<-.ti" <- function(x, value){
  date <- "month<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}


"month<-.jul" <- function(x, value){
  date <- "month<-.default"(x,value)
  as.jul(date)
}

"month<-.timeSeries" <- function(x, value){
  positions <- "month<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"month<-.fts" <- function(x, value){
  date <- "month<-.default"(dates(x), value)
  fts(x, date)
}

"month<-.irts" <- function(x, value){
  x$time <- "month<-.default"(x, value)
  x
}

#' Internal function. Replaces the years element of a date with a specified 
#' value.
#' 
#' @method year<- default
#' @method year<- Date
#' @method year<- chron
#' @method year<- zoo
#' @method year<- its
#' @method year<- ti
#' @method year<- timeDate
#' @method year<- jul
#' @method year<- timeSeries
#' @method year<- fts
#' @method year<- irts
#' @method year<- yearmon
#' @method year<- yearqtr
#' @param x a date-time object
#' @param value a number that will be substituted for the date's years component.   
#' @seealso \code{\link{year}} 
#' @keywords internal methods chron manip
"year<-" <- function(x, value) {
  if (all(value == year(x)))
    return(x)
  UseMethod("year<-")
}

"year<-.default" <- function(x, value){
  new <- ISOdatetime(
    value,  
    month(x), 
    mday(x), 
    hour(x), 
    minute(x), 
    second(x), 
    tz(x))
  
  warn <- FALSE
  
  for (i in 1:length(new)){
    n <- 1
    while (is.na(new[i])){
      warn <- TRUE
      new[i] <- ISOdatetime(
        value,  
        month(x), 
        mday(x) - n, 
        hour(x), 
        minute(x), 
        second(x), 
        tz(x))[i]
      n <- n + 1
    }
  }
    
  if (warn)
    message("Undefined date. Defaulting to last previous real day.")
    
  new
}



"year<-.Date" <- "year<-.chron" <- "year<-.yearmon" <- "year<-.yearqtr" <- "year<-.timeDate" <- function(x, value){
  date <- "year<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"year<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "year<-"(index(x), value)
  'index<-'(x, new)
}

"year<-.its" <- function(x, value){
  dates <- "year<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"year<-.ti" <- function(x, value){
  date <- "year<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}

"year<-.jul" <- function(x, value){
  date <- "year<-.default"(x,value)
  as.jul(date)
}

"year<-.timeSeries" <- function(x, value){
  positions <- "year<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"year<-.fts" <- function(x, value){
  date <- "year<-.default"(dates(x), value)
  fts(x, date)
}

"year<-.irts" <- function(x, value){
  x$time <- "year<-.default"(x, value)
  x
}

#' Internal function. Replaces the time zone element of a date with a specified 
#' value.
#' 
#' @method tz<- default
#' @method tz<- chron
#' @method tz<- zoo
#' @method tz<- its
#' @method tz<- ti
#' @method tz<- timeDate
#' @method tz<- jul
#' @method tz<- timeSeries
#' @method tz<- fts
#' @method tz<- irts
#' @param x a date-time object
#' @param value a number that will be substituted for the date's time zone component.   
#' @seealso \code{\link{tz}} 
#' @keywords internal methods chron manip
"tz<-" <- function(x, value) {
  if (all(value == tz(x)))
    return(x)
  UseMethod("tz<-")
}
  
"tz<-.default" <- function(x, value)
  ISOdatetime(year(x),  month(x), mday(x), hour(x), minute(x), second(x), value)


"tz<-.Date" <- "tz<-.timeDate" <- function(x, value){
  date <- "tz<-.default"(x,value)
  f <- match.fun(paste("as", class(x)[1], sep = "."))
  f(date)
}

"tz<-.zoo" <- function(x, value){
  compatible <- recognize(index(x))
  if(!compatible)
    stop("series uses unrecognized date format")
     
  new <- "tz<-"(index(x), value)
  'index<-'(x, new)
}

"tz<-.its" <- function(x, value){
  dates <- "second<-.default"(attr(x,"dates"), value)
  attr(x, "dates") <- dates
  its(x, dates, format = "%Y-%m-%d %X")
}

"tz<-.ti" <- function(x, value){
  date <- "tz<-.default"(as.Date(x),value)
  as.ti(date, tifName(x))
}


"tz<-.jul" <- function(x, value){
  date <- "tz<-.default"(x,value)
  as.jul(date)
}

"tz<-.timeSeries" <- function(x, value){
  positions <- "tz<-.default"(timeDate(x@positions, zone = x@FinCenter, FinCenter = x@FinCenter), value)
  timeSeries(series(x), positions)
}

"tz<-.fts" <- function(x, value){
  date <- "tz<-.default"(dates(x), value)
  fts(x, date)
}

"tz<-.irts" <- function(x, value){
  warning("irts dates will always display with GMT timezone")
  x$time <- x$time - ("tz<-.default"(x, value) - x$time)
  x
}



#' Changes the components of a date object
#'
#' update is a wrapper function for \code{\link{year}, \link{month},
#' \link{week}, \link{yday}, \link{wday}, \link{mday}, \link{hour},
#' \link{minute}, \link{second}} and \code{\link{tz}}. It returns a date with
#' the specified elements updated. Elements not specified will be left
#' unaltered. Update.Date does not add the specified values to the existing
#'  date, it substitutes them for the appropriate parts of the existing date. 
#'
#' update implements changes in the order year, month, week, yday, wday,
#' mday, hour, minute, second, tz.  If conflicting requests are set, requests
#' that occur later in the order will overwrite those that occur earlier.  If
#' a request causes spillover to another component (such as 13 months, which 
#' spills over to 1 year and 1 month) this spillover will be added to any 
#' requests inputed for the first category (see examples).
#'
#' If the seconds, minutes, or hours element is updated, a POSIXt object will 
#' be returned, even when object is a Date object.  Date objects do not support
#' seconds, minutes, or hours. R recognizes Date objects as having an initial 
#' value of zero for hours, minutes, and seconds in the "UTC" time zone. Since 
#' Date objects are displayed in the "UTC" time zone and as.POSIXt objects are 
#' displayed in the preset system time zone of your computer, a change in clock
#' time will normlly occur when the class of the object switches. Both clock times 
#' will still refer to the same instant of time, but in different time zones.
#' 
#' A date-time element may be updated to a vector of numbers. update will 
#' return a vector of updated times, one for each element. If multiple elements
#' are updated to vectors of numbers, update will return a vector of dates that
#' reflects all combinations of the updated elements.
#' 
#' @aliases update.Date update.POSIXt update.POSIXct update.POSIXlt
#' @method update Date
#' @method update POSIXt
#' @param object a date-time object  
#' @param year a value to substitute for the date's year component
#' @param month a value to substitute for the date's month component
#' @param week a value to substitute for the date's week component
#' @param yday a value to substitute for the date's yday component
#' @param wday a value to substitute for the date's wday component
#' @param mday a value to substitute for the date's mday component
#' @param hour a value to substitute for the date's hour component
#' @param minute a value to substitute for the date's minute component
#' @param second a value to substitute for the date's second component
#' @param tz a value to substitute for the date's tz component
#' @return a date object with the requested elements updated. The object will retain its original class unless an element is updated which the original class does not support. In this case, the date returned will be a POSIXlt date object.
#' @keywords manip chron 
#' @examples
#' date <- as.POSIXlt("2009-02-10") 
#' update(date, year = 2010, month = 1, mday = 1)
#' # "2010-01-01 CST"
#'
#' update(date, year =2010, month = 13, mday = 1)
#' # "2011-01-01 CST"
#'
#' update(date, yday = 35, wday = 4, mday = 3) 
#' # "2009-02-03 CST"
#'
#' update(date, minute = 10, second = 3)
#' # "2009-02-10 00:10:03 CST"
update.Date <- update.POSIXt <- function(object, ...) {
  object <- as.POSIXct(object)

  todo <- list(...)
  names(todo) <- standardise_date_names(names(todo))
  
  changes <- as.list(list(year = todo$year, 
    month = todo$month, 
    week = todo$week,
    day = todo$day, 
    yday = todo$yday,
    wday = todo$wday,
    mday = todo$mday, 
    hour = todo$hour, 
    minute = todo$minute, 
    second = todo$second,
    tz = todo$tz))  
  
  which.null <- function(x){
  nulls <- rep(FALSE, length(x))
  for (i in 1:length(x))
    if( is.null(x[[i]]) ) nulls[i] <- TRUE
  nulls
  }
  
  changes <- changes[!which.null(changes)]
  
  for(change in names(changes)) {
    f1 <- match.fun(change)
    
    if(any(changes[[change]] != f1(object))){
       f2 <- match.fun(paste(change, "<-", sep = ""))
      new <- vector()
    
      for(i in 1:length(object))
        new <- c(new, f2(object[i], changes[[change]]))
    
    class(new) <- c("POSIXt", "POSIXct")
    object <- new
  }
  }
  
  object
}


#' Internal function
#'
#' @keywords internal
standardise_date_names <- function(x) {
  dates <- c("second", "minute", "hour", "day", "mday", "wday", "yday", "week", "month", "year", "tz")
  y <- gsub("(.)s$", "\\1", x)
  res <- dates[pmatch(y, dates)]
  if (any(is.na(res))) {
    stop("Invalid date name: ", paste(x[is.na(res)], collapse = ", "), 
      call. = FALSE)
  }
  res
}


#' Converts a date to a decimal of its year. 
#'
#' @aliases decimal_date decimal.date decimal_date.default decimal_date.zoo decimal_date.its
#' methods decimal_date default
#' methods decimal_date zoo
#' methods decimal_date its
#' @param date a POSIXt or Date object   
#' @return a numeric object where the date is expressed as a fraction of its year
#' @keywords manip chron methods
#' @examples
#' date <- as.POSIXlt("2009-02-10")
#' decimal_date(date)  # 2009.109
decimal_date <- function(date)
  UseMethod("decimal_date")
  
decimal_date.default <- function(date){
  if(any(!inherits(date, c("POSIXt", "POSIXct", "POSIXlt", "Date"))))
    stop("date(s) not in POSIXt or Date format")
  just_year <- floor_date(date, "year")
  
  decimal <- just_seconds(date - just_year)/ (3600*24*365)
  
  leap_years <- which(leap.year(date))
  decimal[leap_years] <- just_seconds(date - just_year)[leap_years]/ (3600*24*366)

  year(date) + decimal
}

decimal_date.zoo <- function(date)
  decimal_date(index(date))

decimal_date.its <- function(x)
  decimal_date.default(attr(x,"dates"))

#' Returns just the months component of a duration. 
#'
#' @param dur a duration object 
#' @return the number of months as well as the number of years (as months) contained in a duration. See \code{link{duration}} for further details.   
#' @seealso \code{link{just_seconds}}
#' @keywords utilities chron
#' @examples
#' x <- new_duration(year = 1, month = 4, day = 30, hour = 2, second = 1)
#' x # 1 year, 4 months, 4 weeks, 2 days, 2 hours and 1 second
#' just_months(x)  # 16
just_months <- function(dur)
  as.numeric(dur) %/% 10^11

#' Returns just the seconds component of a duration. 
#'
#' @param dur a duration object  
#' @return the number of weeks, days, hours, minutes, and seconds in a duration as seconds. See \code{link{duration}} for further details.
#' @seealso \code{link{just_months}}
#' @keywords utilities chron
#' @examples
#' x <- new_duration(year = 1, month = 4, day = 30, hour = 2, second = 1)
#' x # 1 year, 4 months, 4 weeks, 2 days, 2 hours and 1 second
#' just_seconds(x)  # 2599201
just_seconds <- function(dur)
  as.numeric(dur) %% 10^11 - 50000000000

#' Internal function. Is an object in a recognized date format?
#'
#' @param x an R object
#' @return TRUE if x is a POSIXlt, POSIXct, yearmon, yearqtr, or Date object, FALSE otherwise.
#' @keywords internal
recognize <- function(x){
  recognized <- c("POSIXt", "POSIXlt", "POSIXct", "yearmon", "yearqtr", "Date")
  
  if (all(class(x) %in% recognized))
    return(TRUE)
  return(FALSE)
}


#' Internal function for Daylight Savings Time changes.
#'
#' Determines how to handle time changes resulting from Daylight Savings time 
#' based on options("DST"). See \code{link{DaylightSavingsTime}}.
#'
#' @aliases DST DST.months 
#' @keywords internal
DST <- function(date1, date2){
  if(is.Date(date2))
    return(date2)
    
  date1 <- as.POSIXlt(date1)
  date2 <- as.POSIXlt(date2)

  if(dst(date1) < 0 || dst(date2) < 0)
    return(date2)

  date2 - (dst(date2) - dst(with_tz(date1, tz(date2))))*3600
}

DST.months <- function(date1, date2){
  if(is.Date(date2))
    return(date2)
  date1 <- as.POSIXlt(date1)
  date2 <- as.POSIXlt(date2)

  if(dst(date1) < 0 || dst(date2) < 0)
    return(date2)

  suppressMessages(date2 + (dst(date2) - with_tz(date1, tz(date2)))*3600)
}