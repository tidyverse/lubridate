\name{seconds_to_period}
\alias{seconds_to_period}
\title{Contrive a period from a given number of seconds}
\usage{
  seconds_to_period(x)
}
\arguments{
  \item{x}{A numeric object. The number of seconds to
  coerce into a period.}
}
\value{
  A period that roughly equates to the number of seconds
  given.
}
\description{
  seconds_to_period uses estimates of time elements (in
  seconds) to create the period that has the maximum number
  of large elements(years > months > days > hours > minutes
  > seconds) and roughly equates to a given number of
  seconds. Note that the actual number of seconds in a
  period depends on when the period occurs. Since there is
  no one-to-one relationship between the periods that
  seconds_to_period makes and the number of seconds given
  as input, these periods should be treated as rough
  estimates only.
}

