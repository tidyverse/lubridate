#' @include timespans.r
#' @include durations.r
#' @include intervals.r
#' @include periods.r
#' @include Dates.r
#' @include difftimes.r
#' @include numeric.r
#' @include POSIXt.r
#' @include ops-addition.r
NULL

#' Add and subtract months to a date without exceeding the last day of the new month
#'
#' Adding months frustrates basic arithmetic because consecutive months have different lengths.
#' With other elements, it is helpful for arithmetic to perform automatic roll over. For 
#' example, 12:00:00 + 61 seconds becomes 12:01:01. However, people often prefer that this behavior 
#' NOT occur with months. For example, we sometimes want January 31 + 1 month = February 28 and not 
#' March 3. %m+% performs this type of arithmetic. Date %m+% months(n) always returns a date in the 
#' nth month after Date. If the new date would usually spill over into the n + 1th month, %m+% will 
#' return the last day of the nth month. Date %m-% months(n) always returns a date in the 
#' nth month before Date.
#'  
#' %m+% and %m-% do not handle periods less than a month. These must be added separately with traditional 
#' arithmetic. %m+% and %m-% should be used with caution as they are not a one-to-one operations and 
#' results for either will be sensitive to the order of operations. 
#'   
#'
#' @export 
#' @rdname mplus
#' @usage e1 \%m+\% e2
#' @aliases m+ %m+% m- %m-%
#' @aliases %m+%,Period,ANY-method
#' @aliases %m+%,ANY,Period-method
#' @aliases %m-%,Period,ANY-method
#' @aliases %m-%,ANY,Period-method
#' @aliases %m+%,Duration,ANY-method
#' @aliases %m+%,ANY,Duration-method
#' @aliases %m-%,Duration,ANY-method
#' @aliases %m-%,ANY,Duration-method
#' @aliases %m+%,Interval,ANY-method
#' @aliases %m+%,ANY,Interval-method
#' @aliases %m-%,Interval,ANY-method
#' @aliases %m-%,ANY,Interval-method
#' @param e1 A period or a date-time object of class \code{\link{POSIXlt}}, \code{\link{POSIXct}} 
#' or \code{\link{Date}}.
#' @param e2 A period or a date-time object of class \code{\link{POSIXlt}}, \code{\link{POSIXct}} 
#' or \code{\link{Date}}. Note that one of e1 and e2 must be a period and the other a 
#' date-time object.
#' @return A date-time object of class POSIXlt, POSIXct or Date
#' @examples
#' jan <- ymd_hms("2010-01-31 03:04:05")
#' # "2010-01-31 03:04:05 UTC"
#' jan + months(1:3) # Feb 31 and April 31 prompt "rollover"
#' # "2010-03-03 03:04:05 UTC" "2010-03-31 03:04:05 UTC" "2010-05-01 03:04:05 UTC"
#' jan %m+% months(1:3) # No rollover
#' # "2010-02-28 03:04:05 UTC" "2010-03-31 03:04:05 UTC" "2010-04-30 03:04:05 UTC"
#'
#' leap <- ymd("2012-02-29")
#' "2012-02-29 UTC"
#' leap %m+% years(1)
#' # "2013-02-28 UTC"
#' leap %m+% years(-1)
#' leap %m-% years(1)
#' # "2011-02-28 UTC"
"%m+%" <- function(e1,e2) standardGeneric("%m+%")

#' @export
setGeneric("%m+%")

#' @export   
setMethod("%m+%", signature(e2 = "Period"), 
  function(e1, e2) .month_plus(e1, e2))

#' @export   
setMethod("%m+%", signature(e1 = "Period"), 
  function(e1, e2) .month_plus(e2, e1))

mplus_error <- function(e1, e2) 
  stop("%m+% only handles Period objects with month or year units")

#' @export   
setMethod("%m+%", signature(e2 = "Duration"), mplus_error)

#' @export   
setMethod("%m+%", signature(e1 = "Duration"), mplus_error)

#' @export   
setMethod("%m+%", signature(e2 = "Interval"), mplus_error)

#' @export   
setMethod("%m+%", signature(e1 = "Interval"), mplus_error)


#' @export
"%m-%" <- function(e1,e2) standardGeneric("%m-%")

#' @export
setGeneric("%m-%")

#' @export   
setMethod("%m-%", signature(e2 = "Period"), 
  function(e1, e2) .month_plus(e1, -e2))

#' @export   
setMethod("%m-%", signature(e1 = "Period"), 
  function(e1, e2) .month_plus(e2, -e1))

mminus_error <- function(e1, e2) 
  stop("%m-% only handles Period objects with month or year units")


#' @export   
setMethod("%m-%", signature(e2 = "Duration"), mminus_error)

#' @export   
setMethod("%m-%", signature(e1 = "Duration"), mminus_error)

#' @export   
setMethod("%m-%", signature(e2 = "Interval"), mminus_error)

#' @export   
setMethod("%m-%", signature(e1 = "Interval"), mminus_error)


.month_plus <- function(e1, e2) {
  if (any(c(e2@.Data, e2@minute, e2@hour, e2@day) != 0))
    stop("%m+% only handles month and years. Add other periods separately with '+'")
  
  if (any(e2@year != 0)) e2 <- months(12 * e2@year + e2@month)
  
  new <- .quick_month_add(e1, e2@month)
  roll <- day(new) < day(e1)
  new[roll] <- rollback(new[roll])
  new
}


.quick_month_add <- function(object, mval) {
  tzs <- tz(object)
  utc <- as.POSIXlt(force_tz(object, tzone = "UTC"))
  utc$mon <- utc$mon + mval
  utc <- as.POSIXct(utc)
  new <- force_tz(utc, tzone = tzs)
  reclass_date(new, object)
}

#' Roll back date to last day of previous month
#'
#' rollback changes a date to the last day of the previous month. The new date retains the same hour, 
#' minute, and second information.
#'   
#'
#' @export 
#' @param dates A POSIXct, POSIXlt or Date class object.
#' @return A date-time object of class POSIXlt, POSIXct or Date, whose day has been adjusted to the 
#' last day of the previous month.
#' date <- ymd("2010-03-03")
#' # "2010-03-03 UTC"
#' rollback(date)
#' # "2010-02-28 UTC"
#'
#' dates <- date + months(0:2)
#' "2010-03-03 UTC" "2010-04-03 UTC" "2010-05-03 UTC"
#' rollback(dates)
#' "2010-02-28 UTC" "2010-03-31 UTC" "2010-04-30 UTC"
rollback <- function(dates) {
  if (length(dates) == 0) 
    return(structure(vector(length = 0), class = class(dates)))
  day(dates) <- 1
  dates - days(1)
}
