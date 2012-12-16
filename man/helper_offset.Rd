\name{helper_offset}
\alias{helper_offset}
\title{helper_offset}
\usage{
  helper_offset(..., sep = ":")
}
\arguments{
  \item{...}{a vector of POSIXct date-time objects}

  \item{sep}{character, hour-minute seperator, default ":"}
}
\value{
  a character vector "+HHMM", "-HH:MM", etc.
}
\description{
  function to make a character representation of date-time
  offset from UTC
}
\details{
  uses the timezone associated to the input vector to
  determine the UTC offset for each member.
}
\examples{
my_instant <- ymd_hms_o("2012-03-04T05:06:07-05:00")
my_offset <- helper_offset(with_tz(my_instant, tz="America/New_York"), sep=":")
paste(format(my_instant, "\\\%Y-\\\%m-\\\%dT\\\%H:\\\%M:\\\%S"), my_offset, sep="")
}

