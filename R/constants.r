## various constants

N_DAYS_IN_MONTHS <- c(
    Jan = 31L, Feb = 28L, Mar = 31L, 
    Apr = 30L, May = 31L, Jun = 30L, 
    Jul = 31L, Aug = 31L, Sep = 30L, 
    Oct = 31L, Nov = 30L, Dec = 31L)

## lower bound included, upper excluded
N_DAYS_BETWEEN_MONTHS_LOWER <- matrix(0L, 12, 12)
for (i in 1:12)
  for (j in 1:12){
    N_DAYS_BETWEEN_MONTHS_LOWER[[i, j]] <-
      if (i < j) sum(N_DAYS_IN_MONTHS[i:(j - 1)])
      else if (j < i) sum(N_DAYS_IN_MONTHS[-(j:(i - 1))])
      else 0L
  }

## upper bound included, lower excluded
N_DAYS_BETWEEN_MONTHS_UPPER <- matrix(0L, 12, 12)
for (i in 1:12)
  for (j in 1:12){
    N_DAYS_BETWEEN_MONTHS_UPPER[[i, j]] <-
      if (i < j) sum(N_DAYS_IN_MONTHS[(i + 1):j])
      else if (j < i) sum(N_DAYS_IN_MONTHS[-((j + 1):i)])
      else 0L
  }


