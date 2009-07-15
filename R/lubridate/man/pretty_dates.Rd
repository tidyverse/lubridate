\name{pretty_dates}
\Rdversion{1.1}
\alias{pretty_dates}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
pretty_dates(dates, n = 5, by = c("auto", "secs", "mins", "hours", "days", "weeks", "months", "years"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dates}{
%%     ~~Describe \code{dates} here~~
}
  \item{n}{
%%     ~~Describe \code{n} here~~
}
  \item{by}{
%%     ~~Describe \code{by} here~~
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
function (dates, n = 5, by = c("auto", "secs", "mins", "hours", 
    "days", "weeks", "months", "years")) 
{
    if (!is.POSIXt(dates)) 
        stop("x must be a POSIXt object")
    if (length(dates) == 0L) 
        return(dates)
    by <- match.arg(by)
    switch(by, secs = pretty_secs(dates, n), mins = pretty_mins(dates, 
        n), hours = pretty_hours(dates, n), days = pretty_days(dates, 
        n), weeks = pretty_weeks(dates, n), months = pretty_months(dates, 
        n), years = pretty_years(dates, n))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
