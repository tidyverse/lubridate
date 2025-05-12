##' Guess possible date-times formats from a character vector
##'
##' Guess possible date-times formats from a character vector.
##'
##' @param x input vector of date-times.
##' @param orders format orders to look for. See examples.
##' @param locale locale to use. Defaults to the current locale.
##' @param preproc_wday whether to preprocess weekday names. Internal
##' optimization used by `ymd_hms()` family of functions. If `TRUE`, weekdays are
##' substituted with %a or %A accordingly, so that there is no need to supply
##' this format explicitly.
##' @param print_matches for development purposes mainly. If `TRUE`, prints a matrix
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
                          preproc_wday = TRUE, print_matches = FALSE) {

  ## remove all separators
  orders <- gsub("[^[:alpha:]]+", "", orders)

  if (any(grepl("hms|hm|ms", orders))) {
    .deprecated("hms, hm and ms usage", ", please use HMS, HM or MS instead", "1.5.6")
    orders <- gsub("hms", "HMS", orders, ignore.case = TRUE)
    orders <- gsub("hm", "HM", orders, ignore.case = TRUE)
    orders <- gsub("ms", "MS", orders, ignore.case = TRUE)
  }

  ## redirect some formats to C parser (using perl's lookbehind)
  if (any(wp <- grepl("(?<!O)p", orders, perl = T))) {
    orders <- c(sub("p", "Op", orders[wp], fixed = T), orders)
  }
  if (any(wm <- grepl("(?<!O)m", orders, perl = T))) {
    orders <- c(sub("m", "Om", orders[wm]), orders)
  }
  if (any(wm <- grepl("(?<!O)[bB]", orders, perl = T))) {
    orders <- c(sub("[Bb]", "Ob", orders[wm]), orders)
  }
  if (any(wT <- grepl("T", orders, fixed = T))) {
    orders <- c(sub("T", "HMSOp", orders[wT], fixed = T), orders)
  }
  if (any(wR <- grepl("R", orders, fixed = T))) {
    orders <- c(sub("R", "HMOp", orders[wR], fixed = T), orders)
  }
  if (any(wr <- grepl("r", orders, fixed = T))) {
    orders <- c(sub("r", "HOp", orders[wr], fixed = T), orders)
  }

  ## We split into characterst first and then paste together formats that start
  ## with O.
  osplits <- strsplit(orders, "", fixed = TRUE)
  osplits <- lapply(
    osplits,
    function(ospt) {
      if (length(which_O <- which(ospt == "O")) > 0) {
        ospt[which_O + 1] <- paste("O", ospt[which_O + 1], sep = "")
        ospt[-which_O]
      } else {
        ospt
      }
    }
  )

  reg <- .get_locale_regs(locale)

  flex_regs <- c(reg$alpha_flex, reg$num_flex, .c_parser_reg_flex)
  exact_regs <- c(reg$alpha_exact, reg$num_exact, .c_parser_reg_exact)

  all_format_names <- c(
    names(reg$alpha_flex),
    names(reg$num_flex),
    names(.c_parser_reg_exact)
  )

  REGS <- unlist(lapply(osplits, function(fnames) {
    ## fnames are names of smalest valid formats, like a, A, b, z, OS, OZ ...
    invalid <- !fnames %in% all_format_names
    if (any(invalid)) {
      stop("Unknown formats supplied: ", paste(fnames[invalid], sep = ", "))
    }

    ## restriction: no numbers before or after
    ## fixme: using \\D*? because \\D+ doesn't work in flex match, why?
    paste("^\\D*?\\b((",
      paste(unlist(flex_regs[fnames]), collapse = "\\D*?"),
      ")|(",
      paste(unlist(exact_regs[fnames]), collapse = "\\D*?"),
      "))\\D*$",
      sep = ""
    )
  }))

  ## print debugging info
  if (print_matches) {
    subs <- lapply(REGS, .substitute_formats, x, fmts_only = FALSE)
    names(subs) <- orders
    print(do.call(cbind, c(list(x), subs)))
  }

  .build_formats <- function(regs, orders, x) {
    if (length(x) > 1) {
      subs <- lapply(REGS, .substitute_formats, x, fmts_only = FALSE)
      names(subs) <- orders
      do.call(cbind, c('x' = list(x), subs))
    } else {
      out <- mapply(
        function(reg, name) {
          out <- .substitute_formats(reg, x)
          if (!is.null(out)) {
            names(out) <- rep.int(name, length(out))
            out
          }
        }, REGS, orders,
        SIMPLIFY = F, USE.NAMES = F
      )
      names(out) <- NULL
      unlist(out)
    }
  }

  if (preproc_wday && !any(grepl("[aA]", orders))) {
    ## replace short/long weak days in current locale
    x2 <- gsub(reg$alpha_exact[["A"]], "%A", x, ignore.case = T, perl = T)
    x2 <- gsub(reg$alpha_exact[["a"]], "%a", x2, ignore.case = T, perl = T)
    formats <- .build_formats(REGS, orders, x2)

    ## In some locales abreviated day (italian "gio") is part of month name
    ## ("maggio"). So check if %a or %A is present and append wday-less formats.
    if (any(grepl("%[aA]", formats))) {
      c(formats, .build_formats(REGS, orders, x))
    } else {
      formats
    }
  } else {
    .build_formats(REGS, orders, x)
  }
}

