
.date_template <- as.POSIXct(sprintf("1970-%02d-%02d %s:00:00", 1:12, c(1, 2, 3, 5), c("01", "22")), tz = "UTC")
.locale_regs_cache <- list()

.get_loc_regs <- function(locale = Sys.getlocale("LC_TIME")){

  regs <- .locale_regs_cache[[locale]]
  
  if( is.null(regs) ){
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

    regs_num <- c(
                  d = "(?<d>[0-3]?\\d)", 
                  H = "(?<H>[0-2]?\\d)", 
                  I = "(?<I>[01]?\\d)", 
                  j = "(?<j>[0-3]?\\d{1,2})", 
                  m = "(?<m>[01]?\\d)", 
                  M = "(?<M>[0-5]?\\d)", 
                  S = "(?<S>[0-6]?\\d)", 
                  U = "(?<U>[0-5]?\\d)", 
                  w = "(?<w>[0-7])", ## also includes 7 for computational benefits
                  u = "(?<u>[1-7])", 
                  W = "(?<W>[0-5]?\\d)", 
                  x = "(?<x>\\d{1,2)/[01]?\\d/[0-3]?\\d)", 
                  X = "(?<X>[012]?\\d:[0-5]?\\d:[0-6?]\\d)", 
                  y = "(?<y>\\d{2})", 
                  Y = "(?<Y>\\d{4})", 
                  z = "(?<z>[-+]\\d{4)", ## ISO8601 supports more, but R implements only this
                  F = "(?<F>\\d{4)-\\d{2}-\\d{2})", 
                  T = "(?<T>\\d{2):\\d{2}:\\d{2})", 

                  Q = "(?<OS>[0-5]\\d\\.\\d+)" ## fractional
                  )
    regs_num[] <- paste(regs_num, "(?!\\d)", sep = "")
    
    regs <- .locale_regs_cache[[locale]] <- c(regs_alpha, regs_num)
  }

  regs
}

substitute_formats <- function(x, orders, locale = Sys.getlocale("LC_TIME")){
  
  orders <- gsub("[^[:alpha:]]+", "", orders)
  orders <- gsub("OS\\d*", "Q", orders) ## hack
  splits <- strsplit(orders, "", fixed = TRUE)
  lcreg <- .get_loc_regs(locale)
  
  regs <- unlist(lapply(splits, function(n){
    r <- lcreg[n]
    if(any(is.na(names(r))))
      stop("Unknown formats supplied: ", paste(n[is.na(names(r))], sep = ", "))
    paste("\\b", paste(r, collapse = "\\D*"), "\\b", sep = "")
  }))
  
  .substitute_formats(x, regs)
}


.substitute_formats <- function(x, regs){
  ## regs should be with captures named with the corresponding format letters 
  ## return substituted formats
  ## null if nothing matched
  m <- regexpr(regs[1], x, ignore.case = TRUE, perl = TRUE)
  ## print(regs[[1]])
  matched <- m > 0
  
  out <- character(length(x))
  if ( any(matched) ){
    ns <- attr(m, "capture.names")
    ns <- ns[nzchar(ns)]
    start <- attr(m, "capture.start")[matched,, drop = FALSE]
    end <- start + attr(m, "capture.length")[matched, drop = FALSE] - 1L

    lout <- x[matched]
    for( n in rev(ns) )  ## start from the end
      str_sub(lout, start[, n], end[, n]) <- paste("%", n, sep = "")

    out[matched] <- lout
    
  }else
    out <- NULL
  
  newx <- x[!matched]
  if( length(newx) > 1 )
    out[!matched] <-
      if( length(regs) > 1 )
        .substitute_formats(newx, regs[-1])
      else NA
  
  out
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

cbind(x, substitute_formats(x, "BdY"))
cbind(x, substitute_formats(x, "bdY"))
cbind(x, substitute_formats(x, "bdy"))
cbind(x, substitute_formats(x, "Bdy"))
cbind(x, substitute_formats(x, "bdy"))

cbind(x, substitute_formats(x, c("dBY HMS")))
cbind(x, substitute_formats(x, c("dbY HMS")))
cbind(x, substitute_formats(x, c("dBy HMS")))

cbind(x, substitute_formats(x, c("Ymd HMS")))

cbind(x, substitute_formats(rep(x, 10000), c("BdY", "bdY", "bdy")))

y <- rep(x, 3)
f <- rep(c("BdY", "bdY", "bdy"), 10)
system.time( for (i in 1:1) substitute_formats(y, f))

## Reg <- c("\\b(?<Q>[0-2]?\\d)\\D*?(?<p>(AM|PM))",
##          "\\b(?<T>[0-2]?\\d)\\D*?(?<D>(DD|BB))")

## x <- c("aaa 32AM aaa",
##        "bbb 22 AM bbb", 
##        "ccc 14 PM ccc")


## gsub(reg , "####",x , ignore.case=T, perl = TRUE)
## regexpr(reg, x[1], perl=T)
