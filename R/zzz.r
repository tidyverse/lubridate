base_add_POSIXt <- base::'+.POSIXt'

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
  assignInNamespace("+.period",   add_dates, "base")
  assignInNamespace("+.interval", add_dates, "base")
  assignInNamespace("-.period",   subtract_dates, "base")
  assignInNamespace("-.interval", subtract_dates, "base")
}

"+.period" <- "+.interval" <- add_dates
"-.period" <- "-.interval" <- subtract_dates