.substitute_formats <- function(reg, x, fmts_only = TRUE) {
  ## Take date X and substitute year with %Y/%y, month with %B/%b etc.
  ## Return the formatted string if REG matched, or null otherwise.
  ## REG should be with captures as build by .build_locale_regs
  ## Captures should start with the strptyme formats. For example Y_e, B_m_e
  ## Traling _e, _m_e are removed.
  ## fmts_only == FALSE is for debugging purpose only

  m <- regexpr(reg, x, ignore.case = TRUE, perl = TRUE)
  ## print(regs[[1]])
  matched <- which(m > 0)

  if (length(matched) > 0) {
    nms <- attr(m, "capture.names")
    nms <- nms[nzchar(nms)]
    ## e <- grepl("_e", nms, fixed = TRUE)
    ## nms_e <- nms[e]
    ## nms <- nms[!e]

    start <- attr(m, "capture.start")[matched, , drop = FALSE]
    end <- start + attr(m, "capture.length")[matched, , drop = FALSE] - 1L

    lout <- x[matched]
    for (n in rev(nms)) { ## start from the end
      w <- end[, n] > 0 ## -1 if unmatched  subpatern
      lout[w] <- .str_sub(
        lout[w], start[w, n], end[w, n],
        paste("%", gsub("_.*$", "", n), sep = "")
      )
    }
    if (fmts_only) {
      lout
    } else {
      ## developer
      out <- character(length(x)) ## dev only
      out[matched] <- lout
      out
    }
  } else if (fmts_only) {
    NULL
  } else {
    character(length(x))
  }
}

.enclose <- function(fmts) {
  paste("@", fmts, "@", sep = "")
}

.enclosed.na <- function(x) {
  x == "@NA@"
}

.get_train_set <- function(x) {
  ## Use first 501 primes to retrieve a subset of the original vector for training of
  ## which formats should come first.
  len <- length(x)
  if (len < 100) {
    x
  } else if (len < 3571) {
    x[.primes[.primes <= length(x)]]
  } else {
    x[.primes * (length(x) %/% 3571)]
  } # 501 primes
}

.train_formats <- function(x, formats, locale) {
  ## return a numeric vector of size length(formats), with each element giving
  ## the number of matched elements in X
  ## can return NULL if formats is NULL

  trials <- lapply(formats, function(fmt) .strptime(x, fmt, locale = locale))
  successes <- unlist(lapply(trials, function(x) sum(!is.na(x))), use.names = FALSE)
  names(successes) <- formats
  sort(successes, decreasing = TRUE)
}

.best_formats <- function(x, orders, locale, .select_formats = .select_formats, drop = FALSE, train = TRUE) {
  ## return a vector of formats that matched X at least once.
  ## Can be zero length vector, if none matched

  fmts <- unique(guess_formats(x, orders, locale = locale, preproc_wday = TRUE))
  if (train && length(fmts)) {
    trained <- .train_formats(x, fmts, locale = locale)

    if (drop) {
      trained <- trained[trained > 0]
    }
    fmts <- .select_formats(trained, drop)
  }
  if (length(fmts)) {
    fmts
  }
}

