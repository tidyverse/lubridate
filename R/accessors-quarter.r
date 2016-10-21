#' @include accessors-month.r
NULL

#' Get the fiscal quarter and semester of a date-time.
#'
#' Quarters divide the year into fourths. Semesters divide the year into halfs.
#'
#' @param x a date-time object of class POSIXct, POSIXlt, Date, chron, yearmon,
#'   yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, fts or
#'   anything else that can be converted with as.POSIXlt
#' @param with_year logical indicating whether or not to include the quarter's
#'   year.
#' @param fiscal_start numeric indicating the starting month of a fiscal year
#' @return numeric
#' @examples
#' x <- ymd(c("2012-03-26", "2012-05-04", "2012-09-23", "2012-12-31"))
#' quarter(x)
#' quarter(x, with_year = TRUE)
#' quarter(x, with_year = TRUE, fiscal_start = 11)
#' semester(x)
#' semester(x, with_year = TRUE)
#' @export
quarter <- function(x, with_year = FALSE, fiscal_start = 1) {
  fs <- fiscal_start - 1
  shifted <- seq(fs, 11 + fs) %% 12 + 1
  m <- month(x)
  quarters <- rep(1:4, each = 3)
  s <- match(m, shifted)
  q <- quarters[s]
  if (with_year) {
    uq <- quarters[m]
    inc_year <- q == 1 & uq == 4
    year(x) + inc_year + q/10
  }
  else q
}

#' @rdname quarter
#' @export
semester <- function(x, with_year = FALSE){
  m <- month(x)
  semesters <- rep(1:2, each = 6)
  s <- semesters[m]
  if (with_year) year(x) + s/10
  else  s
}
