#' Convert every date method we know about to POSIXlt and POSIXct
#' @name DateCoercion
#' @keywords internal 
#' @aliases as.POSIXlt.fts as.POSIXlt.its as.POSIXlt.timeSeries as.POSIXlt.irts as.POSIXlt.xts as.POSIXlt.zoo as.POSIXlt.tis as.POSIXct.fts as.POSIXct.its as.POSIXct.timeSeries as.POSIXct.irts as.POSIXct.xts as.POSIXct.zoo as.POSIXct.tis
as.POSIXlt.fts <- function(x, tz = "", ...) as.POSIXlt(fts::dates.fts(x))
as.POSIXct.fts <- function(x, tz = "", ...) as.POSIXct(fts::dates.fts(x))

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
#' @aliases reclass_date reclass_date.POSIXlt reclass_date.POSIXct reclass_date.chron reclass_date.timeDate reclass_date.its reclass_date.ti reclass_date.Date
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
