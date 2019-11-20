#' @include timespans.r
NULL

trunc_divide <- function(e1, e2) {
  trunc(e1 / e2)
}

#' @export
setMethod("%/%", signature("Timespan", "Timespan"), trunc_divide)
#' @export
setMethod("%/%", signature("difftime", "Timespan"), trunc_divide)

#' @export
setMethod("%/%", signature("Interval", "Interval"), trunc_divide)
#' @export
setMethod("%/%", signature("Period", "Period"), trunc_divide)

#' @export
setMethod("%/%", signature("Interval", "Duration"), trunc_divide)
#' @export
setMethod("%/%", signature("Duration", "Interval"), trunc_divide)

#' @export
setMethod("%/%", signature("Interval", "Period"), trunc_divide)
#' @export
setMethod("%/%", signature("Period", "Interval"), trunc_divide)
