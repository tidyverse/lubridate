\name{make_difftime}
\Rdversion{1.1}
\alias{make_difftime}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
make_difftime(dur)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dur}{
%%     ~~Describe \code{dur} here~~
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
function (dur) 
{
    if (dur$months != 0) 
        stop("difftime does not support non-uniform durations (months)")
    if (dur$seconds >= 0) 
        seconds <- dur$seconds
    else seconds <- -dur$seconds
    if (seconds < 60) 
        units <- "secs"
    else if (seconds < 3600) 
        units <- "mins"
    else if (seconds < 86400) 
        units <- "hours"
    else units <- "days"
    switch(units, secs = structure(dur$seconds, units = "secs", 
        class = "difftime"), mins = structure(dur$seconds/60, 
        units = "mins", class = "difftime"), hours = structure(dur$seconds/3600, 
        units = "hours", class = "difftime"), days = structure(dur$seconds/86400, 
        units = "days", class = "difftime"), weeks = structure(dur$seconds/(7 * 
        86400), units = "weeks", class = "difftime"))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
