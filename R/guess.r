## dput(as.POSIXct(sprintf("1970-%02d-%02d %s:00:00", 1:12, c(1, 2, 3, 5), c("01", "22")), tz = "UTC"))
.date_template <- structure(c(3600, 2844000, 5274000, 8200800, 10371600, 13212000,
                              15814800, 18741600, 20998800, 23752800, 26442000, 29282400),
                            class = c("POSIXct", "POSIXt"), tzone = "UTC")

.primes <-c(1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59,
 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139,
 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317,
 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421,
 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521,
 523, 541 , 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617,
 619, 631, 641, 643, 647, 653, 659 , 661, 673, 677, 683, 691, 701, 709, 719,
 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809 , 811, 821, 823,
 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937,
 941 , 947, 953, 967, 971, 977, 983, 991, 997, 1009, 1013, 1019, 1021, 1031,
 1033, 1039, 1049, 1051, 1061, 1063, 1069 , 1087, 1091, 1093, 1097, 1103, 1109,
 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217,
 1223 , 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301,
 1303, 1307, 1319, 1321, 1327, 1361, 1367, 1373 , 1381, 1399, 1409, 1423, 1427,
 1429, 1433, 1439, 1447, 1451, 1453, 1459, 1471, 1481, 1483, 1487, 1489, 1493,
 1499, 1511 , 1523, 1531, 1543, 1549, 1553, 1559, 1567, 1571, 1579, 1583, 1597,
 1601, 1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657 , 1663, 1667, 1669, 1693,
 1697, 1699, 1709, 1721, 1723, 1733, 1741, 1747, 1753, 1759, 1777, 1783, 1787,
 1789, 1801, 1811 , 1823, 1831, 1847, 1861, 1867, 1871, 1873, 1877, 1879, 1889,
 1901, 1907, 1913, 1931, 1933, 1949, 1951, 1973, 1979, 1987 , 1993, 1997, 1999,
 2003, 2011, 2017, 2027, 2029, 2039, 2053, 2063, 2069, 2081, 2083, 2087, 2089,
 2099, 2111, 2113, 2129 , 2131, 2137, 2141, 2143, 2153, 2161, 2179, 2203, 2207,
 2213, 2221, 2237, 2239, 2243, 2251, 2267, 2269, 2273, 2281, 2287 , 2293, 2297,
 2309, 2311, 2333, 2339, 2341, 2347, 2351, 2357, 2371, 2377, 2381, 2383, 2389,
 2393, 2399, 2411, 2417, 2423 , 2437, 2441, 2447, 2459, 2467, 2473, 2477, 2503,
 2521, 2531, 2539, 2543, 2549, 2551, 2557, 2579, 2591, 2593, 2609, 2617 , 2621,
 2633, 2647, 2657, 2659, 2663, 2671, 2677, 2683, 2687, 2689, 2693, 2699, 2707,
 2711, 2713, 2719, 2729, 2731, 2741 , 2749, 2753, 2767, 2777, 2789, 2791, 2797,
 2801, 2803, 2819, 2833, 2837, 2843, 2851, 2857, 2861, 2879, 2887, 2897, 2903 ,
 2909, 2917, 2927, 2939, 2953, 2957, 2963, 2969, 2971, 2999, 3001, 3011, 3019,
 3023, 3037, 3041, 3049, 3061, 3067, 3079 , 3083, 3089, 3109, 3119, 3121, 3137,
 3163, 3167, 3169, 3181, 3187, 3191, 3203, 3209, 3217, 3221, 3229, 3251, 3253,
 3257 , 3259, 3271, 3299, 3301, 3307, 3313, 3319, 3323, 3329, 3331, 3343, 3347,
 3359, 3361, 3371, 3373, 3389, 3391, 3407, 3413 , 3433, 3449, 3457, 3461, 3463,
 3467, 3469, 3491, 3499, 3511, 3517, 3527, 3529, 3533, 3539, 3541, 3547, 3557,
 3559, 3571)


