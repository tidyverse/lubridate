\name{parse_unit_spec}
\Rdversion{1.1}
\alias{parse_unit_spec}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
parse_unit_spec(unitspec)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{unitspec}{
%%     ~~Describe \code{unitspec} here~~
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
function (unitspec) 
{
    parts <- strsplit(unitspec, " ")[[1]]
    if (length(parts) == 1) {
        mult <- 1
        unit <- unitspec
    }
    else {
        mult <- as.numeric(parts[[1]])
        unit <- parts[[2]]
    }
    unit <- gsub("s$", "", unit)
    unit <- match.arg(unit, c("second", "minute", "hour", "day", 
        "week", "month", "year"))
    list(unit = unit, mult = mult)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
