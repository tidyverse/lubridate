library(stringr)
.date_template <- as.POSIXct(sprintf("1970-%02d-%02d %s:00:00", 1:12, c(1, 2, 3, 5), c("01", "22")), tz = "UTC")
.locale_regs_cache <- list()
dbg <- T

guess_formats <- function(x, orders, locale = Sys.getlocale("LC_TIME")){
  ## get all the formats which suite ORDERS 
  
  orders <- gsub("[^[:alpha:]]+", "", orders)
  orders <- gsub("OS\\d*", "Q", orders) ## hack
  osplits <- strsplit(orders, "", fixed = TRUE)
  reg <- .get_loc_regs(locale)
  
  REGS <- unlist(lapply(osplits, function(names){

    which <- ! names %in% c(names(reg$alpha_flex), names(reg$num_flex))
    if( any( which ) )
       stop("Unknown formats supplied: ", paste(names[ which ], sep = ", "))
    
    ## !! the restriction, no numbers before, after and in between of the formats
    paste("^\\D*?\\b((", paste(c(reg$alpha_exact, reg$num_exact)[names], collapse = "\\D?"), 
          ")|(",  paste(c(reg$alpha_flex, reg$num_flex)[names], collapse = "\\D*?"), 
          "))\\D*$", sep = "")
  }))

  if( dbg ){
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


stamp <- function(x, orders = unlist(lubridate_formats),
                  locale = Sys.getlocale("LC_TIME"), quiet = FALSE){
  ## if( is.null(orders) )
  ##   orders <- 

  fmts <- guess_formats(x, orders, locale)
  if( is.null(fmts) ) stop( "Couldn't quess formats. ")
  if( length(fmts) == 1L ){
    FMT <- fmts[[1]]
  }else{
    trained <- .train_formats(x, fmts)
    trained <- trained[ order(nchar(names(fmts)), trained, decreasing= TRUE) ]
    trained <- trained[trained > 0]
    FMT <- names(trained)[1]
    if( !quiet && length(trained) > 1 )
      message("Multiple formats matched: ", paste("\"", names(trained),"\"(", trained, ")", sep = "", collapse= ", "), ";\n ")
  }

  if( !quiet )
    message("Using: \"", FMT, "\"")

  f <- eval(substitute(function(x){ format(x, format = FMT)}, list(FMT = FMT)), envir = topenv())
  attr(f, "srcref") <- NULL
  f
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
    for( n in rev(ns) ){  ## start from the end
      w <- end[, n] > 0 ## -1 if unmatched  subpatern
      str_sub(lout[w], start[w, n], end[w, n]) <- paste("%", n, sep = "")
    }
    
    if(fmts_only)
      lout
    else{
      out <- character(length(x))
      out[matched] <- lout
      out
    }
  }else if (fmts_only)
    NULL
  else character(length(x))
}



.get_loc_regs <- function(locale = Sys.getlocale("LC_TIME")){

  regs <- .locale_regs_cache[[locale]]
  
  if( dbg | is.null(regs) ){ 
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
    alpha["b"] <- alpha["B"] <-
      sprintf("((?<b>%s)|(?<B>%s))(?![[:alpha:]])",
              paste(unique(mat[, "b"]), collapse = "|"),
              paste(unique(mat[, "B"]), collapse = "|"))
    alpha["a"] <- alpha["A"] <-
      sprintf("((?<a>%s)|(?<A>%s))(?![[:alpha:]])",
              paste(unique(mat[, "a"]), collapse = "|"),
              paste(unique(mat[, "A"]), collapse = "|"))      
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
      T = "<T>[012]?\\d:[0-5]?\\d:[0-6]?\\d",
      Q = "<OS>[0-5]\\d\\.\\d+" ## fractional
      )

    
    num_flex[] <- sprintf("(?%s)(?!\\d)", num)
    num_exact[] <- sprintf("(?%s)", gsub("?", "", num, fixed= TRUE))
    num_exact <- sub(">", "_e>", num_exact, fixed = TRUE)
    
    alpha_flex <- alpha
    alpha_exact <- gsub(">", "_e>", alpha, fixed = TRUE) 

    ## m match %m, %b and %B
    num_flex <- c(num_flex,
                  m = sprintf("((?<m>1[0-2]|0?[1-9])(?!\\d))|(%s)", alpha[["b"]]),
                  y = sprintf("((?<y>\\d{2})|(?<Y>\\d{4}))(?!\\d)")) 
    num_exact <- c(num_exact,
                   m = sprintf("(?<m_e>1[012]|0[1-9])|(%s)", alpha_exact[["b"]]),
                   y = sprintf("((?<y_e>\\d{2})|(?<Y_e>\\d{4}))"))
    
    .locale_regs_cache[[locale]] <- regs <-
      list(alpha_flex = alpha_flex, num_flex = num_flex,
           alpha_exact = alpha_exact, num_exact = num_exact)
  }
  
  regs
}
