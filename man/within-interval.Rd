% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/intervals.r
\name{\%within\%}
\alias{\%within\%}
\alias{\%within\%,Interval,Interval-method}
\alias{\%within\%,ANY,Interval-method}
\alias{\%within\%,Date,list-method}
\alias{\%within\%,POSIXt,list-method}
\alias{\%within\%,Interval,list-method}
\title{Does a date (or interval) fall within an interval?}
\usage{
a \%within\% b
}
\arguments{
\item{a}{An interval or date-time object.}

\item{b}{Either an interval vector, or a list of intervals.

If \code{b} is an interval (or interval vector) it is recycled to the same length as \code{a}.
If \code{b} is a list of intervals, \code{a} is checked if it falls within \emph{any}
of the intervals, i.e. \code{a \%within\% list(int1, int2)} is equivalent to
\code{a \%within\% int1 | a \%within\% int2}.}
}
\value{
A logical vector.
}
\description{
Check whether \code{a} lies within the interval \code{b}, inclusive of the endpoints.
}
\examples{
int <- interval(ymd("2001-01-01"), ymd("2002-01-01"))
int2 <- interval(ymd("2001-06-01"), ymd("2002-01-01"))

ymd("2001-05-03") \%within\% int # TRUE
int2 \%within\% int # TRUE
ymd("1999-01-01") \%within\% int # FALSE

## recycling (carefully note the difference between using a vector of
## intervals and list of intervals for the second argument)
dates <- ymd(c("2014-12-20", "2014-12-30", "2015-01-01", "2015-01-03"))
blackout_vector <- c(
  interval(ymd("2014-12-30"), ymd("2014-12-31")),
  interval(ymd("2014-12-30"), ymd("2015-01-03"))
)
dates \%within\% blackout_vector

## within ANY of the intervals of a list
dates <- ymd(c("2014-12-20", "2014-12-30", "2015-01-01", "2015-01-03"))
lst <- list(
  interval(ymd("2014-12-30"), ymd("2014-12-31")),
  interval(ymd("2014-12-30"), ymd("2015-01-03"))
)
dates \%within\% lst

## interval within a list of intervals
int <- interval(
  ymd("2014-12-20", "2014-12-30"),
  ymd("2015-01-01", "2015-01-03")
)
int \%within\% lst
}
