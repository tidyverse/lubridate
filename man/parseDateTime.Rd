\name{parseDateTime}
\alias{parseDateTime}
\title{Low level function to parse character and numeric vectors into POSIXct
object.}
\usage{
  parseDateTime(x, formats, tz = "UTC",
    sep_regexp = "[^[:alnum:]]+", nr_best = Inf,
    try_collapsed = TRUE, try_separated = TRUE,
    missing = 0L, quiet = FALSE,
    train = if (length(x) > 100) x[1:100 * (length(x)\%/\%100)] else x)
}
\arguments{
  \item{x}{a character or numeric vector of suspected
  dates}

  \item{formats}{a character vector of date-time formats.
  Each format is series of formatting elements as listed
  \code{\link[base]{strptime}}. Formats might include
  spaces but should not include separators unless
  \code{sep_regexp} is NULL. See examples.}

  \item{tz}{a character string that specifies the time zone
  with which to parse the dates}

  \item{sep_regexp}{a character.  A regular expression
  matching separators (defaults to all non-alphanumeric
  characters). Can also be NULL.  In this case,
  \code{formats} are taken literally and \code{x} is parsed
  as is. That is, try_collapsed and try_separated are
  ignored and no substitution of \code{x} is maid
  strategies.}

  \item{nr_best}{number of "best" formats to try. Defaults
  to \code{Inf}, that is all formats are tried recursively
  and training is only used to order formats according to
  how well they have performed on the training set.}

  \item{try_collapsed}{logical. TRUE if collapsed (no
  separator) formats should be tried.}

  \item{try_separated}{logical. TRUE if separated formats
  should be tried.}

  \item{missing}{integer, number of formats that can be
  missing. The most common type of irregularity in
  date-time data is the truncation due to rounding or
  unavailability of the time stamp. If \code{missing}
  parameter is non-zero \code{parseDateTime} also checks
  for truncated formats. For example, if the format is
  "%y%m%d%h%m%s" and \code{missing = 3},
  \code{parseDateTime} will correctly parse incomplete
  dates like \code{2012-06-01 12:23}, \code{2012-06-01 12}
  and \code{2012-06-01}. \bold{NOTE:} \code{ymd} family of
  functions are based on \code{strptime} which currently
  fails to parse \code{\%y-\%m} formats.}

  \item{quiet}{logical. When TRUE function evalueates
  without displaying customary messages.}

  \item{train}{a vector to use for format training.
  Defaults to the equally spaced 100 elements of \code{x}.
  If NULL, no training is performed.}
}
\value{
  a vector of POSIXct date-time objects
}
\description{
  Specifically designed to handle heterogeneous date-time
  formats at once. It first sorts the supplied formats
  based on a training set and then applies them recursively
  for parsing of the input vector.
}
\details{
  As oposed to \code{strptime} and \code{as.POSIXct},
  \code{parseDateTime} doesn't ignore remaining unparsed
  part of the string.  For example, the format "\%y\%m\%d
  \%H\%M" doesn't match "2010-01-01 00:00:00", and the
  format "\%y\%m\%d \%H\%M\%S" doesn't match "2010-01-01
  00:00:00 UTC".

  If \code{sep_regexp} is non-NULL, it should be a regular
  expression to match separators between numeric elements
  in \code{x}. In this case \code{formats} should not
  contain separators (like in "%y%m%d"). See
  \code{lubridate_formats} for formats used in \code{ymd}
  and \code{ymd_hms} families of functions.

  There are two strategies that can be applied for the
  training and parsing. First strategy (when
  \code{try_separated = TRUE}) is to replace the separators
  with "-" and then parse with \code{strptime}. Second
  strategy (requested with \code{try_collapsed = TRUE}), it
  to completely remove separators and then parse with
  \code{strptime}.

  \bold{Parsing steps:}

  \enumerate{

  \item For each requested strategy, sort the available
  formats according to their performance on the training
  set in \code{train}.

  \item If both \code{try_separated} and
  \code{try_collapsed} are TRUE. Take the best strategy and
  store the alternative strategy for the potential latter
  use.

  \item Parse \code{x} with first \code{nr_best} formats
  recursively with the best strategy. That is, parse
  \code{x} with the best format, then parse with the second
  best format all the unparsed in the previous stage
  elements. Continue until all elements in \code{x} are
  parsed or all formats are exhausted.

  \item If there are still unparsed elements in \code{x},
  try to parse them with the alternative strategy, if any,
  using the same formats.

  }

  \bold{Speed considerations:}

  In most of the cases \code{parseDateTime} is very fast
  (as fast as \code{as.POSIXct}) on vectors longer than
  10000 elements. (todo: check this number)

  For short vectors it might not be very efficient because
  of the training of formats involved. It's never a problem
  in interactive use but could have a sizable effect if you
  run \code{for} or \code{lapply} loops on big data and
  small blocks. You can deactivate training by setting
  \code{train} to \code{NULL}. In this case it is a good
  idea to order the \code{formats} in decreasing order of
  how often they occur in \code{x}.

  For efficiency reasons, in \code{ymd} and \code{ymd_hms}
  family of functions, training is always skipped when
  length of \code{x} is less than 300.

  For long input vector \code{x}, If you know all the
  available formats in \code{x}, it might be a good idea to
  set \code{sep_regexp} to NULL and supply all the formats
  explicitly (i.e. including separators). This will save up
  to 20-30% in speed as it avoids \code{gsub}-ing of
  \code{x}. This way, you will achieve the efficiency of
  the bare call to \code{strptime}.
}
\examples{
x <- c("09-01-01", "09-01-02", "09-01-03")
parseDateTime(x, "\%y\%m\%d")
parseDateTime(x, "\%y \%m \%d")
#  "2009-01-01 UTC" "2009-01-02 UTC" "2009-01-03 UTC"

## ** heterogenuous formats **
x <- c("09-01-01", "090102", "09-01 03", "09-01-03 12:02")
parseDateTime(x, c("\%y\%m\%d", "\%y\%m\%d \%H\%M"))
## Avoid training for small vectors (all the formats are just tried in turn):
parseDateTime(x, c("\%y\%m\%d", "\%y\%m\%d \%H\%M"), train = NULL)

## different ymd orders:
x <- c("2009-01-01", "02022010", "02-02-2010")
parseDateTime(x, c("\%d\%m\%Y", "\%Y\%m\%d"), train = NULL)
##  "2009-01-01 UTC" "2010-02-02 UTC" "2010-02-02 UTC"

## ** truncated time-dates **
x <- c("2011-12-31 12:59:59", "2010-01-01 12:11", "2010-01-01 12", "2010-01-01")
parseDateTime(x, "\%Y\%m\%d \%H\%M\%S", missing = 3)
## "2011-12-31 12:59:59 UTC" "2010-01-01 12:11:00 UTC" "2010-01-01 12:00:00 UTC" "2010-01-01 00:00:00 UTC"

## ** custom formats **
x <- c("July 8th, 2004, 10:30")
strptime(x, "\%b \%dth, \%Y, \%H:\%M")
parseDateTime(x, "\%b \%dth, \%Y, \%H:\%M", sep_regexp=NULL)
## or just
parseDateTime(x, "\%b\%dth\%Y \%H\%M")

x <- c("Thu, 1 July 2004 22:30:00", "July 8th, 2004, 10:30")
parseDateTime(x, c("\%a\%d\%b\%Y \%H\%M\%\%S", "\%b \%dth \%Y \%H\%M"))
}
\seealso{
  \code{\link{ymd}}, \code{\link{ymd_hms}}
}
\keyword{chron}