.select_formats <- function(trained, drop = FALSE) {
  nms <- names(trained)

  score <-
    nchar(gsub("[^%]", "", nms)) + ## longer formats have priority
    grepl("%Y", nms, fixed = T) * 1.5 +
    grepl("%y(?!%)", nms, perl = T) * 1.6 + ## y has priority over Y, but only when not followed by %
    grepl("%[Bb]", nms) * .31 + ## B/b format has priority over %Om
    ## C parser formats have higher priority
    grepl("%Om", nms) * .3 +
    grepl("%Op", nms) * .3 +
    grepl("%Ob", nms) * .32 ## Ob has higher priority than B/b

  ## ties are broken by `trained`
  n0 <- trained != 0
  if (drop) {
    score <- score[n0]
    trained <- trained[n0]
  } else {
    score[!n0] <- -100
  }

  ## print(rbind(trained, score))
  names(trained)[order(score, trained, decreasing = T)]
}

## These are formats that are effectively matched by c parser. But we must get
## through the format guesser first for ymd_hms family.
.c_parser_reg_flex <- list(
  Op = "(?<Op>(AM|PM))(?![[:alpha:]])",
  Om = "((?<Om>1[0-2]|0?[1-9](?!\\d))|(((?<Om_b>Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)|(?<Om_B>January|February|March|April|May|June|July|August|September|October|November|December))(?![[:alpha:]])))",
  Ob = "(((?<Ob_b>Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)|(?<Ob_B>January|February|March|April|May|June|July|August|September|October|November|December))(?![[:alpha:]]))"
)

.c_parser_reg_exact <- list(
  Op = "(?<Op_e>AM|PM)(?![[:alpha:]])",
  Om = "((?<Om_e>1[0-2]|0[1-9])|(((?<Om_b_e>Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)|(?<Om_B_e>January|February|March|April|May|June|July|August|September|October|November|December))(?![[:alpha:]])))",
  Ob = "(((?<Ob_b_e>Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)|(?<Ob_B_e>January|February|March|April|May|June|July|August|September|October|November|December))(?![[:alpha:]]))"
)

.locale_reg_cache <- new.env(hash = FALSE)

