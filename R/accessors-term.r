#' Get create a term data frame
#'
#' @param start_date The first day of the term in year month day format.
#' @param weeks The length of the term in weeks. Must be a singular numeric value,
#'  automates to 10
#' @param skip list of dates for which there may not be school, and pushes the end of the term back
#' @param holidays list of dates indicating major holidays, marks it in the final
#'  data frame as a holiday, but does not add length to the term.
#' @param class_days To indicate which days of the week there are class.
#' For example, if Tuesday and Friday are class days the input must be written
#' like c(2, 5), c('Tue', 'Fri'), c('Tu', 'F'), c('Tuesday', 'Friday'),
#'  or c('Tue', 'Friday'), etc
#' @param holidays list of dates indicating major holidays
#' @param exams list of exam dates


set_term <- function(start_date= "2025-01-01",
                     weeks = 10,
                     skip= NULL,
                     holidays= NULL,
                     class_days = NULL,
                     exams = NULL){

  class_days <- clean_class_days(class_days)
  total_skip <- 0

  if (is.null(weeks)||!is.numeric(weeks)) {
    stop("weeks parameter must contain a numeric value")
  }

  if (is.null(start_date)) {
    stop("start_date parameter must contain a date in year-month-day form")
  }
  all_skip_dates <- c()
  if (!is.null(skip)) {
    if (!all(c("start", "end") %in% names(skip))) {
      stop("`skip` data frame must contain `start` and `end` columns.")
    }

    skip$end <- ymd(skip$'end')
    skip$start <- ymd(skip$'start')
    for(i in 1:nrow(skip)){
      skip_range <- seq(ymd(skip$start[i]),
                        ymd(skip$end[i]),
                        by='days')

      all_skip_dates <- unique(c(all_skip_dates,
                                 skip_range))
    }
    total_skip <- length(all_skip_dates)


  }

  start_date <- ymd(start_date)
  total_days <- weeks*7 + total_skip
  end_date <- start_date +days(total_days)
  date_range <- seq(start_date, end_date, by='days')

  term <- data.frame(
    date = date_range,
    day = weekdays(date_range),
    status = "no class",
    stringsAsFactors = FALSE,
    class = FALSE
  )

  term$status[term$day %in% class_days] <- "class"
  term$status[term$date %in% all_skip_dates] <-"skip"
  term$status[term$date %in% ymd(holidays)] <- "holiday"
  term$status[term$date %in% ymd(exams)] <- "exam"
  term$class[term$status %in% c("class", "exam")] <- TRUE
  return(term)
}


clean_class_days <- function(class_days) {
  week_days <- c()
  valid_days <- c("Monday", "Tuesday", "Wednesday",
                  "Thursday", "Friday", "Saturday", "Sunday")
  short_days <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
  letter_days <- c("M", "Tu", "W", "Tr", "F", "Sa", "Su")


  if (is.null(class_days)) {
    return(c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"))
  }

  for (i in seq_along(class_days)) {
    day <- class_days[i]

    #numeric input
    if (is.numeric(day)) {
      if (day >= 1 && day <= 7) {
        week_days <- c(week_days, valid_days[day])
      } else {
        stop("Numeric `class_days` values must be between 1 and 7.")
      }
    }
    #short names like "Mon", "Tue"
    else if (day %in% short_days) {
      week_days <- c(week_days, valid_days[match(day, short_days)])
    }
    #single-letter abbreviations like "M", "Tu"
    else if (day %in% letter_days) {
      week_days <- c(week_days, valid_days[match(day, letter_days)])
    }
    #full names like "Monday", "Tuesday"
    else if (day %in% valid_days) {
      week_days <- c(week_days, day)
    }
    #invalid input
    else {
      stop("Invalid `class_days` value. Must be a valid day of the week.
           For example, if Tuesday, must be written like c(2),
           c('Tue'), c('Tu'), or c('Tuesday')")
    }
  }

  return(unique(week_days))
}

#' @rdname set_term
#' @export
