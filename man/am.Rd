\name{am}
\alias{am}
\alias{pm}
\title{Does date time occur in the am or pm?}
\usage{
  am(x)
}
\arguments{
  \item{x}{a date-time object}
}
\value{
  TRUE or FALSE depending on whethe x occurs in the am or
  pm
}
\description{
  Does date time occur in the am or pm?
}
\examples{
x <- ymd("2012-03-26")
am(x)
pm(x)
}
\keyword{chron}

