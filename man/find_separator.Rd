\name{find_separator}
\alias{find_separator}
\title{Identifies the likely separators of a string.}
\usage{find_separator(x)}

\description{
  Identifies the likely separators of a string.
}

\details{
  Letters and numbers are assumed not to be separators
}
\value{a list of possible separators}
\keyword{chron}
\arguments{
  \item{x}{a character string}
}
\examples{find_separator("2009-08-03 09:07:03")}
