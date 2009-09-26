# Generic accessor code for date time classes we work with
#
# See tests/accessor.R for test code

# install.packages(c("chron", "timeDate", "zoo", "xts", "its", "tis", 
#  "timeSeries", "fts", "tseries"))

date <- ymd("2001-01-01") + weeks(1:100)
char <- as.character(date)

dates <- list(
  POSIXct = date, 
  POSIXlt = as.POSIXlt(date), 
  chron = chron::chron(char, format = (dates = "y-m-d")),
  fts = fts::fts(seq_along(char), char),
  its = its::its(seq_along(char), date),
  timeDate = timeDate::timeDate(char),
  timeSeries = timeSeries::timeSeries(seq_along(char), char),
  # tis = tis::tis(seq_along(base), base[1], freq = 52),
  tseries = tseries::irts(date, seq_along(char)),
  xts = xts(seq_along(char), date),
  zoo = zoo(seq_along(char), date)
)

as.POSIXlt.fts <- function(x, tz = "", ...) as.POSIXlt(fts::dates.fts(x))
as.POSIXct.fts <- function(x, tz = "", ...) as.POSIXct(fts::dates.fts(x))

as.POSIXlt.its <- function(x, tz = "", ...) as.POSIXlt(attr(x, "dates"))
as.POSIXct.its <- function(x, tz = "", ...) as.POSIXct(attr(x, "dates"))

as.POSIXlt.timeSeries <- function(x, tz = "", ...) {
  as.POSIXlt(timeDate(x@positions, 
    zone = x@FinCenter, FinCenter = x@FinCenter))
}
as.POSIXct.timeSeries <- function(x, tz = "", ...) {
  as.POSIXct(timeDate(x@positions, 
    zone = x@FinCenter, FinCenter = x@FinCenter))
}

as.POSIXlt.irts <- function(x, tz = "", ...) as.POSIXlt(x$time)
as.POSIXct.irts <- function(x, tz = "", ...) as.POSIXct(x$time)

as.POSIXlt.xts <- function(x, tz = "", ...) as.POSIXlt(index(x))
as.POSIXct.xts <- function(x, tz = "", ...) as.POSIXct(index(x))
as.POSIXlt.zoo <- function(x, tz = "", ...) as.POSIXlt(index(x))
as.POSIXct.zoo <- function(x, tz = "", ...) as.POSIXct(index(x))

as.POSIXlt.tis <- function(x, tz = "", ...) as.Date(x)

check_equal <- function(dates, f) {
  res <- ldply(unname(dates), as.POSIXct)
  stopifnot(nrow(unique(res)) == 1)
}

check_equal(dates, as.POSIXlt)
ldply(unname(dates), yday)
ldply(unname(dates), yday)