##' Guess formats from the supplied date-time character vector.
##'
##'
##' @param x input vector of date-times
##' @param orders format orders to look for. See examples.
##' @param locale locale to use, default to the current locale (also checks en_US)
##' @param preproc_wday whether to preprocess week days names. Internal
##' optimization used by ymd_hms family of functions. If true week days are
##' substituted with %a or %A accordingly, so that there is no need to supply
##' this format explicitly.
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
  ## get all the formats which comply with ORDERS
  orders <- gsub("hms", "HMS", orders, ignore.case = TRUE)
  orders <- gsub("hm", "HM", orders, ignore.case = TRUE)
  orders <- gsub("ms", "MS", orders, ignore.case = TRUE)

  orders <- gsub("[^[:alpha:]]+", "", orders) ## remove all separators
  osplits <- strsplit(orders, "", fixed = TRUE)

  osplits <- lapply(osplits,
                    function(ospt){
                      ## perl lookahead is not working in strsplit. Thus this junk.
                      if( length(which_O <- which(ospt == "O")) > 0 ){
                        ospt[which_O + 1] <- paste("O", ospt[which_O + 1], sep = "")
                        ospt[-which_O]
                      }else
                        ospt
                    })

  reg <- .get_loc_regs(locale)

  if( preproc_wday ){
    ## replace short/long weak days in current locale
    x <- gsub(reg$alpha_exact[["A"]], "%A", x, ignore.case = T, perl = T)
    x <- gsub(reg$alpha_exact[["a"]], "%a", x , ignore.case =  T, perl = T)
  }

  REGS <- unlist(lapply(osplits, function(fnames){
    ## fnames are letters representing an individual valid format, like a, A, b, z, OS, OZ
    which <- ! fnames %in% c(names(reg$alpha_flex), names(reg$num_flex))
    if( any( which ) )
      stop("Unknown formats supplied: ", paste(fnames[ which ], sep = ", "))

    ## restriction: no numbers before or after
    paste("^\\D*?\\b((", paste(unlist(c(reg$alpha_exact, reg$num_exact)[fnames]), collapse = "\\D*?"),
          ")|(",  paste(unlist(c(reg$alpha_flex, reg$num_flex)[fnames]), collapse = "\\D*?"),
          "))\\D*$", sep = "")
  }))

  ## print debugging info
  if( print_matches ){
    subs <- lapply(REGS, .substitute_formats, x, fmts_only = FALSE)
    names(subs) <- orders
    print(do.call(cbind, c(list(x), subs)))
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
  ## Take date X and substitute year with %Y/%y, month with %B/%b etc.
  ## Return the formatted string if REG matched, or null otherwise.
  ## REG should be with captures as build by .build_locale_regs
  ## Captures should start with the strptyme formats. For example Y_e, B_m_e
  ## Traling _e, _m_e are removed.
  ## fmts_only == FALSE is for debugging purpose only

  m <- regexpr(reg, x, ignore.case = TRUE, perl = TRUE)
  ## print(regs[[1]])
  matched <- m > 0

  if ( any(matched) ){
    nms <- attr(m, "capture.names")
    nms <- nms[nzchar(nms)]
    ## e <- grepl("_e", nms, fixed = TRUE)
    ## nms_e <- nms[e]
    ## nms <- nms[!e]

    start <- attr(m, "capture.start")[matched, , drop = FALSE]
    end <- start + attr(m, "capture.length")[matched, , drop = FALSE] - 1L

    lout <- x[matched]
    for( n in rev(nms) ){  ## start from the end
      w <- end[, n] > 0 ## -1 if unmatched  subpatern
      str_sub(lout[w], start[w, n], end[w, n]) <- paste("%", gsub("_.*$", "", n), sep = "")
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

.enclose <- function(fmts)
  paste("@", fmts, "@", sep = "")

.enclosed.na <- function(x)
  x == "@NA@"

.get_train_set <- function(x){
  ## the smartest irregular guesser I could came up with
  x <- x[!.enclosed.na(x)]
  len <- length(x)
  if( len < 100)
    x
  else if( len < 3571 )
    x[.primes[.primes  <= length(x) ] ]
  else
    x[ .primes * (length(x) %/% 3571) ] #501 primes
}

.train_formats <- function(x, formats, locale) {
  ## return a numeric vector of size length(formats), with each element giving
  ## the number of matched elements in X
  ## can return NULL if formats is NULL
  trials <- lapply(formats, function(fmt) .strptime(x, fmt))
  successes <- unlist(lapply(trials, function(x) sum(!is.na(x))), use.names = FALSE)
  names(successes) <- formats
  successes
}

.best_formats <- function(x, orders, locale, .select_formats){
  ## return a vector of formats that matched X at least once.
  ## Can be zero length vector, if none matched
  fmts <- unique(guess_formats(x, orders, locale = locale, preproc_wday = TRUE)) # orders as names
  trained <- .train_formats(x, fmts, locale = locale)

  trained <- trained[ trained > 0 ]
  .select_formats(trained)
}

.select_formats <- function(trained){
  nms <- names(trained)
  n_fmts <- nchar(gsub("[^%]", "", nms)) + grepl("%Y", nms)*1.5
  names(trained[ which.max(n_fmts) ])
}


## cache the regexp value fro each locale
.get_loc_regs <- memoise::memoise(.build_locale_regs)

.build_locale_regs <- function(locale = Sys.getlocale("LC_TIME")){

    orig_locale <- Sys.getlocale("LC_TIME")
    Sys.setlocale("LC_TIME", locale)
    orig_opt <- options(warn = 5)
    on.exit({Sys.setlocale("LC_TIME", orig_locale)
             options(orig_opt)})

    format <- "%a@%A@%b@%B@%p@"
    L <- unique(format(.date_template, format = format))
    mat <- do.call(rbind, strsplit(L, "@", fixed = TRUE))
    mat[] <- gsub("([].|(){^$*+?[])", "\\\\\\1", mat) ## escaping all meta chars
    names <- colnames(mat) <-  strsplit(format, "[%@]+")[[1]][-1L]

    ## Captures should be unique. Thus we build captures with the following rule.
    ## Capture starts with the name of strptime format (B, b, y etc)
    ## It ends with _e or _f indicating whether the expression is an exact or
    ## fixed match, see below.

    ## It can contain _x where x is a main format in which this format
    ## occurs. For example <B_b_e> is an exact capture in the strptime format B
    ## but that also matches b in lubridate. Try lubridate:::.get_loc_regs()
    ## todo: elaborate this explanation

    ## ALPHABETIC FORMATS
    alpha <- list()
    alpha["b"] <-
      sprintf("((?<b_b>%s)|(?<B_b>%s))(?![[:alpha:]])",
              paste(unique(mat[, "b"]), collapse = "|"),
              paste(unique(mat[, "B"]), collapse = "|"))
    alpha["B"] <-
      sprintf("(?<B_B>%s)(?![[:alpha:]])",
              paste(unique(mat[, "B"]), collapse = "|"))

    alpha["a"] <-
      sprintf("((?<a_a>%s)|(?<A_a>%s))(?![[:alpha:]])",
              paste(unique(mat[, "a"]), collapse = "|"),
              paste(unique(mat[, "A"]), collapse = "|"))

    alpha["A"] <-
      sprintf("(?<A_A>%s)(?![[:alpha:]])",
              paste(unique(mat[, "A"]), collapse = "|"))

    ## just match Z in ISO8601, (UTC zulu format)
    alpha["Ou"] <- "(?<Ou_Ou>Z)(?![[:alpha:]])"

    p <- unique(mat[, "p"])
    p <- p[nzchar(p)]
    alpha["p"] <-
      if ( length(p) == 0L ) ""
    else sprintf("(?<p>%s)(?![[:alpha:]])", paste(p, collapse = "|"))

    alpha <- unlist(alpha)

    ##  NUMERIC FORMATS
    num <- num_flex <- num_exact <- c(
      d = "(?<d>[012]?[1-9]|3[01]|[12]0)",
      H = "(?<H>2[0-4]|[01]?\\d)",
      h = "(?<H>2[0-4]|[01]?\\d)",
      I = "(?<I>1[0-2]|0?[1-9])",
      j = "(?<j>[0-3]?\\d?\\d)",
      M = "(?<M>[0-5]?\\d)",
      S = "((?<OS_S>[0-5]?\\d\\.\\d+)|(?<S>[0-6]?\\d))",
      s = "((?<OS_S>[0-5]?\\d\\.\\d+)|(?<S>[0-6]?\\d))",
      U = "(?<U>[0-5]?\\d)",
      w = "(?<w>[0-6])", # merge with a, A??
      u = "(?<u>[1-7])",
      W = "(?<W>[0-5]?\\d)",
      ## x = "(?<x>\\d{2}/[01]?\\d/[0-3]?\\d)",
      ## X = "(?<X>[012]?\\d:[0-5]?\\d:[0-6]?\\d)",
      Y = "(?<Y>\\d{4})",
      y = "((?<Y_y>\\d{4})|(?<y>\\d{2}))",
      Oz = "(?<Oz_Oz>[-+]\\d{4})", ## sptrtime implements only this format (4 digits)
      ## F = "(?<F>\\d{4)-\\d{2}-\\d{2})",
      OO = "(?<OO>[-+]\\d{2}:\\d{2})",
      Oo = "(?<Oo>[-+]\\d{2})"
    )

    nms <- c("T", "R", "r")
    if( length(p) == 0L ){
      ## in some locales %p = ""
      num <- c(num,
               T = sprintf("(%s\\D+%s\\D+%s)", num[["H"]], num[["M"]], num[["S"]]),
               R = sprintf("(%s\\D+%s)", num[["H"]], num[["M"]]),
               r = sprintf("(%s\\D+)", num[["H"]]))

    }else{
      num <- c(num,
               T = sprintf("((%s\\D+%s\\D+%s\\D*%s)|(%s\\D+%s\\D+%s))",
                 num[["I"]], num[["M"]], num[["S"]], alpha[["p"]], num[["H"]], num[["M"]], num[["S"]]),
               R = sprintf("((%s\\D+%s\\D*%s)|(%s\\D+%s))",
                 num[["I"]], num[["M"]], alpha[["p"]], num[["H"]], num[["M"]]),
               r = sprintf("((%s\\D*%s)|%s)",
                 num[["I"]], alpha[["p"]], num[["H"]]))

      num[nms] <- sub("<M", "<M_T",
                      sub("<S", "<S_T",
                          sub("<OS", "<OS_T", num[nms])))
    }


    ## don't let special nms be confused with standard formats
    num[nms] <- gsub("(<[IMSpHS]|<OS)", "\\1_s", num[nms])


    ## The difference between flex regexp and exact is that flex should follow
    ## by non-digit, thus flexible strings like 12-1-2 can be matched. In exact
    ## regexp a number need not be followed by non-number, but then the number
    ## of digits in a number should be precisely specified. This allows matching
    ## 120102. *Note*: the exact regexps is build from flex regex by gsubing
    ## below. So, pay attention when you modify the regexp above.

    alpha_flex <- alpha
    alpha_exact <- gsub(">", "_e>", alpha, fixed = TRUE)

    num_exact <- num_flex <- num
    num_flex[] <- sprintf("%s(?!\\d)", num)

    num_exact[] <- gsub("(?<!\\()\\?(?!<)", "", perl = T, # remove ?
                        gsub("+", "*",  fixed = T,
                             gsub(">", "_e>", num))) # append _e to avoid duplicates

    num_flex["m"] <- sprintf("((?<m>1[0-2]|0?[1-9](?!\\d))|(%s))", gsub("_[bB]", "\\1_m", alpha[["b"]]))
    num_exact["m"] <- sprintf("((?<m_e>1[0-2]|0[1-9])|(%s))", gsub("_[bB]", "\\1_m_e>", alpha[["b"]]))

    ## canoot be in num above because gsub("+", "*") messes it up
    num_flex["OS"] <- "(?<OS_f>[0-5]\\d\\.\\d+)"
    num_exact["OS"] <- "(?<OS_e>[0-5]\\d\\.\\d+)"
    num_flex["z"] <- sprintf("(%s|%s|%s|%s)", alpha_flex[["Ou"]], num_flex[["Oz"]], num_flex[["OO"]], num_flex[["Oo"]])
    num_exact["z"] <- sprintf("(%s|%s|%s|%s)", alpha_exact[["Ou"]], num_exact[["Oz"]], num_exact[["OO"]], num_exact[["Oo"]])

    list(alpha_flex = alpha_flex, num_flex = num_flex,
           alpha_exact = alpha_exact, num_exact = num_exact)
}
