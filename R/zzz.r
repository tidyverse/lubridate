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
