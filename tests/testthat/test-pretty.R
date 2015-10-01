context("Pretty formatting of dates")

test_that("pretty_dates works for years",
{
  ## https://github.com/hadley/lubridate/issues/227
  expect_equal(pretty_dates(c(as.Date("1993-12-05"), as.Date("2007-12-01")), 7),
               ymd(c("1993-01-01 UTC", "1995-01-01 UTC", "1997-01-01 UTC",
                     "1999-01-01 UTC", "2001-01-01 UTC", "2003-01-01 UTC",
                     "2005-01-01 UTC", "2007-01-01 UTC")))  
})
