#' Get date-time in a different time zone
#' 
#' with_tz returns a date-time as it would appear in a different time zone.  
#' The actual moment of time measured does not change, just the time zone it is 
#' measured in. with_tz defaults to the Universal Coordinated time zone (UTC) 
#' when an unrecognized time zone is inputted. See \code{\link{Sys.timezone}} 
#' for more information on how R recognizes time zones.
#'
#' @export with_tz
#' @param time a POSIXct, POSIXlt, Date, or chron date-time object.
#' @param tzone a character string containing the time zone to convert to. R 
#' must recognize the name 
#'   contained in the string as a time zone on your system.
#' @return a POSIXct object in the updated time zone
#' @keywords chron manip
#' @seealso \code{\link{force_tz}}
#' @examples
#' x <- as.POSIXct("2009-08-07 00:00:01", tz = "America/New_York")
#' with_tz(x, "GMT")
#' # "2009-08-07 04:00:01 GMT"
with_tz <- function (time, tzone = ""){
  check_tz(tzone)
  if (is.POSIXlt(time)) new <- as.POSIXct(time)
  else new <- time
  attr(new, "tzone") <- tzone
  reclass_date(new, time)
}

#' Replace time zone to create new date-time
#' 
#' force_tz returns a the date-time that has the same clock time as x in the new
#'  time zone.  
#' Although the new date-time has the same clock time (e.g. the 
#' same values in the year, month, days, etc. elements) it is a 
#' different moment of time than the input date-time. force_tz defaults to the 
#' Universal Coordinated time zone (UTC) when an unrecognized time zone is 
#' inputted. See \code{\link{Sys.timezone}} for more information on how R 
#' recognizes time zones.
#'
#' @export force_tz
#'
#' @param time a POSIXct, POSIXlt, Date, or chron date-time object.
#' @param tzone a character string containing the time zone to convert to. R 
#' must recognize the name 
#' contained in the string as a time zone on your system.
#' @return a POSIXct object in the updated time zone
#' @keywords chron manip
#' @seealso \code{\link{with_tz}}
#' @examples
#' x <- as.POSIXct("2009-08-07 00:00:01", tz = "America/New_York")
#' force_tz(x, "GMT")
#' # "2009-08-07 00:00:01 GMT"
force_tz <- function(time, tzone = ""){  
  check_tz(tzone)
  update(time, tz = tzone)
}

check_tz <- function(tz) {}

# Note: alternative method? as.POSIXlt(format(as.POSIXct(x)), tz = tzone)

#' Names of available time zones
#' 
#' The names of all available Olson-style time zones.
#' 
#' @param order_by Return names alphabetically (the default) 
#' or from West to East.
#' @note Olson-style names are the most readable and portable 
#' way of specifying time zones.  This function gets names
#' from the file shipped with R, stored in the file `zone.tab`.
#' \code{?\link[base]{Sys.timezone}} has more information.
#' @return A character vector of time zone names.
#' @seealso \code{\link[base]{Sys.timezone}}
#' @examples
#' \dontrun{
#' olson_time_zones()
#' olson_time_zones("longitude")
#' }
#' @export
olson_time_zones <- function(order_by = c("name", "longitude")) {
  order_by <- match.arg(order_by)

  # compile possible locations for zoneinfo/zone.tab
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
