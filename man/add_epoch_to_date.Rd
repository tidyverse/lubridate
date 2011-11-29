\name{add_epoch_to_date}
\alias{add_epoch_to_date}
\title{Add epochs to dates}
\usage{
  add_epoch_to_date(date, epoch)
}
\arguments{
  \item{date}{a date-time object to be used as the
  reference time from which future epochs will be counted}

  \item{epoch}{an epoch object that decribes the number and
  type of epochs to be used to define a new date-time}
}
\value{
  the date-time that occurs that specified number of epochs
  after the original date-time
}
\description{
  Method for adding epochs to dates. Epochs will be
  implemented in a later version of lubridate.
}

