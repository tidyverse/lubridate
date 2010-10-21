\name{am}
\alias{am}
\title{Does date time occur in the am or pm?}
\usage{am(x)}

\description{
  Does date time occur in the am or pm?
}
\value{TRUE or FALSE depending on whethe x occurs in the am or pm}
\keyword{chron}
\arguments{
  \item{x}{a date-time object}
}
\examples{x <- now()
am(x) 
pm(x)}
