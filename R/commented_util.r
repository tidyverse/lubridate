# A year is a leap year if it is evenly divisible by 400 or evenly 
# divisible by 4 but not 100.

leap.year <- function(year) {
  (year %% 4 == 0) & ((year %% 100 != 0) | (year %% 400 == 0))
}

