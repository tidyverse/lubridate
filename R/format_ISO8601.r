#' Format in ISO8601 character format
#'
#' @param x An object to convert to ISO8601 character format.
#' @inheritParams format_ISO8601_precision_check
#' @param ... Additional arguments to methods.
#' @return A character vector of ISO8601-formatted text.
#' @references \url{https://en.wikipedia.org/wiki/ISO_8601}
#' @examples
#' format_ISO8601(as.Date("02-01-2018", format = "%m-%d-%Y"))
#' format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz = "EST"), usetz = TRUE)
#' format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz = "EST"), precision = "ymdhm")
#' @aliases format_ISO8601,Date-method format_ISO8601,POSIXt-method format_ISO8601,Interval-method
#' format_ISO8601,Duration-method format_ISO8601,Period-method
#' @export
setGeneric(
  name = "format_ISO8601",
  def = function(x, usetz = FALSE, precision = NULL, ...) standardGeneric("format_ISO8601")
)

#' @export
setMethod("format_ISO8601",
  signature = "Date",
  function(x, usetz = FALSE, precision = NULL, ...) {
    precision_format <-
      format_ISO8601_precision_check(precision = precision, max_precision = "ymd", usetz = FALSE)
    format(x, format = precision_format, usetz = FALSE)
  }
)

#' @export
setMethod("format_ISO8601",
  signature = "POSIXt",
  function(x, usetz = FALSE, precision = NULL, ...) {
    precision_format <-
      format_ISO8601_precision_check(
        precision = precision, max_precision = "ymdhms", usetz = usetz)
    if (identical(usetz, "Z")) {
      x <- with_tz(x, tzone="UTC")
    }
    # usetz argument is FALSE because the time zone is handled in the precision argument.
    format(x, format = precision_format, usetz = FALSE)
  }
)

#' @export
setMethod("format_ISO8601",
  signature = "Interval",
  function(x, usetz = FALSE, precision = NULL, ...) {
    precision_format <-
      format_ISO8601_precision_check(
        precision = precision, max_precision = "ymdhms", usetz = usetz)
    x_start <- x@start
    x_end <- x@start + x@.Data
    if (identical(usetz, "Z")) {
      x_start <- with_tz(x_start, tzone="UTC")
      x_end <- with_tz(x_end, tzone="UTC")
    }
    # usetz argument is FALSE because the time zone is handled in the precision argument.
    sprintf(
      "%s/%s",
      format(x_start, format = precision_format, usetz = FALSE),
      format(x_end, format = precision_format, usetz = FALSE)
    )
  }
)

#' @export
setMethod("format_ISO8601",
  signature = "Duration",
  function(x, usetz = FALSE, precision = NULL, ...) {

    if (!is.null(precision)) {
      warning("precision is not used for Duration objects")
    }
    sprintf("PT%sS", format(x@.Data))
  }
)

#' @export
setMethod("format_ISO8601",
  signature = "Period",
  function(x, usetz = FALSE, precision = NULL, ...) {
    if (!is.null(precision)) {
      warning("precision is not used for Period objects")
    }
    date_part <-
      paste0(
        ifelse(x@year != 0,
          paste0(x@year, "Y"),
          ""
        ),
        ifelse(x@month != 0,
          paste0(x@month, "M"),
          ""
        ),
        ifelse(x@day != 0,
          paste0(x@day, "D"),
          ""
        )
      )
    time_part <-
      paste0(
        ifelse(x@hour != 0,
          paste0(x@hour, "H"),
          ""
        ),
        ifelse(x@minute != 0,
          paste0(x@minute, "M"),
          ""
        ),
        ifelse(x@.Data != 0,
          paste0(x@.Data, "S"),
          ""
        )
      )
    mask_neither <- (nchar(date_part) == 0) & (nchar(time_part) == 0)
    time_part[mask_neither] <- "0S"
    ifelse(nchar(time_part),
      paste0("P", date_part, "T", time_part),
      paste0("P", date_part)
    )
  }
)

ISO8601_precision_map <-
  list(
    y = "%Y",
    ym = "%Y-%m",
    ymd = "%Y-%m-%d",
    ymdh = "%Y-%m-%dT%H",
    ymdhm = "%Y-%m-%dT%H:%M",
    ymdhms = "%Y-%m-%dT%H:%M:%S"
  )

#' Provide a format for ISO8601 dates and times with the requested precision.
#'
#' @param usetz Include the time zone in the formatting.  If
#'   \code{usetz} is \code{TRUE}, the time zone is included. If
#'   \code{usetz} is \code{"Z"}, the time is converted to "UTC" and
#'   the time zone is indicated with "Z" ISO8601 notation.
#' @param precision The amount of precision to represent with
#'   substrings of "ymdhms", as "y"ear, "m"onth, "d"ay, "h"our,
#'   "m"inute, and "s"econd. (e.g. "ymdhm" would show precision
#'   through minutes.  When \code{NULL}, full precision for the object
#'   is shown.
#' @param max_precision The maximum precision allowed to be output.
#' @keywords internal
format_ISO8601_precision_check <- function(precision, max_precision, usetz = FALSE) {
  if (!(max_precision %in% names(ISO8601_precision_map))) {
    stop("Invalid value for max_precision provided: ", max_precision)
  }
  if (is.null(precision)) {
    precision <- max_precision
  }
  if (length(precision) != 1) {
    stop("precision must be a scalar")
  }
  if (nchar(precision) > nchar(max_precision)) {
    warning(
      "More precision requested (", precision, ") ",
      "than allowed (", max_precision, ") for this format.  ",
      "Using maximum allowed precision."
    )
    precision <- max_precision
  }
  if (is.null(ret <- ISO8601_precision_map[[precision]])) {
    stop("Invalid value for precision provided: ", precision)
  }
  if (identical(usetz, "Z")) {
    ret <- paste0(ret, "Z")
  } else if (usetz) {
    ret <- paste0(ret, "%z")
  }
  ret
}
