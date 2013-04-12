\name{format_offset}
\alias{format_offset}
\title{format_offset}
\usage{
  format_offset(x, fmt = "\%Oz")
}
\arguments{
  \item{x}{POSIXct for which offset-string is sought}

  \item{fmt}{string describing format of offset, default:
  \code{%Oz}}
}
\value{
  string
}
\description{
  function to format the offset of a time from UTC
}
\details{
  This is an internal function, used in conjunction with
  \code{\link{stamp}}. There are three available formats:

  \itemize{ \item \code{%Oo} +01 \item \code{%Oz} +0100
  \item \code{%OO} +01:00 }

  If the \code{%Oo} format is used for a half-hour
  timezone, a warning is issued, and the format is changed
  to \code{%Oz}
}

