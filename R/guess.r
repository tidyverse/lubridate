## dput(as.POSIXct(sprintf("1970-%02d-%02d %s:00:00", 1:12, c(1, 2, 3, 5), c("01", "22")), tz = "UTC"))
.date_template <- structure(c(3600, 2844000, 5274000, 8200800, 10371600, 13212000, 
                              15814800, 18741600, 20998800, 23752800, 26442000, 29282400),
                            class = c("POSIXct", "POSIXt"), tzone = "UTC")
.locale_regs_cache <- list()

dev <- T

##' Guess formats from the supplied date-time character vector.
##'
##' 
##' @param x input vector of date-times
##' @param orders format orders to look for. See details.
##' @param locale locale to use, default to the current locale (also checks en_US)
##' @param preproc_wday whether to preprocess weak days names. Internal
##' optimization used by ymd_hms family of functions. If true weak days are
##' substituted with %a or %A accordingly, so that there is no need to supply
##' this format explicitely.
##' @param print_matches for development purpose mainly. If TRUE prints a matrix
##' of matched templates.
##' @return a vector of matched formats
##' @export
##' @examples
##' 
##' x <- c('February 20th 1973',
##'        "february  14, 2004",
##'        "Sunday, May 1, 2000",
##'        "Sunday, May 1, 2000",
##'        "february  14, 04",       
##'        'Feb 20th 73',
##'        "January 5 1999 at 7pm",
##'        "jan 3 2010",
##'        "Jan 1, 1999", 
##'        "jan 3   10",
##'        "01 3 2010",
##'        "1 3 10",
##'        '1 13 89',
##'        "5/27/1979", 
##'        "12/31/99", 
##'        "DOB:12/11/00", 
##'        "-----------", 
##'        'Thu, 1 July 2004 22:30:00',
##'        'Thu, 1st of July 2004 at 22:30:00',
##'        'Thu, 1July 2004 at 22:30:00',
##'        'Thu, 1July2004 22:30:00',
##'        'Thu, 1July04 22:30:00',
##'        "21 Aug 2011, 11:15:34 pm",
##'        "-----------", 
##'        "1979-05-27 05:00:59",
##'        "1979-05-27", 
##'        "-----------", 
##'        "3 jan 2000", 
##'        "17 april 85", 
##'        "27/5/1979", 
##'        '20 01 89', 
##'        '00/13/10',
##'        "-------", 
##'        "14 12 00",
##'        "03:23:22 pm")
##' 
##' guess_formats(x, "BdY")
##' guess_formats(x, "Bdy")
##' ## m also matches b and B; y also matches Y
##' guess_formats(x, "mdy", print_matches = TRUE)
##' 
##' ## T also matches IMSp order
##' guess_formats(x, "T", print_matches = TRUE)
##' 
##' ## b and B are equivalent and match, both, abreviated and full names
##' guess_formats(x, c("mdY", "BdY", "Bdy", "bdY", "bdy"), print_matches = TRUE)
##' guess_formats(x, c("dmy", "dbY", "dBy", "dBY"), print_matches = TRUE)
##' 
##' 
##' guess_formats(x, c("dBY HMS", "dbY HMS", "dmyHMS", "BdY H"), print_matches = TRUE)
##' 
##' guess_formats(x, c("ymd HMS"), print_matches = TRUE)
##' 
guess_formats <- function(x, orders, locale = Sys.getlocale("LC_TIME"),
                          preproc_wday = TRUE, print_matches = FALSE){
  ## get all the formats which suite ORDERS 
  
  orders <- gsub("[^[:alpha:]]+", "", orders)
  orders <- gsub("OS\\d*", "Q", orders) ## hack
  osplits <- strsplit(orders, "", fixed = TRUE)
  reg <- .get_loc_regs(locale)

  if( preproc_wday ){
    x <- gsub(reg$alpha_exact[["A"]], "%A", x, ignore.case = T, perl = T)
    x <- gsub(reg$alpha_exact[["a"]], "%a", x , ignore.case =  T, perl = T)
  }
  
  REGS <- unlist(lapply(osplits, function(names){

    which <- ! names %in% c(names(reg$alpha_flex), names(reg$num_flex))
    if( any( which ) )
      stop("Unknown formats supplied: ", paste(names[ which ], sep = ", "))
    
    ## !! the restriction, no numbers before, after and in between of the formats
    paste("^\\D*?\\b((", paste(unlist(c(reg$alpha_exact, reg$num_exact)[names]), collapse = "\\D*?"), 
          ")|(",  paste(unlist(c(reg$alpha_flex, reg$num_flex)[names]), collapse = "\\D*?"), 
          "))\\D*$", sep = "")
  }))

  if( print_matches ){
    subs <- lapply(REGS, .substitute_formats, x, fmts_only = FALSE)
    names(subs) <- orders
    print(do.call(cbind, c(list(x), subs))) ## deb
  }
  
  out <- mapply(
    function(reg, name){
      out <- .substitute_formats(reg, x)
      if( !is.null(out) ) names(out) <- rep.int(name, length(out))
      out
    }, REGS, orders, SIMPLIFY= F, USE.NAMES= F)
  names(out) <- NULL
  unlist(out)
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
    ## e <- grepl("_e", ns, fixed = TRUE)
    ## ns_e <- ns[e]
    ## ns <- ns[!e]
    
    start <- attr(m, "capture.start")[matched, , drop = FALSE]
    end <- start + attr(m, "capture.length")[matched, , drop = FALSE] - 1L

    lout <- x[matched]
    for( n in rev(ns) ){  ## start from the end
      w <- end[, n] > 0 ## -1 if unmatched  subpatern
      str_sub(lout[w], start[w, n], end[w, n]) <- paste("%", sub("_[[:alpha:]]$", "", n), sep = "")
    }    
    if(fmts_only)
      lout
    else{
      ## developer
      out <- character(length(x)) ## dev only
      out[matched] <- lout
      out
    }
  }else if (fmts_only)
    NULL
  else character(length(x))
}



