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
  xts = xts::xts(seq_along(char), date),
  zoo = zoo::zoo(seq_along(char), date)
)

check_equal <- function(f, dates) {
  res <- ldply(unname(dates), as.POSIXct)
  stopifnot(nrow(unique(res)) == 1)
}

testfs <- c(as.POSIXct, as.POSIXlt, year, month, week, yday, mday, wday)
lapply(testfs, check_equal, dates)
