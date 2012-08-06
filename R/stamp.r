library(stringr)
.date_template <- as.POSIXct(sprintf("1970-%02d-%02d %s:00:00", 1:12, c(1, 2, 3, 5), c("01", "22")), tz = "UTC")
.locale_regs_cache <- list()

.get_loc_regs <- function(locale = Sys.getlocale("LC_TIME")){

  regs <- .locale_regs_cache[[locale]]
  
  if( T | is.null(regs) ){
    orig_locale <- Sys.getlocale("LC_TIME")
    Sys.setlocale("LC_TIME", locale)
    orig_opt <- options(warn = 5)
    on.exit({Sys.setlocale("LC_TIME", orig_locale)
             options(orig_opt)})

    format <- "%a@%A@%b@%B@%p"
    L <- unique(format(.date_template, format = format))
    mat <- do.call(rbind, strsplit(L, "@", fixed = TRUE))
    names <- colnames(mat) <-  strsplit(format, "[%@]+")[[1]][-1L]

    regs_alpha <- list()
    for( n in names )
      regs_alpha[[n]] <- sprintf("(?<%s>%s)(?![[:alpha:]])", n,
                                 paste(unique(mat[, n]), collapse = "|"))
    regs_alpha <- unlist(regs_alpha)
    
    regs_num <- c(
      d = "(?<d>[0-3]?\\d)", 
      H = "(?<H>[0-2]?\\d)", 
      I = "(?<I>[01]?\\d)", 
      j = "(?<j>[0-3]?\\d?\\d)", 
      m = "(?<m>[01]?\\d)", 
      M = "(?<M>[0-5]?\\d)", 
      S = "(?<S>[0-6]?\\d)", 
      U = "(?<U>[0-5]?\\d)", 
      w = "(?<w>[0-7])", ## also includes 7 for computational benefits
      u = "(?<u>[1-7])", 
      W = "(?<W>[0-5]?\\d)", 
      x = "(?<x>\\d{2}/[01]?\\d/[0-3]?\\d)", 
      X = "(?<X>[012]?\\d:[0-5]?\\d:[0-6]?\\d)", 
      y = "(?<y>\\d{2})", 
      Y = "(?<Y>\\d{4})", 
      z = "(?<z>[-+]\\d{4,})", ## R implements only 4 digits
      F = "(?<F>\\d{4)-\\d{2}-\\d{2})", 
      T = "(?<T>[012]?\\d:[0-5]?\\d:[0-6]?\\d)",

      Q = "(?<OS>[0-5]\\d\\.\\d+)" ## fractional
      )

    regs <-
      list(alpha = regs_alpha,
           num = regs_num,
           alpha_exact = sub(">", "_e>", gsub("]?", "]", regs_alpha, fixed= TRUE)), 
           num_exact = sub(">", "_e>", gsub("]?", "]", regs_num, fixed= TRUE))
           )
    .locale_regs_cache[[locale]] <- regs
    
  }

  regs
}

guess_formats <- function(x, orders, locale = Sys.getlocale("LC_TIME")){
  ## get all the formats which suite ORDERS 
  
  orders <- gsub("[^[:alpha:]]+", "", orders)
  orders <- gsub("OS\\d*", "Q", orders) ## hack
  osplits <- strsplit(orders, "", fixed = TRUE)
  reg <- .get_loc_regs(locale)
  
  REGS <- unlist(lapply(osplits, function(n){

    alpha <- n %in% names(reg$alpha)
    num <- n %in% names(reg$num)

    if( any( which <- !(alpha|num) ) )
       stop("Unknown formats supplied: ", paste(n[ which ], sep = ", "))

    paste("^\\D*?\\b(", paste(c(reg$alpha_exact, reg$num_exact)[n], collapse = "\\D*?"), ## no numbers between exact formats!!
          ")|(",  paste(reg$alpha[n[alpha]], collapse = ".*?"), "\\D*?", paste(reg$num[n[num]], collapse = "(?!\\d)\\D*?"), 
          ")\\D*$", sep = "") ## !! the only restriction, no numbers after the format
  }))
  
  subs <- lapply(REGS, .substitute_formats, x, fmts_only = FALSE)
  names(subs) <- orders
  print(do.call(cbind, c(list(x), subs))) ## deb

  unlist(lapply(REGS, .substitute_formats, x))
}


