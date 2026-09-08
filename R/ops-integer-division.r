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
setMethod("%/%", signature(e1 = "Duration", e2 = "Interval"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "%/%")
})

#' @export
setMethod("%/%", signature("Interval", "Period"), trunc_divide)
#' @export
setMethod("%/%", signature(e1 = "Period", e2 = "Interval"), function(e1, e2) {
  stop_incompatible_classes(e1, e2, "%/%")
})
