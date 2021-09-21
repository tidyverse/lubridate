#' @include timespans.r
#' @include difftimes.r

check_duration <- function(object) {
  if (is.numeric(object@.Data))
    TRUE
  else
    "Duration value is not a number. Should be numeric."
}


#' Duration class
#'
#' Duration is an S4 class that extends the [Timespan-class] class.
#' Durations record the exact number of seconds in a time span. They measure the
#' exact passage of time but do not always align with measurements
#' made in larger units of time such as hours, months and years.
#' This is because the exact length of larger time units can be affected
#' by conventions such as leap years
#' and Daylight Savings Time.
#'
#' Durations provide a method for measuring generalized timespans when we wish to
#' treat time as a mathematical quantity that increases in a uniform, monotone manner
#' along a continuous numberline. They allow exact comparisons with other durations.
#' See [Period-class] for an alternative way to measure timespans that better
#' preserves clock times.
#'
#' Durations class objects have one slot: .Data, a numeric object equal to the number
#' of seconds in the duration.
#'
#' @aliases durations
#' @export
setClass("Duration", contains = c("Timespan", "numeric"), validity = check_duration)

#' @name hidden_aliases
#' @aliases Compare,Duration,ANY-method Compare,Duration,Duration-method
#'   Compare,difftime,Duration-method Compare,ANY,Duration-method
#'   Compare,Duration,Period-method Compare,Duration,difftime-method
#'   Compare,character,Duration-method Compare,Duration,character-method
#'   Compare,numeric,Duration-method Compare,Duration,numeric-method
#'   as.numeric,Duration-method show,Duration-method c,Duration-method
#'   rep,Duration-method [,Duration-method [<-,Duration,ANY,ANY,ANY-method
#'   [[,Duration-method [[<-,Duration,ANY,ANY,ANY-method $,Duration-method
#'   $<-,Duration-method as.difftime,Duration-method
#'   as.character,Duration-method +,Duration,Duration-method
#'   +,Duration,Interval-method +,Duration,Period-method +,Duration,Date-method
#'   +,Date,Duration-method +,Duration,difftime-method
#'   +,difftime,Duration-method +,Duration,numeric-method
#'   +,numeric,Duration-method +,Duration,POSIXct-method
#'   +,POSIXct,Duration-method +,Duration,POSIXlt-method
#'   +,POSIXlt,Duration-method -,Duration,ANY-method /,Duration,Duration-method
#'   /,Duration,Interval-method /,Duration,Period-method
#'   /,Duration,difftime-method /,difftime,Duration-method
#'   /,Duration,numeric-method /,numeric,Duration-method *,Duration,ANY-method
#'   *,ANY,Duration-method %%,Duration,Duration-method
#'   %%,Duration,Interval-method %%,Duration,Period-method
#'   -,Duration,missing-method -,ANY,Duration-method -,Duration,Duration-method
NULL

SECONDS_IN_ONE <- c(
  second = 1,
  minute = 60,
  hour   = 3600,
  day    = 86400,
  week   = 604800,
  year   = 31557600)

.readable_duration <- function(x, unit) {
  if (unit == "second")
    paste0(x, "s")
  else {
    x2 <- round(x / SECONDS_IN_ONE[[unit]], 2)
    sprintf("%ss (~%s %ss)", x, x2, unit)
  }
}

.next_unit <- structure(as.list(c(names(SECONDS_IN_ONE[-1]), list(NULL))),
                        names = names(SECONDS_IN_ONE))

compute_estimate <- function(secs, unit = "second") {
  next_unit <- .next_unit[[unit]]
  if (is.null(next_unit))
    return(.readable_duration(secs, "year"))
  out <- character(length(secs))
  tt <- abs(secs) < SECONDS_IN_ONE[[next_unit]]
  if (any(tt))
    out[tt] <- .readable_duration(secs[tt], unit)
  wnext <- which(!tt)
  if (length(wnext))
    out[wnext] <- compute_estimate(secs[wnext], next_unit)
  out
}

#' @export
setMethod("show", signature(object = "Duration"), function(object) {
  if (length(object@.Data) == 0) {
    cat("<Duration[0]>\n")
  } else {
    print(format(object), quote = TRUE)
  }
})

#' @export
format.Duration <- function(x, ...) {
  out <- character(length(x@.Data))
  nnas <- !is.na(x@.Data)
  out[nnas] <- compute_estimate(x@.Data[nnas])
  out[!nnas] <- NA_character_
  out
}

#' @export
setMethod("c", signature(x = "Duration"), function(x, ...) {
  durs <- c(x@.Data, unlist(list(...)))
  new("Duration", durs)
})

#' @export
setMethod("rep", signature(x = "Duration"), function(x, ...) {
  new("Duration", rep(as.numeric(x), ...))
})

#' @export
setMethod("[", signature(x = "Duration"),
  function(x, i, j, ..., drop = TRUE) {
    new("Duration", x@.Data[i])
})

