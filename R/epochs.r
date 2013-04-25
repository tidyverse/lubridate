# for case study 2
# Easter depends on full moons, so will do thanksgiving instead
# very hard to do with current version of lubridate, so propose 
#  code below

# To find thanksgiving:
# date <- ymd("2010-01-01")
# date + months(10) + thursdays(4)

# thursdays() is new class: epoch.
# epochs are time points of interest
# we can find the next occurence of the epoch, or 
#  the nth next occurence of the epoch

# could also use to make a businessdays(6) sort of function

# would have to write subtract_epoch_from_date method, and 
#  incorporate both into ops.durations.r


#' Quickly create common epoch objects
#'
#' Creates an epoch object that uses the functions name as the reference epoch event. Implementation for epochs will be implemented in future versions of lubridate.
#' 
#' @aliases sundays mondays tuesdays wednesdays thursdays fridays saturdays
#' @param x number of epochs to be included
sundays <- function(x = 1) 
  new_epoch(weekday = "sunday", number = x)
mondays <- function(x = 1) 
  new_epoch(weekday = "monday", number = x)
tuesdays <- function(x = 1) 
  new_epoch(weekday = "tuesday", number = x)
wednesdays <- function(x = 1) 
  new_epoch(weekday = "wednesday", number = x)
thursdays <- function(x = 1) 
  new_epoch(weekday = "thursday", number = x)
fridays <- function(x = 1) 
  new_epoch(weekday = "friday", number = x)
saturdays <- function(x = 1) 
  new_epoch(weekday = "saturday", number = x)

#' Create an epoch object
#'
#' new_epoch creates an epoch object with the specified values. Implementation for epochs will be implemented in future versions of lubridate.
#' 
#' @param weekday name of weekday to use as epoch
#' @param number number of epochs to include
#' @return an epoch object
#' @seealso \code{\link{saturdays}}
new_epoch <- function(weekday, number){
  epoch <- list(weekday = weekday, number = number)
  structure(epoch, class = c("epoch", "list"))
}
  
#' Add epochs to dates
#' 
#' Method for adding epochs to dates. Epochs will be implemented in a later version of lubridate.  
#' 
#' @param date a date-time object to be used as the reference time from which future epochs will be counted
#' @param epoch an epoch object that decribes the number and type of epochs to be used to define a new date-time
#' @return the date-time that occurs that specified number of epochs after the original date-time
add_epoch_to_date <- function(date, epoch){
  weekday <- switch(epoch$weekday, sunday = 1, monday = 2, 
    tuesday = 3, wednesday = 4, thursday = 5, friday = 6, 
    saturday = 7)
    
  start_day <- wday(date)
  
  over <- which(start_day > weekday)
  under <- which(start_day <= weekday)
  
  date[over] <- (date + days(7 + weekday - 
    start_day) + weeks(epoch$number - 1))[over]
  
  date[under] <- (date + days(weekday - 
    start_day) + weeks(epoch$number - 1))[under]
    
  date
}
