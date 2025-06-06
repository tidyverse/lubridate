% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_ISO8601.r
\name{format_ISO8601}
\alias{format_ISO8601}
\alias{format_ISO8601,Date-method}
\alias{format_ISO8601,POSIXt-method}
\alias{format_ISO8601,Interval-method}
\alias{format_ISO8601,Duration-method}
\alias{format_ISO8601,Period-method}
\title{Format in ISO8601 character format}
\usage{
format_ISO8601(x, usetz = FALSE, precision = NULL, ...)
}
\arguments{
\item{x}{An object to convert to ISO8601 character format.}

\item{usetz}{Include the time zone in the formatting.  If
\code{usetz} is \code{TRUE}, the time zone is included. If
\code{usetz} is \code{"Z"}, the time is converted to "UTC" and
the time zone is indicated with "Z" ISO8601 notation.}

\item{precision}{The amount of precision to represent with
substrings of "ymdhms", as year, month, day, hour,
minute, and second. (e.g. "ymd" is days precision, "ymdhm" is minute precision.
When \code{NULL}, full precision for the object
is shown.}

\item{...}{Additional arguments to methods.}
}
\value{
A character vector of ISO8601-formatted text.
}
\description{
Format in ISO8601 character format
}
\examples{
format_ISO8601(as.Date("02-01-2018", format = "\%m-\%d-\%Y"))
format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz = "America/New_York"), usetz = TRUE)
format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz = "America/New_York"), precision = "ymdhm")
}
\references{
\url{https://en.wikipedia.org/wiki/ISO_8601}
}