#' @export
setMethod("[[", signature(x = "Duration"),
  function(x, i, j, ..., exact = TRUE) {
    new("Duration", x@.Data[i])
})

#' @export
setMethod("[<-", signature(x = "Duration"),
  function(x, i, j, ..., value) {
    x@.Data[i] <- value
    new("Duration", x@.Data)
})

#' @export
setMethod("[[<-", signature(x = "Duration"),
  function(x, i, j, ..., value) {
    x@.Data[i] <- as.numeric(value)
    new("Duration", x@.Data)
})


#' Create a duration object.
#'
#' `duration()` creates a duration object with the specified values. Entries
#' for different units are cumulative. durations display as the number of
#' seconds in a time span. When this number is large, durations also display an
#' estimate in larger units, however, the underlying object is always recorded
#' as a fixed number of seconds. For display and creation purposes, units are
#' converted to seconds using their most common lengths in seconds. Minutes = 60
#' seconds, hours = 3600 seconds, days = 86400 seconds, weeks = 604800. Units
#' larger than weeks are not used due to their variability.
#'
#' Durations record the exact number of seconds in a time span. They measure the
#' exact passage of time but do not always align with measurements
#' made in larger units of time such as hours, months and years.
#' This is because the length of larger time units can be affected
#' by conventions such as leap years
#' and Daylight Savings Time. Base R provides a second class for measuring
#' durations, the difftime class.
#'
#' Duration objects can be easily created with the helper functions [dweeks()],
#' [ddays()], [dminutes()], [dseconds()]. These objects can be added to and
#' subtracted to date- times to create a user interface similar to object
#' oriented programming.
#'
#' @param num the number or a character vector of time units. In string
#'   representation all unambiguous name units and abbreviations and ISO 8601
#'   formats are supported; 'm' stands for month and 'M' for minutes unless ISO
#'   8601 "P" modifier is present (see examples). Fractional units are
#'   supported.
#' @param units a character string that specifies the type of units that `num`
#'   refers to. When `num` is character, this argument is ignored.
#' @param ... a list of time units to be included in the duration and their
#'   amounts. Seconds, minutes, hours, days, weeks, months and years are
#'   supported. Durations of months and years assume that year consists of
#'   365.25 days.
#' @param x numeric value of the number of units to be contained in the
#'   duration.
#' @return a duration object
#' @seealso [as.duration()] [Duration-class]
#' @keywords chron classes
#' @examples
#'
#' ### Separate period and units vectors
#'
#' duration(90, "seconds")
#' duration(1.5, "minutes")
#' duration(-1, "days")
#'
#' ### Units as arguments
#'
#' duration(day = -1)
#' duration(second = 90)
#' duration(minute = 1.5)
#' duration(mins = 1.5)
#' duration(second = 3, minute = 1.5, hour = 2, day = 6, week = 1)
#' duration(hour = 1, minute = -60)
#'
#' ### Parsing
#'
#' duration("2M 1sec")
#' duration("2hours 2minutes 1second")
#' duration("2d 2H 2M 2S")
#' duration("2days 2hours 2mins 2secs")
#' # Missing numerals default to 1. Repeated units are added up.
#' duration("day day")
#'
#' ### ISO 8601 parsing
#'
#' duration("P3Y6M4DT12H30M5S")
#' duration("P23DT23H") # M stands for months
#' duration("10DT10M") # M stands for minutes
#' duration("P23DT60H 20min 100 sec") # mixing ISO and lubridate style parsing
#'
#' # Comparison with characters (from v1.6.0)
#'
#' duration("day 2 sec") > "day 1sec"
#'
#'
#' ## ELEMENTARY CONSTRUCTORS:
#'
#' dseconds(1)
#' dminutes(3.5)
#'
#' x <- ymd("2009-08-03", tz = "America/Chicago")
#' x + ddays(1) + dhours(6) + dminutes(30)
#' x + ddays(100) - dhours(8)
#'
#' class(as.Date("2009-08-09") + ddays(1)) # retains Date class
#' as.Date("2009-08-09") + dhours(12)
#' class(as.Date("2009-08-09") + dhours(12))
#' # converts to POSIXt class to accomodate time units
#'
#' dweeks(1) - ddays(7)
#' c(1:3) * dhours(1)
#'
#' # compare DST handling to durations
#' boundary <- ymd_hms("2009-03-08 01:59:59", tz = "America/Chicago")
#' boundary + days(1) # period
#' boundary + ddays(1) # duration
#' @export
duration <- function(num = NULL, units = "seconds", ...) {
  if (is.character(num)) {
    as.duration(parse_period(num))
  } else {
    out1 <- .duration_from_num(num, units)
    out2 <- .duration_from_pieces(list(...))
    if (is.null(out1) && is.null(out2)) new("Duration", numeric())
    else if (is.null(out1)) out2
    else if (is.null(out2)) out1
    else c(out1, out2)
  }
}

