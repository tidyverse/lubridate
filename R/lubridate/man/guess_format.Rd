\name{guess_format}
\Rdversion{1.1}
\alias{guess_format}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
guess_format(x, formats, seps = c("-", "/", ""))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{formats}{
%%     ~~Describe \code{formats} here~~
}
  \item{seps}{
%%     ~~Describe \code{seps} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (x, formats, seps = c("-", "/", "")) 
{
    if (is.list(formats)) 
        formats <- do.call(rbind, formats)
    else formats <- as.matrix(t(formats))
    with_seps <- combine(formats, seps)
    fmts <- unlist(mlply(with_seps, paste))
    x <- paste(x, "@", sep = "")
    fmts2 <- paste(fmts, "@", sep = "")
    trials <- llply(fmts2, function(fmt) strptime(x, fmt))
    successes <- unlist(llply(trials, function(x) sum(!is.na(x))))
    bestn <- max(successes)
    best <- fmts[successes > 0 & successes == bestn]
    if (length(best) == 0) {
        stop(paste(fmts, collapse = ", "), " All failed to parse dates. Check for incorrect or missing elements.")
    }
    else if (length(best) > 1) {
        message("Multiple format matches with ", bestn, " successes: ", 
            paste(best, collapse = ", "), ".")
        best <- best[1]
    }
    best
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
