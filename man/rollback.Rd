\name{rollback}
\alias{rollback}
\title{Roll back date to last day of previous month}
\usage{
  rollback(dates)
}
\arguments{
  \item{dates}{A POSIXct, POSIXlt or Date class object.}
}
\value{
  A date-time object of class POSIXlt, POSIXct or Date,
  whose day has been adjusted to the last day of the
  previous month. date <- ymd("2010-03-03") # "2010-03-03
  UTC" rollback(date) # "2010-02-28 UTC"

  dates <- date + months(0:2) "2010-03-03 UTC" "2010-04-03
  UTC" "2010-05-03 UTC" rollback(dates) "2010-02-28 UTC"
  "2010-03-31 UTC" "2010-04-30 UTC"
}
\description{
  rollback changes a date to the last day of the previous
  month. The new date retains the same hour, minute, and
  second information.
}