average_durations <- c(second = 1, minute = 60, hour = 3600, mday = 86400,
                       wday = 86400, yday = 86400, day = 86400, week = 604800,
                       month = 60 * 60 * 24 * 365.25 / 12, year = 60 * 60 * 24 * 365.25)

.duration_from_num <- function(num, units) {
  if (length(num) == 0)
    return(NULL)

  if (!is.numeric(num)) {
    stop(sprintf("First argument to `duration()` constructor must be character or numeric. Supplied object of class '%s'", class(num)))
  }

  ## qucik check for common wrongdoings: #462
  if (inherits(num, c("Interval", "Period")))
    stop("Interval or Period objects cannot be used as input to `duration()` constructor. Use `as.duration()` instead.", call. = FALSE)

  unit <- standardise_date_names(units)
  new("Duration", num * unname(average_durations[unit]))
}

.duration_from_pieces <- function(pieces) {
  if (length(pieces) == 0)
    return(NULL)
  names(pieces) <- standardise_date_names(names(pieces))
  out <- 0
  for (nm in names(pieces))
    out <- out + pieces[[nm]] * average_durations[[nm]]
  new("Duration", out)
}

#' @export dseconds dminutes dmonths dhours ddays dweeks dyears dmilliseconds dmicroseconds dnanoseconds dpicoseconds
#' @rdname duration
dseconds <- function(x = 1) new("Duration", x)
#' @rdname duration
dminutes <- function(x = 1) new("Duration", x * 60)
#' @rdname duration
dhours <- function(x = 1) new("Duration", x * 3600)
#' @rdname duration
ddays <- function(x = 1) new("Duration", x * 86400)
#' @rdname duration
dweeks <- function(x = 1) new("Duration", x * average_durations[["week"]])
#' @rdname duration
dmonths <- function(x = 1) new("Duration", x * average_durations[["month"]])
#' @rdname duration
dyears <- function(x = 1) new("Duration", x * average_durations[["year"]])
#' @rdname duration
dmilliseconds <- function(x = 1) new("Duration", x / 1000)
#' @rdname duration
dmicroseconds <- function(x = 1) new("Duration", x / 1000 / 1000)
#' @rdname duration
dnanoseconds <- function(x = 1) new("Duration", x / 1000 / 1000 / 1000)
#' @rdname duration
dpicoseconds <- function(x = 1) new("Duration", x / 1000 / 1000 / 1000 / 1000)

#' @rdname duration
#' @export
#' @examples
#' is.duration(as.Date("2009-08-03")) # FALSE
#' is.duration(duration(days = 12.4)) # TRUE
is.duration <- function(x) is(x, "Duration")

#' @export
summary.Duration <- function(object, ...) {
  nas <- is.na(object)
  object <- object[!nas]
  nums <- as.numeric(object)
  qq <- stats::quantile(nums)
  qq <- c(qq[1L:3L], mean(nums), qq[4L:5L])
  qq <- dseconds(qq)
  qq <- as.character(qq)
  names(qq) <- c("Min.", "1st Qu.", "Median", "Mean", "3rd Qu.",
                 "Max.")
  if (any(nas))
    c(qq, `NA's` = sum(nas))
  else qq
}

#' @export
setMethod("Compare", c(e1 = "Duration", e2 = "ANY"),
  function(e1, e2) stop_incompatible_classes(e1, e2, .Generic)
)

#' @export
setMethod("Compare", c(e1 = "ANY", e2 = "Duration"),
          function(e1, e2) {
            stop(sprintf("Incompatible duration classes (%s, %s). Please coerce with `as.duration()`.",
                         class(e1), class(e2)),
                 call. = FALSE)
          })

#' @export
setMethod("Compare", signature(e1 = "Duration", e2 = "numeric"),
          function(e1, e2) {
            callGeneric(e1@.Data, e2)
          })

#' @export
setMethod("Compare", signature(e1 = "numeric", e2 = "Duration"),
          function(e1, e2) {
            callGeneric(e1, e2@.Data)
          })

#' @export
setMethod("Compare", signature(e1 = "Duration", e2 = "character"),
          function(e1, e2) {
            callGeneric(e1, as.duration(e2))
          })

#' @export
setMethod("Compare", signature(e1 = "character", e2 = "Duration"),
          function(e1, e2) {
            callGeneric(as.duration(e1), e2)
          })

#' @export
setMethod("Compare", c(e1 = "difftime", e2 = "Duration"),
          function(e1, e2) {
            callGeneric(as.numeric(e1, "secs"), e2@.Data)
          })

#' @export
setMethod("Compare", c(e1 = "Duration", e2 = "difftime"),
          function(e1, e2) {
            callGeneric(e1@.Data, as.numeric(e2, "secs"))
          })

#' @export
setMethod("Compare", c(e1 = "Duration", e2 = "Duration"),
          function(e1, e2) {
            callGeneric(e1@.Data, e2@.Data)
          })
