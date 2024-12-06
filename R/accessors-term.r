term <- function(x, type = "quarter", fiscal, with_year, format, holidays = NULL){
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

  if (is.logical(format)) {
    format <- if (format) "year.quarter" else "quarter"
  }
  if (with_year == TRUE) {
    format <- "year.quarter"
  }
  
  
  if (!is.null(holidays)) {
    is_holiday <- as.Date(x) %in% as.Date(holidays)
    return(list(division = current_division, holiday = is_holiday))
  }
  
}
