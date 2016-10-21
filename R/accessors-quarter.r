#' @include accessors-month.r
NULL

#' Get the calendar or fiscal quarter of a date-time.
#'
#' Calendar quarters are a way of dividing the year into fourths. The first quarter (Q1)
#' comprises January, February and March; the second quarter (Q2) comprises April, May,
#' June; the third quarter (Q3) comprises July, August, September; the fourth quarter (Q4)
#' October, November, December. Fiscal quarters often do not align with calendar quarters,
#' but are shifted such that the beginning of the fiscal year is a set number of months prior or
#' subsequent to January.
#'
#' @param x a date-time object of class POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo,
#' zooreg, timeDate, xts, its, ti, jul, timeSeries, fts or anything else that can be converted
#' with as.POSIXlt
#' @param with_year logical indicating whether or not to include the quarter's year.
#' @param fiscal_start numeric indicating the month in which the fiscal year starts, e.g. 11 for November
#' @keywords utilities manip chron methods
#' @return numeric the fiscal quarter that the date-time occurs in
#' @examples
#' x <- ymd(c("2012-03-26", "2012-05-04", "2012-09-23", "2012-12-31"))
#' quarter(x)
#' # 1 2 3 4
#' quarter(x, with_year = TRUE)
#' # 2012.1 2012.2 2012.3 2012.4
#' quarter(x, with_year = TRUE, fiscal_start = 11)
#' # 2012.2 2012.3 2012.4 2013.1
#' @export
quarter <- function(x, with_year = FALSE, fiscal_start = 1) {
  m <- month(x)
  quarters <- c("1" = 1,
                "2" = 1,
                "3" = 1,
                "4" = 2,
                "5" = 2,
                "6" = 2,
                "7" = 3,
                "8" = 3,
                "9" = 3,
                "10" = 4,
                "11" = 4,
                "12" = 4)
  shifted <- seq(fiscal_start - 1, 10 + fiscal_start) %% 12 + 1
  m_shifted <- match(m, shifted)
  if (isTRUE(with_year)){
    q <- unname(quarters[m_shifted])
    unshifted_q <- unname(quarters[m])
    inc_year <- q == 1 & unshifted_q == 4
    y <- year(x) + inc_year
    as.numeric(paste0(y, ".", q))
  } else unname(quarters[m_shifted])
}
