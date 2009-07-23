# Rounding for dates
# ---------------------------------------------------------------------------

# d <- strptime("2008-11-13 10:34:17", "%Y-%m-%d %H:%M:%S")
# 
floor_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year"), eps = 1e-10) {
  # matching user's input for "unit" to type of unit indicated
  unit <- match.arg(unit)
  
  # Note: Is this so a time less than 1e-10 below an integer is floored to 
  # the integer below it and not recognized as equal to the integer above it? 
  if (unit != "second") second(x) <- second(x) - eps 

  # selects appropriate task based on user's input for "unit"
  switch(unit,
    second = update.Date(x, second = floor(second(x))),
    minute = update.Date(x, second = 0),
    hour =   update.Date(x, minute = 0, second = 0),
    day =    update.Date(x, hour = 0, minute = 0, second = 0),
    week =   update.Date(x, wday = 1, hour = 0, minute = 0, second = 0),
    month =  update.Date(x, mday = 1, hour = 0, minute = 0, second = 0),
    year =   update.Date(x, yday = 1, hour = 0, minute = 0, second = 0)
  )
}


# In almost the same manner as above...
# d <- strptime("2008-01-01 00:00:00", "%Y-%m-%d %H:%M:%S")
ceiling_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year"), eps = 1e-10) {
  unit <- match.arg(unit)
  if (unit != "second") second(x) <- second(x) + eps 
  
  # we now add 1 to the desired unit and then floor it
  switch(unit,
    second = second(x) <- ceiling(second(x)),
    minute = minute(x) <- minute(x) + 1,
    hour =   hour(x) <- hour(x) + 1,
    day =    yday(x) <- yday(x) + 1,
    week =   week(x) <- week(x) + 1,
    month =  month(x) <- month(x) + 1,
    year =   year(x) <- year(x) + 1
  )
  
  # Note: Why is the eps now 0?
  floor_date(x, unit, eps=0)
}

# Rounds the date to whichever is closer: its floored value or ceiling value
round_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year")) {
  below <- floor_date(x, unit)
  above <- ceiling_date(x, unit)

  # Returns the closer of above and below and forces it to be 
  # a POSIXct object
  smaller <- difftime(x, below, "secs") < difftime(above, x, "secs")
  structure(ifelse(smaller, below, above), class= class(x))
}

# Parse date time unit specification
# Parse the time unit specification used by \code{\link{cut.Date}} into something useful
# 
# @keywords internal
parse_unit_spec <- function(unitspec) {
  parts <- strsplit(unitspec, " ")[[1]]
  if (length(parts) == 1) {
    mult <- 1
    unit <- unitspec
  } else {
    mult <- as.numeric(parts[[1]])
    unit <- parts[[2]]
  }
  
  # Match to 
  unit <- gsub("s$", "", unit)
  unit <- match.arg(unit, 
    c("second","minute","hour","day", "week", "month", "year"))
  
  list(unit = unit, mult = mult)
}