.substitute_formats <- function(reg, x, fmts_only = TRUE){
  ## reg should be with captures named with the corresponding format letters 
  ## return substituted formats
  ## null if nothing matched
  
  m <- regexpr(reg, x, ignore.case = TRUE, perl = TRUE)
  ## print(regs[[1]])
  matched <- m > 0

  if ( any(matched) ){
    ns <- attr(m, "capture.names")
    ns <- ns[nzchar(ns)]
    e <- grepl("_e", ns, fixed = TRUE)
    ns_e <- ns[e]
    ns <- ns[!e]
    
    start <- ## captures are 0 for unmatched subexp
      attr(m, "capture.start")[matched, ns, drop = FALSE] +
        attr(m, "capture.start")[matched, ns_e, drop = FALSE]
    end <- start +
      attr(m, "capture.length")[matched, ns, drop = FALSE] + 
        attr(m, "capture.length")[matched, ns_e, drop = FALSE] - 1L

    lout <- x[matched]
    for( n in rev(ns) )  ## start from the end
      str_sub(lout, start[, n], end[, n]) <- paste("%", n, sep = "")

    if(fmts_only)
      lout
    else{
      out <- character(length(x))
      out[matched] <- lout
      out
    }
  }else
    NULL
}

x <- c('February 20th 1973',
       "January 5 1999 at 7pm",
       "february  14, 2004",
       "Sunday, May 1, 2000",
       "Sunday, May 1, 2000",
       "jan 3 2010",
       "Jan 1, 1999", 
       "jan 3   10", 
       "-----------", 
       'Thu, 1 July 2004 22:30:00',
       'Thu, 1st of July 2004 at 22:30:00',
       'Thu, 1July 2004 at 22:30:00',
       'Thu, 1July2004 22:30:00',
       "21 Aug 2011, 11:15:34 pm",
       "-----------", 
       "1979-05-27 05:00:59",
       "1979-05-27", 
       "-----------", 
       "3 jan 2000", 
       "17 april 85", 
       "5/27/1979", 
       "27/5/1979", 
       "12/31/99", 
       "DOB:12/11/00", 
       '20 01 89', 
       '1 13 89', 
       '00/13/10') 

guess_formats(x, "BdY")

guess_formats(x, "bdY")
guess_formats(x, "bdy")
guess_formats(x, "Bdy")
guess_formats(x, "bdy")

guess_formats((x, c("dBY HMS")))
guess_formats((x, c("dbY HMS")))
guess_formats((x, c("dBy HMS")))

guess_formats((x, c("Ymd HMS")))

guess_formats(x, c("BdY", "bdY", "bdy"))

y <- rep(x, 3)
f <- rep(c("BdY", "bdY", "bdy"), 10)
system.time( for (i in 1:1) substitute_formats(y, f))

reg <- c("\\b(?<Q>[0-2]?\\d)\\D*?(?<p>(AM|PM))",
         "\\b(?<T>[0-2]?\\d)\\D*?(?<D>(DD|BB))")

reg <- c("\\b((?<fixed>(?<Q_f>[0-2]?\\d)\\D*?(?<p_f>(AM|PM)))|(?<flex>(?<Q>[0-2]?\\d)\\D*?(?<p>(DD|BB))))")
x <- c("aaa 12 DD aaa",
       "bbb 22 AM bbb", 
       "ccc 14 PM ccc")
## gsub(reg , "####",x , ignore.case=T, perl = TRUE)
regexpr(reg[[1]], x, perl=T)