.get_loc_regs <- function(locale = Sys.getlocale("LC_TIME")){

  regs <- .locale_regs_cache[[locale]]
  
  if( dev | is.null(regs) ){ 
    orig_locale <- Sys.getlocale("LC_TIME")
    Sys.setlocale("LC_TIME", locale)
    orig_opt <- options(warn = 5)
    on.exit({Sys.setlocale("LC_TIME", orig_locale)
             options(orig_opt)})

    format <- "%a@%A@%b@%B@%p"
    L <- unique(format(.date_template, format = format))
    mat <- do.call(rbind, strsplit(L, "@", fixed = TRUE))
    names <- colnames(mat) <-  strsplit(format, "[%@]+")[[1]][-1L]

    alpha <- list()
    alpha["b"] <- 
      sprintf("((?<b>%s)|(?<B>%s))(?![[:alpha:]])",
              paste(unique(mat[, "b"]), collapse = "|"),
              paste(unique(mat[, "B"]), collapse = "|"))
    alpha["B"] <- 
      sprintf("(?<B>%s)(?![[:alpha:]])",
              paste(unique(mat[, "B"]), collapse = "|"))

    alpha["a"] <- 
      sprintf("((?<a>%s)|(?<A>%s))(?![[:alpha:]])",
              paste(unique(mat[, "a"]), collapse = "|"),
              paste(unique(mat[, "A"]), collapse = "|"))

    alpha["A"] <- 
      sprintf("(?<A>%s)(?![[:alpha:]])",
              paste(unique(mat[, "A"]), collapse = "|"))

    p <- unique(mat[, "p"])
    p <- p[nzchar(p)]
    alpha["p"] <-
      if ( length(p) == 0L ) ""
      else sprintf("(?<p>%s)(?![[:alpha]])", paste(p, collapse = "|"))
    
    alpha <- unlist(alpha)
    
    num <- num_flex <- num_exact <- c(
      d = "<d>[0-2]?\\d|3[01]", ## todo: enumerate 30, 31
      H = "<H>2[0-4]|[01]?\\d",
      I = "<I>1[0-2]|0?[1-9]", 
      j = "<j>[0-3]?\\d?\\d", 
      M = "<M>[0-5]?\\d", 
      S = "<S>[0-6]?\\d", 
      U = "<U>[0-5]?\\d", 
      w = "<w>[0-6]", # merge with a, A??
      u = "<u>[1-7]", 
      W = "<W>[0-5]?\\d", 
      x = "<x>\\d{2}/[01]?\\d/[0-3]?\\d", 
      X = "<X>[012]?\\d:[0-5]?\\d:[0-6]?\\d", 
      Y = "<Y>\\d{4}", 
      z = "<z>[-+]\\d{4,}", ## R implements only 4 digits
      F = "<F>\\d{4)-\\d{2}-\\d{2}", 
      Q = "<OS>[0-5]\\d\\.\\d+" ## fractional
      )

    num2 <- gsub("?", "", num, fixed= TRUE)
    
    num_flex[] <- sprintf("(?%s)(?!\\d)", num)
    num_exact[] <- sprintf("(?%s)", num2)
    num_exact <- sub(">", "_e>", num_exact, fixed = TRUE)
    
    alpha_flex <- alpha
    alpha_exact <- gsub(">", "_e>", alpha, fixed = TRUE)



    ## m match %m, %b and %B
    num_flex <- c(num_flex,
                  m = sprintf("(((?<m>1[0-2]|0?[1-9])(?!\\d))|(%s))", alpha[["b"]]),
                  y = "((?<y>\\d{2})|(?<Y>\\d{4}))(?!\\d)")
    
    num_exact <- c(num_exact,
                   m = sprintf("((?<m_e>1[012]|0[1-9])|(%s))", alpha_exact[["b"]]),
                   y = "((?<y_e>\\d{2})|(?<Y_e>\\d{4}))")

    nms <- c("T", "R", "r")
    if( length(p) == 0L ){
      num_flex <- c(num_flex,
                    T = sprintf("((?%s)\\D+(?%s)\\D+(?%s)(?!\\d)", num[["H"]], num[["M"]], num[["S"]]), 
                    R = sprintf("((?%s)\\D+(?%s)(?!\\d)", num[["H"]], num[["M"]]),
                    r = sprintf("((?%s)\\D+(?%s)(?!\\d)", num[["H"]]))
      num_exact[nms] <-
        gsub("\\?(?!<)", "", gsub("+", "*", num_exact[nms], fixed = T), perl = T)
      
    }else{
      num_flex <- c(num_flex,
                    T = sprintf("((?%s)\\D+(?%s)\\D+(?%s)\\D+%s)|((?%s)\\D+(?%s)\\D+(?%s)(?!\\d))",
                      num[["I"]], num[["M"]], num[["S"]], alpha[["p"]], num[["H"]], num[["M"]], num[["S"]]), 
                    R = sprintf("((?%s)\\D+(?%s)\\D+%s)|((?%s)\\D+(?%s)(?!\\d))",
                      num[["I"]], num[["M"]], alpha[["p"]], num[["H"]], num[["M"]]),
                    r = sprintf("((?%s)\\D+%s)|((?%s)(?!\\d))",
                      num[["I"]], alpha[["p"]], num[["H"]]))
      num_flex[nms] <- sub("<M>", "<M_T>", sub("<S>", "<S_T>", num_flex[nms], fixed = T), fixed = T) ## unique captures
      num_exact[nms] <-
        gsub("\\?(?!<)", "", gsub("+", "*", num_exact[nms], fixed = T), perl = T)
    }
    
    .locale_regs_cache[[locale]] <- regs <-
      list(alpha_flex = alpha_flex, num_flex = num_flex,
           alpha_exact = alpha_exact, num_exact = num_exact)
  }
  
  regs
}
