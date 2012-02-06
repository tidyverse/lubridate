\name{\%within\%}
\alias{"\%within\%"}
\alias{\%within\%}
\alias{\%within\%-methods}
\title{Tests whether a date or interval falls within an interval}
\usage{
  %within%()
}
\arguments{
  \item{a}{An interval or date-time object}

  \item{b}{An interval}
}
\value{
  A logical
}
\description{
  %within% returns TRUE is a falls within interval b, FALSE
  otherwise. If a is an interval, both its start and end
  dates must fall within b to return TRUE.
}

