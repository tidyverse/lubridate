\name{leap.year}
\alias{leap.year}
\title{Is a year a leap year?}
\usage{leap.year(date)}

\description{
  Is a year a leap year?
}

\details{
  If x is a recognized date-time object, leap.year will return whether
  x occurs during a leap year. If x is a number, leap.year returns
  whether it would be a leap year under the Gregorian calendar.

  aliases leap.year leap_year leapyear
}
\value{TRUE if x is a leap year, FALSE otherwise}
\keyword{logic}
\keyword{chron}
\arguments{
  \item{date}{a date-time object or a year}
}
\examples{x <- as.Date("2009-08-02")
leap.year(x) # FALSE
leap.year(2009) # FALSE
leap.year(2008) # TRUE
leap.year(1900) # FALSE
leap.year(2000) # TRUE}
