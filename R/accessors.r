# Generic accessor code for date time classes we work with
#
# See tests/accessor.R for test code

# install.packages(c("chron", "timeDate", "zoo", "xts", "its", "tis", 
#  "timeSeries", "fts", "tseries"))

as.POSIXlt.fts <- function(x, tz = "", ...) as.POSIXlt(fts::dates.fts(x))
as.POSIXct.fts <- function(x, tz = "", ...) as.POSIXct(fts::dates.fts(x))

as.POSIXlt.its <- function(x, tz = "", ...) as.POSIXlt(attr(x, "dates"))
as.POSIXct.its <- function(x, tz = "", ...) as.POSIXct(attr(x, "dates"))

as.POSIXlt.timeSeries <- function(x, tz = "", ...) {
  as.POSIXlt(timeDate::timeDate(x@positions, 
    zone = x@FinCenter, FinCenter = x@FinCenter))
}
as.POSIXct.timeSeries <- function(x, tz = "", ...) {
  as.POSIXct(timeDate::timeDate(x@positions, 
    zone = x@FinCenter, FinCenter = x@FinCenter))
}

as.POSIXlt.irts <- function(x, tz = "", ...) as.POSIXlt(x$time)
as.POSIXct.irts <- function(x, tz = "", ...) as.POSIXct(x$time)

as.POSIXlt.xts <- function(x, tz = "", ...) as.POSIXlt(zoo::index(x))
as.POSIXct.xts <- function(x, tz = "", ...) as.POSIXct(zoo::index(x))
as.POSIXlt.zoo <- function(x, tz = "", ...) as.POSIXlt(zoo::index(x))
as.POSIXct.zoo <- function(x, tz = "", ...) as.POSIXct(zoo::index(x))

as.POSIXlt.tis <- function(x, tz = "", ...) as.Date(x)