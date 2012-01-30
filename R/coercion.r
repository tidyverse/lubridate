#' Convert every date method we know about to POSIXlt and POSIXct
#' @name DateCoercion
#' @keywords internal 
#'
#' @S3method as.POSIXlt fts
#' @S3method as.POSIXlt its
#' @S3method as.POSIXlt timeSeries
#' @S3method as.POSIXlt irts
#' @S3method as.POSIXlt xts
#' @S3method as.POSIXlt zoo
#' @S3method as.POSIXlt tis
#' @S3method as.POSIXct fts
#' @S3method as.POSIXct its
#' @S3method as.POSIXct timeSeries
#' @S3method as.POSIXct irts
#' @S3method as.POSIXct xts
#' @S3method as.POSIXct zoo
NULL

as.POSIXct.fts <- function(x, tz = "", ...) as.POSIXct(fts::dates.fts(x))
as.POSIXlt.fts <- function(x, tz = "", ...) as.POSIXlt(fts::dates.fts(x))

as.POSIXlt.its <- function(x, tz = "", ...) as.POSIXlt(attr(x, "dates"))
as.POSIXct.its <- function(x, tz = "", ...) as.POSIXct(attr(x, "dates"))

as.POSIXlt.timeSeries <- function(x, tz = "", ...) {
  as.POSIXlt(timeDate::timeDate(x@positions, 
    zone = x@FinCenter, FinCenter = x@FinCenter))
}
as.POSIXct.timeSeries <- function(x, tz = "", ...) {
  as.POSIXct(timeDate::timeDate(x@positions, 
    zone = x@FinCenter, FinCenter = x@FinCenter))
}

as.POSIXlt.irts <- function(x, tz = "", ...) as.POSIXlt(x$time)
as.POSIXct.irts <- function(x, tz = "", ...) as.POSIXct(x$time)

as.POSIXlt.xts <- function(x, tz = "", ...) as.POSIXlt(zoo::index(x))
as.POSIXct.xts <- function(x, tz = "", ...) as.POSIXct(zoo::index(x))
as.POSIXlt.zoo <- function(x, tz = "", ...) as.POSIXlt(zoo::index(x))
as.POSIXct.zoo <- function(x, tz = "", ...) as.POSIXct(zoo::index(x))

as.POSIXlt.tis <- function(x, tz = "", ...) as.Date(x)

#' Convenience method to reclass dates post-modification.
#' @keywords internal
#'
#' @export reclass_date
#' @S3method reclass_date POSIXlt
#' @S3method reclass_date POSIXct
#' @S3method reclass_date chron
#' @S3method reclass_date timeDate
#' @S3method reclass_date its
#' @S3method reclass_date ti
#' @S3method reclass_date Date
reclass_date <- function(new, orig) UseMethod("reclass_date", orig)
reclass_date.POSIXlt <- function(new, orig) {
  as.POSIXlt(new)
}
reclass_date.POSIXct <- function(new, orig) {
  as.POSIXct(new)
}
reclass_date.chron <- function(new, orig) {
  as.chron(new)
}
reclass_date.timeDate <- function(new, orig) {
  as.timeDate(new)
}
reclass_date.its <- function(new, orig) {
  its(x, dates, format = "%Y-%m-%d %X")
}
reclass_date.ti <- function(new, orig) {
  as.ti(new, tifName(orig))
}
reclass_date.Date <- function(new, orig) {
  as.Date(new)
}


period_to_difftime <- function(per){
	as.difftime(per)
}

reclass_timespan <- function(new, orig)
	UseMethod("reclass_timespan", orig)

reclass_timespan.difftime <- function(new, orig){
	if (is.period(new))
		as.difftime(new)
	else
		make_difftime(as.numeric(new))
}

setGeneric("reclass_timespan")

setMethod("reclass_timespan", signature(orig = "Duration"), function(new, orig){
	suppressMessages(as.duration(new))
})

setMethod("reclass_timespan", signature(orig = "Interval"), function(new, orig){
	suppressMessages(as.duration(new))
})
	
setMethod("reclass_timespan", signature(orig = "Period"), function(new, orig){
	suppressMessages(as.period(new))
})