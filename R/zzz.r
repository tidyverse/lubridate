#' Preserve addition function from base R
#'
#' lubridate overwrites the addition method for POSIXt objects in base R to allow mathematics with date time objects. 
#' base_add_POSIXt preserves the base R addition method for POSIXt objects so it can be referenced within the new addition operations.
#'
#' @name base_add_POSIXt
#' @aliases base_add_POSIXt
NULL

if (!exists("base_add_POSIXt")) {  
  base_add_POSIXt <- base::'+.POSIXt'
}

.onLoad <- function(...) {
  packageStartupMessage(
    "Overriding + and - methods for POSIXt, Date and difftime")

  utils::assignInNamespace("+.Date",     add_dates, "base")
  utils::assignInNamespace("+.POSIXt",   add_dates, "base")
  utils::assignInNamespace("+.difftime", add_dates, "base")
  utils::assignInNamespace("-.Date",     subtract_dates, "base")
  utils::assignInNamespace("-.POSIXt",   subtract_dates, "base")
  utils::assignInNamespace("-.difftime", subtract_dates, "base")

  # Needed so that environment matches environment of add_dates above
  utils::assignInNamespace("+.period",   add_dates, "base")
  utils::assignInNamespace("+.interval", add_dates, "base")
  utils::assignInNamespace("-.period",   subtract_dates, "base")
  utils::assignInNamespace("-.interval", subtract_dates, "base")
}

"+.period" <- "+.interval" <- add_dates
"-.period" <- "-.interval" <- subtract_dates
