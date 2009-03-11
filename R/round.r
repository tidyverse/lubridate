# Rounding for dates
# ---------------------------------------------------------------------------

floor_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year"), eps=1e-10) {
  unit <- match.arg(unit)
  if (unit != "second") second(x) <- second(x) - eps 

  switch(unit,
    second = {second(x) <- floor(second(x));},
    minute = {second(x) <- 0;},
    hour =   {minute(x) <- 0; second(x) <- 0;},
    day =    {hour(x) <- 0; minute(x) <- 0; second(x) <- 0},
    week =   {wday(x) <- 1; hour(x) <- 0; minute(x) <- 0; second(x) <- 0},
    month =  {mday(x) <- 1; hour(x) <- 0; minute(x) <- 0; second(x) <- 0},
    year =   {yday(x) <- 1; hour(x) <- 0; minute(x) <- 0; second(x) <- 0}
  )
  x
}

ceiling_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year"), eps=1e-10) {
  unit <- match.arg(unit)
  if (unit != "second") second(x) <- second(x) + eps 
  
  switch(unit,
    second = second(x) <- ceiling(second(x)),
    minute = minute(x) <- minute(x) + 1,
    hour =   hour(x) <- hour(x) + 1,
    day =    yday(x) <- yday(x) + 1,
    week =   week(x) <- week(x) + 1,
    month =  month(x) <- month(x) + 1,
    year =   year(x) <- year(x) + 1
  )
  floor_date(x, unit, eps=0)
}

round_date <- function(x, unit = c("second","minute","hour","day", "week", "month", "year")) {
  below <- floor_date(x, unit)
  above <- ceiling_date(x, unit)
  
  structure(ifelse(difftime(x, below, "secs") < difftime(above, x, "secs"), below, above), class="POSIXct")
}

