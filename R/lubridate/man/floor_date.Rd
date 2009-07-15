\name{floor_date}
\Rdversion{1.1}
\alias{floor_date}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
floor_date(x, unit = c("second", "minute", "hour", "day", "week", "month", "year"), eps = 1e-10)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{unit}{
%%     ~~Describe \code{unit} here~~
}
  \item{eps}{
%%     ~~Describe \code{eps} here~~
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
function (x, unit = c("second", "minute", "hour", "day", "week", 
    "month", "year"), eps = 1e-10) 
{
    unit <- match.arg(unit)
    if (unit != "second") 
        second(x) <- second(x) - eps
    switch(unit, second = update(x, second = floor(second(x))), 
        minute = update(x, second = 0), hour = update(x, minute = 0, 
            second = 0), day = update(x, hour = 0, minute = 0, 
            second = 0), week = update(x, wday = 1, hour = 0, 
            minute = 0, second = 0), month = update(x, mday = 1, 
            hour = 0, minute = 0, second = 0), year = update(x, 
            yday = 1, hour = 0, minute = 0, second = 0))
    x
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
