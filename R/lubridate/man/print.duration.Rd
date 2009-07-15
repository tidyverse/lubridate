\name{print.duration}
\Rdversion{1.1}
\alias{print.duration}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
print.duration(x, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
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
function (x, ...) 
{
    duration <- vector(mode = "character")
    if (x$months >= 0 | is.na(x$months)) {
        year <- x$months\%/\%12
        month <- x$months\%\%12
    }
    else {
        year <- -(-x$months\%/\%12)
        month <- -(-x$months\%\%12)
    }
    if (x$seconds >= 0 | is.na(x$seconds)) {
        week <- (x$seconds\%/\%604800)
        day <- (x$seconds - week * 604800)\%/\%86400
        hour <- (x$seconds - week * 604800 - day * 86400)\%/\%3600
        minute <- (x$seconds - week * 604800 - day * 86400 - 
            hour * 3600)\%/\%60
        second <- x$seconds - week * 604800 - day * 86400 - hour * 
            3600 - minute * 60
    }
    else {
        week <- -(-x$seconds\%/\%604800)
        day <- -(-(x$seconds - week * 604800)\%/\%86400)
        hour <- -(-(x$seconds - week * 604800 - day * 86400)\%/\%3600)
        minute <- -(-(x$seconds - week * 604800 - day * 86400 - 
            hour * 3600)\%/\%60)
        second <- x$seconds - week * 604800 - day * 86400 - hour * 
            3600 - minute * 60
    }
    duration <- c(write_out(year), write_out(month), write_out(week), 
        write_out(day), write_out(hour), write_out(minute), write_out(second))
    if (length(duration) > 1) 
        cat(cat(duration[1:length(duration) - 1], sep = ", "), 
            "and", duration[length(duration)], "\n")
    else if (length(duration) == 0) 
        cat("0 seconds", "\n")
    else cat(duration, "\n")
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
