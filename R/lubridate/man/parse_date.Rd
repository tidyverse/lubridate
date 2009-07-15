\name{parse_date}
\Rdversion{1.1}
\alias{parse_date}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
parse_date(x, formats, seps = c("-", "/", ".", ""))
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
function (x, formats, seps = c("-", "/", ".", "")) 
{
    fmt <- guess_format(x, formats, seps)
    parsed <- as.POSIXct(strptime(x, fmt))
    if (length(x) > 2) 
        message("Using date format ", fmt, ".")
    failed <- sum(is.na(parsed)) - sum(is.na(x))
    if (failed > 0) {
        message(failed, " failed to parse.")
    }
    parsed
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
