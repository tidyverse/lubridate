# A year is a leap year if it is evenly divisible by 400 or evenly 
# divisible by 4 but not 100.

leap.year <- function(year) {
  (year %% 4 == 0) & ((year %% 100 != 0) | (year %% 400 == 0))
}


now <- function() Sys.time()
today <- Sys.Date()

pretty_dates <- function(dates, n = 5, by = c("auto", "secs", "mins", "hours", "days", "weeks", "months", "years")){
  if (!is.POSIXt(dates)) 
    stop("x must be a POSIXt object")
  if (length(dates) == 0L) 
    return(dates)
        
  by <- match.arg(by)
  switch(by, secs = pretty_secs(dates, n),
    mins = pretty_mins(dates, n),
    hours = pretty_hours(dates, n),
    days = pretty_days(dates, n),
    weeks = pretty_weeks(dates, n),
    months = pretty_months(dates, n),
    years = pretty_years(dates, n))
}

pretty_secs <- function (dates, n) print("secs")
pretty_mins <- function (dates, n) print("mins")
pretty_hours <- function (dates, n) print("hours")
pretty_days <- function (dates, n) print("days")
pretty_weeks <- function (dates, n) print("weeks")
pretty_months <- function (dates, n) print("months")
pretty_years <- function (dates, n) print("years")