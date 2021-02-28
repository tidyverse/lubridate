#' @include accessors-month.r
NULL

#' Get the fiscal quarter and semester of a date-time
#'
#' Quarters divide the year into fourths. Semesters divide the year into halfs.
#'
#' @param x a date-time object of class POSIXct, POSIXlt, Date, chron, yearmon,
#'   yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, fts or
#'   anything else that can be converted with as.POSIXlt
#' @param type the format to be returned for the quarter. Can be one one of
#'   "quarter" (default) or "quarter_year", which will return the numeric quarter with or
#'   without a prepended year, or "date_first" or "date_last", which return the
#'   dates starting or ending each quarter.
#' @param fiscal_start numeric indicating the starting month of a fiscal year.
#' @param with_year logical indicating whether or not to include the quarter or
#'   semester's year. Soft-deprecated; use the `type` parameter instead.
#' @return numeric or a vector of class POSIXct if `type` argument is `date_first`
#'   or `date_last`
#' @examples
#' x <- ymd(c("2012-03-26", "2012-05-04", "2012-09-23", "2012-12-31"))
#' quarter(x)
#' quarter(x, type = "quarter_year")
#' quarter(x, type = "quarter_year", fiscal_start = 11)
#' quarter(x, type = "date_first", fiscal_start = 11)
#' quarter(x, type = "date_last", fiscal_start = 11)
#' semester(x)
#' semester(x, with_year = TRUE)
#' @export
quarter <- function(x, type = "quarter", fiscal_start = 1, with_year = type == "quarter_year") {
  fs <- (fiscal_start - 1) %% 12
  shifted <- seq(fs, 11 + fs) %% 12 + 1
  m <- month(x)
  quarters <- rep(1:4, each = 3)
  s <- match(m, shifted)
  q <- quarters[s]

  ## Doing this to handle positional calls where previously `with_year` was the
  ## second param, and also now to handle soft-deprecation of `with_year`.
  if (type == TRUE | with_year == TRUE) type <- "quarter_year"

  switch(type,
    "quarter" = q,
    "quarter_year" = {
      first_quarter_month <- ifelse(fs != 0, fs + 1, 0)
      year(x) - (m < first_quarter_month) + (q / 10)
    },
    "date_first" = ,
    "date_last" = {
      starting_months <- shifted[seq(1, length(shifted), 3)]
      final_years <- year(x) - (starting_months[q] > m)
      quarter_starting_dates <- make_date(year = final_years, month = starting_months[q], day = 1L)
      if (type == 'date_first') {
        quarter_starting_dates
      } else if (type == 'date_last') {
        add_with_rollback(quarter_starting_dates, months(3)) - days(1)
      }
    },
    stop("Unsuported type ", type)
  )
}

#' @rdname quarter
#' @export
semester <- function(x, with_year = FALSE) {
  m <- month(x)
  semesters <- rep(1:2, each = 6)
  s <- semesters[m]
  if (with_year) year(x) + s/10
  else  s
}
