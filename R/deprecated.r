##' Deprecated function in \code{lubridate} package
##' @param x numeric value to be converted into duration
##' @param ... arguments to be passed to the functions
##'     (obscured to enforce the usage of new functions)
##' @rdname Deprecated
##' @name Deprecated-lubridate
NULL

## modified ggplot2:::gg_dep
.deprecated_fun <- function(replacement, version, n_call = 1) {
  name <- as.character(sys.call(-(n_call))[[1]])
  name <- sprintf("'%s'", name)
  replacement <- sprintf("; use '%s' instead", replacement)
  .deprecated(name, replacement, version)
}

.deprecated_arg <- function(arg, version, n_call = 1){
  name <- as.character(sys.call(-n_call)[[1]])
  mes <- sprintf("Argument '%s' of '%s'", arg, name)
  .deprecated(mes, "", version)
}

.deprecated <- function(name, replacement = NULL, version){

  v <- as.package_version(version)
  cv <- packageVersion("lubridate")

  replacement <- if(is.null(replacement)) "" else replacement

  ## If current major number is greater than last-good major number, or if
  ##  current minor number is more than 1 greater than last-good minor number,
  ##  give error.
  if (cv[[1,1]] > v[[1,1]]  ||  cv[[1,2]] > v[[1,2]] + 1) {
    stop(sprintf("%s is defunct%s. Deprecated in version '%s'.",
                 name, replacement, version),
         call. = FALSE)
  } else if (cv[[1,2]] > v[[1,2]]) {
    ## If minor number differs by one, give warning
    warning(sprintf("%s is deprecated%s. Deprecated in version '%s'.",
                    name, replacement, version),
            call. = FALSE)
  } else if (cv[[1,3]] >=  v[[1,3]]) {
    ## If only subminor number is greater, give message
    message(sprintf("%s is deprecated%s. Deprecated in version '%s'.",
                    name, replacement, version))
  }
  invisible()

}

##' @rdname Deprecated
##' @export
new_period <- function(...) {
  .deprecated_fun("period", "1.5.0")
  period(...)
}

##' @rdname Deprecated
##' @export
new_interval <- function(...) {
  .deprecated_fun("interval", "1.5.0")
  interval(...)
}

##' @rdname Deprecated
##' @export
new_duration <- function(...) {
  .deprecated_fun("duration", "1.5.0")
  duration(...)
}

##' @rdname Deprecated
##' @export
new_difftime <- function(...) {
  .deprecated_fun("make_difftime", "1.5.0")
  make_difftime(...)
}

#' @export
#' @rdname Deprecated
eseconds <- function(x = 1){
  .deprecated_fun("dseconds", "1.5.0")
  new("Duration", x)
}

#' @export
#' @rdname Deprecated
eminutes <- function(x = 1){
  .deprecated_fun("dminutes", "1.5.0")
  new("Duration", x * 60)
}

#' @export
#' @rdname Deprecated
ehours <- function(x = 1){
  .deprecated_fun("dhours", "1.5.0")
  new("Duration", x * 3600)
}

#' @export
#' @rdname Deprecated
edays <- function(x = 1){
  .deprecated_fun("ddays", "1.5.0")
  new("Duration", x * 86400)
}

#' @export
#' @rdname Deprecated
eweeks <- function(x = 1){
  .deprecated_fun("dweeks", "1.5.0")
  new("Duration", x * 604800)
}

#' @export
#' @rdname Deprecated
eyears <- function(x = 1){
  .deprecated_fun("dyears", "1.5.0")
  new("Duration", x * 60 * 60 * 24 * 365)
}

#' @export
#' @rdname Deprecated
emilliseconds <- function(x = 1){
  .deprecated_fun("dmilliseconds", "1.5.0")
  new("Duration", x / 1000)
}

#' @export
#' @rdname Deprecated
emicroseconds <- function(x = 1){
  .deprecated_fun("dmicroseconds", "1.5.0")
  new("Duration", x / 1000 / 1000)
}

#' @export
#' @rdname Deprecated
enanoseconds <- function(x = 1){
  .deprecated_fun("dnanoseconds", "1.5.0")
  new("Duration", x / 1000 / 1000 / 1000)
}

#' @export
#' @rdname Deprecated
epicoseconds <- function(x = 1){
  .deprecated_fun("dpicoseconds", "1.5.0")
  new("Duration", x / 1000 / 1000 / 1000 / 1000)
}

#' @export
#' @rdname Deprecated
here <- function(){
  .deprecated_fun("now", "1.5.6")
  now()
}

#' @export
#' @param order_by Return names alphabetically (the default) or from West to
#'   East.
#' @rdname Deprecated
olson_time_zones <- function(order_by = c("name", "longitude")) {
  .deprecated_fun("OlsonNames", "1.5.6")
  order_by <- match.arg(order_by)

  ## compile possible locations for zoneinfo/zone.tab
  tzdirs <- c(
    R.home("share"), # Windows
    ## taken from OlsonNames in R3.0.3
    "/usr/share", "/usr/share/lib","/usr/lib/zoneinfo",
    "/usr/local/etc", "/etc", "/usr/etc")

  tzfiles <- c(file.path(tzdirs, "zoneinfo", "zone.tab"),
               ## special treatment of Soloaris > 9 (versions < 8 seem not to
               ## have it at all)
               "/usr/share/lib/zoneinfo/tab/zone_sun.tab")
  tzfiles <- tzfiles[file.exists(tzfiles)]

  if ( length(tzfiles) == 0 ){
    warning("zone.tab file not found in any candidate locations: ",
            str_join(tzdirs, collapse=" "))
  }

  tzfile <- tzfiles[[1]]

  tzones <- read.delim(
    tzfile,
    row.names    = NULL,
    header       = FALSE,
    col.names    = c("country", "coords", "name", "comments"),
    as.is        = TRUE,
    fill         = TRUE,
    comment.char = "#"
  )
  o <- order(switch(
    order_by,
    name      = tzones$name,
    longitude =
      {
        longitude_string <- stringr::str_match(
                                       tzones$coords,
                                       "[+-][[:digit:]]+([+-][[:digit:]]+)"
                                     )[, 2]
        nch <- nchar(longitude_string)
        sign <- ifelse(
          substring(longitude_string, 1, 1) == "+",
          1,
          -1
        )

        nss <- function(first, last)
        {
          as.numeric(substring(longitude_string, first, last))
        }

        sign * ifelse(
                 nch == 5,
                 3600 * nss(2, 3) + 60 * nss(4, 5),
               ifelse(
                 nch == 6,
                 3600 * nss(2, 4) + 60 * nss(6, 6),
               ifelse(
                 nch == 7,
                 3600 * nss(2, 3) + 60 * nss(4, 5) + nss(6, 7),
                 3600 * nss(2, 4) + 60 * nss(6, 6) + nss(7, 8)
               )
               )
               )
      }
  ))
  tzones$name[o]
}
