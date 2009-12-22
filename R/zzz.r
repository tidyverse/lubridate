.onLoad <- function(...) {
  packageStartupMessage(
    "Overriding + and - methods for POSIXt, Date and difftime")

  assignInNamespace("+.Date",     add_dates, "base")
  assignInNamespace("+.POSIXt",   add_dates, "base")
  assignInNamespace("+.difftime", add_dates, "base")
  assignInNamespace("-.Date",     subtract_dates, "base")
  assignInNamespace("-.POSIXt",   subtract_dates, "base")
  assignInNamespace("-.difftime", subtract_dates, "base")

  # Needed so that environment matches environment of add_dates above
  assignInNamespace("+.period",   add_dates, "lubridate")
  assignInNamespace("+.interval", add_dates, "lubridate")
  assignInNamespace("-.period",   subtract_dates, "lubridate")
  assignInNamespace("-.interval", subtract_dates, "lubridate")
}

"+.period" <- "+.interval" <- add_dates
"-.period" <- "-.interval"<- subtract_dates