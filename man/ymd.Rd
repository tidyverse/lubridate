\name{ymd}
\title{Parse dates according to the order year, month, and day appears...}
\usage{ymd(...)}

\description{
  Parse dates according to the order year, month, and day appears
}

\details{
  Transforms dates stored in character and numeric vectors to POSIXct
  objects.  These functions automatically recognize the following
  separators: "-", "/", ".", and "" (i.e., no separators).

  Users should choose the function that models the order in which
  year(y), month(m), and date(d) appear in the dates. All inputed dates
  are considered to have the same order and the same separators.
}
\alias{ymd}
\alias{myd}
\alias{dym}
\alias{ydm}
\alias{mdy}
\alias{yearmonthdate}
\value{a vector of POSIXct date-time objects}
\seealso{\code{\link{parse_date}}, \code{\link{guess_format}}}
\keyword{chron}
\arguments{
  \item{...}{a character or numeric vector of suspected dates}
}
\examples{x <- c("09-01-01", "09-01-02", "09-01-03")
ymd(x)
# "2009-01-01 GMT" "2009-01-02 GMT" "2009-01-03 GMT"
z <- c("2009-01-01", "2009-01-02", "2009-01-03")
ymd(z)
# "2009-01-01 GMT" "2009-01-02 GMT" "2009-01-03 GMT"
ymd(090101)
# "2009-01-01 GMT"
ymd(90101)
# "2009-01-01 GMT"
now() > ymd(20090101) 
# TRUE
dmy(010210)
mdy(010210)}
