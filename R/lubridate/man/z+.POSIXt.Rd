\name{+.POSIXt}
\Rdversion{1.1}
\alias{+.POSIXt}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
+.POSIXt(e1, e2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{e1}{
%%     ~~Describe \code{e1} here~~
}
  \item{e2}{
%%     ~~Describe \code{e2} here~~
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
function (e1, e2) 
{
    n1 <- get_length(e1)
    n2 <- get_length(e2)
    if (n1 < n2) 
        e1 <- expand(e1, n1, n2)
    else if (n1 > n2) 
        e2 <- expand(e2, n2, n1)
    if (!is.POSIXt(e1) && is.duration(e2)) 
        e1 <- as.duration(e1)
    if (!is.POSIXt(e2) && is.duration(e1)) 
        e2 <- as.duration(e2)
    if (is.duration(e1) && is.duration(e2)) 
        add_duration_to_duration(e1, e2)
    else if (is.duration(e1) && is.POSIXt(e2)) 
        add_duration_to_date(e2, e1)
    else if (is.duration(e2) && is.POSIXt(e1)) 
        add_duration_to_date(e1, e2)
    else if (is.POSIXt(e1) && is.POSIXt(e2)) 
        stop("binary '+' is not defined for \"POSIXt\" objects")
    else if (is.POSIXt(e1) || is.POSIXt(e2)) 
        base::"+.POSIXt"(e1, e2)
    else if (is.difftime(e1) && is.difftime(e2)) 
        make_difftime(as.duration(e1) + as.duration(e2))
    else if (is.difftime(e1)) {
        e2 <- structure(e2, units = units(e1), class = "difftime")
        make_difftime(as.duration(e1) + e2)
    }
    else if (is.difftime(e2)) {
        e1 <- structure(e1, units = units(e2), class = "difftime")
        make_difftime(as.duration(e2) + e1)
    }
    else base::"+"(e1, e2)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
