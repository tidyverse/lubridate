#' Get the fiscal term of a date-time
#'
#' Quarters divide the year into fourths. Trimesters divide the year into thirds. Semesters divide the year into halfs.
#'
#' @param x a date-time object of class POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
#'   zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, fts or anything else that can
#'   be converted with as.POSIXlt
#' @param term the way you are dividing the year, be it semesters, trimestes, or quarters.
#' @param type the format to be returned for the quarter. Can be one one of "quarter" -
#'   return numeric quarter (default), "year.quarter" return the ending year and quarter
#'   as a number of the form year.quarter, "date_first" or "date_last" - return the date
#'   at the quarter's start or end, "year_start/end" - return a full description of the
#'   quarter as a string which includes the start and end of the year
#'   (ex. "2020/21 Q1").
#' @param fiscal_start numeric indicating the starting month of a fiscal year.

term <- function(x, term = "quarter", type = "quarter", fiscal_start = 1, holidays = NULL){
  if (length(fiscal_start) > 1) {
    stop("`fiscal_start` must be a singleton", call. = FALSE)
  }
  fs <- (fiscal_start - 1) %% 12
  shifted <- seq(fs, 11 + fs) %% 12 + 1
  m <- month(x)
  quarters <- rep(1:4, each = 3)
  s <- match(m, shifted)
  q <- quarters[s]
  
  num_divisions <- switch(type,
                          "quarter" = 4,
                          "trimester" = 3,
                          "semester" = 2,
                          stop("Unsupported type: ", type))
  
  divisions <- rep(1:num_divisions, each = 12 / num_divisions)
  current_division <- divisions[s]

  if (is.logical(type)) {
    type <- if (type) "year.quarter" else "quarter"
  }
  
  
  if (!is.null(holidays)) {
    is_holiday <- as.Date(x) %in% as.Date(holidays)
    return(list(division = current_division, holiday = is_holiday))
  }
  
}
