\name{olson_time_zones}
\alias{olson_time_zones}
\title{Names of available time zones}
\usage{
  olson_time_zones(order_by = c("name", "longitude"))
}
\arguments{
  \item{order_by}{Return names alphabetically (the default)
  or from West to East.}
}
\value{
  A character vector of time zone names.
}
\description{
  The names of all available Olson-style time zones.
}
\note{
  Olson-style names are the most readable and portable way
  of specifying time zones.  This function gets names from
  the file shipped with R, stored in the file `zone.tab`.
  \code{?\link[base]{Sys.timezone}} has more information.
}
\examples{
\dontrun{
olson_time_zones()
olson_time_zones("longitude")
}
}
\seealso{
  \code{\link[base]{Sys.timezone}}
}

