# Get the fiscal quarter and semester of a date-time

Quarters divide the year into fourths. Semesters divide the year into
halfs.

## Usage

``` r
quarter(
  x,
  type = "quarter",
  fiscal_start = 1,
  with_year = identical(type, "year.quarter")
)

semester(x, with_year = FALSE)
```

## Arguments

- x:

  a date-time object of class POSIXct, POSIXlt, Date, chron, yearmon,
  yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, fts or
  anything else that can be converted with as.POSIXlt

- type:

  the format to be returned for the quarter. Can be one one of
  "quarter" - return numeric quarter (default), "year.quarter" return
  the ending year and quarter as a number of the form year.quarter,
  "date_first" or "date_last" - return the date at the quarter's start
  or end, "year_start/end" - return a full description of the quarter as
  a string which includes the start and end of the year (ex. "2020/21
  Q1").

- fiscal_start:

  numeric indicating the starting month of a fiscal year.

- with_year:

  logical indicating whether or not to include the quarter or semester's
  year (deprecated; use the `type` parameter instead).

## Value

numeric or a vector of class POSIXct if `type` argument is `date_first`
or `date_last`. When `type` is `year.quarter` the year returned is the
end year of the financial year.

## Examples

``` r
x <- ymd(c("2012-03-26", "2012-05-04", "2012-09-23", "2012-12-31"))
quarter(x)
#> [1] 1 2 3 4
quarter(x, type = "year.quarter")
#> [1] 2012.1 2012.2 2012.3 2012.4
quarter(x, type = "year.quarter", fiscal_start = 11)
#> [1] 2012.2 2012.3 2012.4 2013.1
quarter(x, type = "date_first", fiscal_start = 11)
#> [1] "2012-02-01" "2012-05-01" "2012-08-01" "2012-11-01"
quarter(x, type = "date_last", fiscal_start = 11)
#> [1] "2012-04-30" "2012-07-31" "2012-10-31" "2013-01-31"
semester(x)
#> [1] 1 1 2 2
semester(x, with_year = TRUE)
#> [1] 2012.1 2012.1 2012.2 2012.2
```