.get_locale_regs <- function(locale = Sys.getlocale("LC_TIME")) {
  ## build locale specific regexps for all posible orders

  if (exists(locale, envir = .locale_reg_cache, inherits = FALSE)) {
    return(get(locale, envir = .locale_reg_cache))
  }

  orig_opt <- options(warn = 5)
  on.exit({
    options(orig_opt)
    Sys.setlocale("LC_TIME", orig_locale)
  })
  orig_locale <- Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", locale)
  options(orig_opt)

  format <- "%a@%A@%b@%B@%p@"
  L <- enc2utf8(unique(format(.date_template, format = format)))
  mat <- do.call(rbind, strsplit(L, "@", fixed = TRUE))
  mat[] <- gsub("([].|(){^$*+?[])", "\\\\\\1", mat) # escaping meta chars
  names <- colnames(mat) <- strsplit(format, "[%@]+")[[1]][-1L]

  ## Captures should be unique. Thus we build captures with the following
  ## rule. Capture starts with the name of strptime format (B, b, y etc) It ends
  ## with _e if the expression is an exact match (as oposed to flex), see below.

  ## It can contain _x where x is a main format in which this format
  ## occurs. For example <B_b_e> is an exact capture in the strptime format B
  ## but that also matches b in lubridate. Try lubridate:::.get_loc_regs()
  ## todo: elaborate

  ## ALPHABETIC FORMATS
  alpha <- list()
  alpha["b"] <-
    sprintf(
      "((?<b_b>%s)|(?<B_b>%s))(?![[:alpha:]])",
      paste(unique(mat[, "b"]), collapse = "|"),
      paste(unique(mat[, "B"]), collapse = "|")
    )
  alpha["B"] <-
    sprintf(
      "(?<B_B>%s)(?![[:alpha:]])",
      paste(unique(mat[, "B"]), collapse = "|")
    )

  alpha["a"] <-
    sprintf(
      "((?<a_a>%s)|(?<A_a>%s))(?![[:alpha:]])",
      paste(unique(mat[, "a"]), collapse = "|"),
      paste(unique(mat[, "A"]), collapse = "|")
    )

  alpha["A"] <-
    sprintf(
      "(?<A_A>%s)(?![[:alpha:]])",
      paste(unique(mat[, "A"]), collapse = "|")
    )

  ## just match Z in ISO8601, (UTC zulu format)
  alpha["Ou"] <- "(?<Ou_Ou>Z)(?![[:alpha:]])"

  p <- unique(mat[, "p"])
  p <- p[nzchar(p)]
  no_p <- length(p) == 0L
  alpha["p"] <-
    if (no_p) {
      ""
    } else {
      sprintf("(?<p>%s)(?![[:alpha:]])", paste(p, collapse = "|"))
    }

  alpha <- unlist(alpha)

  ##  NUMERIC FORMATS
  num <- num_flex <- num_exact <- c(
    d = "(?<d>[012]?[1-9]|3[01]|[12]0)",
    q = "(?<q>[0]?[1-4])",
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

  ## special lubridate formats
  nms <- c("T", "R", "r")

  if (no_p) {
    num <- c(num,
      T = sprintf("(%s\\D+%s\\D+%s)", num[["H"]], num[["M"]], num[["S"]]),
      R = sprintf("(%s\\D+%s)", num[["H"]], num[["M"]]),
      r = sprintf("(%s)",   num[["H"]])
    )
  } else {
    num <- c(num,
      T = sprintf(
        "((%s\\D+%s\\D+%s\\D*%s)|(%s\\D+%s\\D+%s))",
        num[["I"]], num[["M"]], num[["S"]], alpha[["p"]],
        num[["H"]], num[["M"]], num[["S"]]
      ),
      R = sprintf(
        "((%s\\D+%s\\D*%s)|(%s\\D+%s))",
        num[["I"]], num[["M"]], alpha[["p"]],
        num[["H"]], num[["M"]]
      ),
      r = sprintf(
        "((%s\\D*%s)|%s)",
        num[["I"]], alpha[["p"]],
        num[["H"]]
      )
    )

    num[nms] <- sub(
      "<M", "<M_T",
      sub(
        "<S", "<S_T",
        sub("<OS", "<OS_T", num[nms])
      )
    )
  }

  ## don't let special nms be confused with standard formats
  num[nms] <- gsub("(<[IMSpHS]|<OS)", "\\1_s", num[nms])


  ## The difference between flex and exact regexp is that flex should follow
  ## by non-digit, thus flexible strings like 12-1-2 can be matched. In exact
  ## regexp a number may not be followed by a non-number. In this case the
  ## number of digits in a number should be precisely specified. For example
  ## 120102 is matched by ymd.
  ##
  ## *Note*: the exact regexps is build from flex regex by gsubing below. So,
  ## pay attention when you modify the regexp above.

  alpha_flex <- alpha
  alpha_exact <- gsub(">", "_e>", alpha, fixed = TRUE)

  num_exact <- num_flex <- num
  num_flex[] <- sprintf("%s(?!\\d)", num)

  num_exact[] <- gsub("(?<!\\()\\?(?!<)", "",
    perl = T, # remove ?
    gsub("+", "*",
      fixed = T,
      gsub(">", "_e>", num)
    )
  ) # append _e to avoid duplicates

  num_flex["m"] <- sprintf("((?<m>1[0-2]|0?[1-9](?!\\d))|(%s))", gsub("_[bB]", "\\1_m", alpha[["b"]]))
  num_exact["m"] <- sprintf("((?<m_e>1[0-2]|0[1-9])|(%s))", gsub("_[bB]", "\\1_m_e", alpha[["b"]]))

  ## canoot be in num above because gsub("+", "*") messes it up
  num_flex["OS"] <- "(?<OS_f>[0-5]\\d\\.\\d+)"
  num_exact["OS"] <- "(?<OS_e>[0-5]\\d\\.\\d+)"
  num_flex["z"] <- sprintf("(%s|%s|%s|%s)", alpha_flex[["Ou"]], num_flex[["Oz"]], num_flex[["OO"]], num_flex[["Oo"]])
  num_exact["z"] <- sprintf("(%s|%s|%s|%s)", alpha_exact[["Ou"]], num_exact[["Oz"]], num_exact[["OO"]], num_exact[["Oo"]])

  wday_order <- order(wday(.date_template, week_start = 7))
  wday_names <- list(
    abr = unique(mat[, "a"][wday_order]),
    full = unique(mat[, "A"][wday_order])
  )

  month_order <- order(month(.date_template))
  # remove trailing dot in some locales (#781)
  month_names <- list(
    abr = sub("\\.", "", unique(mat[, "b"][month_order]), fixed = T),
    full = unique(mat[, "B"][month_order])
  )

  out <- list(
    alpha_flex = alpha_flex, num_flex = num_flex,
    alpha_exact = alpha_exact, num_exact = num_exact,
    wday_names = wday_names, month_names = month_names
  )

  assign(locale, out, envir = .locale_reg_cache)
  out
}
