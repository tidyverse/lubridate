\name{standardise_difftime_names}
\alias{standardise_difftime_names}
\title{Internal function.}
\usage{standardise_difftime_names(x)}

\description{
  Internal function. Matches input with recognized difftime unit names
  (i.e.  "secs", "mins", "hours", "days", and "weeks").
}
\keyword{internal}
\examples{standardise_difftime_names(c("seconds", "minute"))
# "secs" "mins"}
