#' Get the fiscal term of a date-time
#'
#' Quarters divide the year into fourths. Trimesters divide the year into thirds. Semesters divide the year into halfs.
#'
#' @param x a date-time object of class POSIXct, POSIXlt, Date, chron, yearmon, yearqtr,
#'   zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, fts or anything else that can
#'   be converted with as.POSIXlt
#' @param term the way you are dividing the year, be it semesters, trimesters, or quarters.
#' @param type the format to be returned for the quarter. Can be one one of "quarter" -
#'   return numeric quarter (default), "year.quarter" return the ending year and quarter
#'   as a number of the form year.quarter, "date_first" or "date_last" - return the date
#'   at the quarter's start or end, "year_start/end" - return a full description of the
#'   quarter as a string which includes the start and end of the year
#'   (ex. "2020/21 Q1").
#' @param fiscal_start numeric indicating the starting month of a fiscal year.
#' @param holidays list of dates indicating major holidays
#' @param split_count should you want to split up the year in your own number you can
#'   use an "other" and theninput your own division count as a numeric to split_count

term <- function(x, term = "quarter", type = "term", fiscal_start = 1, holidays = NULL, split_count = NULL){
  if (length(fiscal_start) > 1) {
    stop("`fiscal_start` must be a singleton", call. = FALSE)
  }
  fs <- (fiscal_start - 1) %% 12
  shifted <- seq(fs, 11 + fs) %% 12 + 1
  m <- month(x)
  s <- match(m, shifted)
  
  num_divisions <- switch(term,
                          "quarter" = 4,
                          "trimester" = 3,
                          "semester" = 2,
                          "other" = split_count,
                          stop("Unsupported type: ", term))
  
  divisions <- rep(1:num_divisions, each = 12 / num_divisions)
  q <- divisions[s]

  if (is.logical(type)) {
    type <- if (type) "year.term" else "term"
  }
  
  
  if (!is.null(holidays)) {
    is_holiday <- as.Date(x) %in% as.Date(holidays)
    return(list(division = current_division, holiday = is_holiday))
  }

  switch(type,
    "term" = q,
    "year_start/end" = ,
    "year.term" = {
      nxt_year_months <- if (fs != 0) (fs + 1):12
      y =  year(x) + (m %in% nxt_year_months)
      out = y + (q / 10)
      if (type == "year_start/end") {
        out = sprintf("%d/%d Q%d",  y - 1, y %% 100, q)
      }
      out
    },
    "date_first" = ,
    "date_last" = {
      starting_months <- shifted[seq(1, length(shifted), 3)]
      final_years <- year(x) - (starting_months[q] > m)
      quarter_starting_dates <-
        make_date(year = final_years, month = starting_months[q], day = 1L)
      if (type == "date_first") {
        quarter_starting_dates
      } else if (type == "date_last") {
        add_with_rollback(quarter_starting_dates, months(3)) - days(1)
      }
    },
    stop("Unsupported type ", type)
  )
}
