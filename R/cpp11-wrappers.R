
cpp_force_tz <- function(dt, tz, roll) {
  # Catch rare integer POSIXct, retaining attributes
  storage.mode(dt) <- "double"

  roll <- as.logical(roll)

  # Must be a character vector, never `NULL`
  tz <- as.character(tz)

  ## C_force_tz(
  ##   dt = dt,
  ##   tz = tz,
  ##   roll = roll
  ## )

  timechange::time_force_tz(
    time = dt,
    tz = tz,
    roll_dst = if (roll) "boundary" else "NA"
  )

}

cpp_force_tzs <- function(dt, tzs, tz_out, roll) {
  # Catch rare integer POSIXct, retaining attributes
  storage.mode(dt) <- "double"

  # Must be a character vector, never `NULL`
  tzs <- as.character(tzs)
  tz_out <- as.character(tz_out)

  roll <- as.logical(roll)

  C_force_tzs(
    dt = dt,
    tzs = tzs,
    tz_out = tz_out,
    roll = roll
  )
}

cpp_local_time <- function(dt, tzs) {
  # Catch rare integer POSIXct, retaining attributes
  storage.mode(dt) <- "double"

  # Must be a character vector, never `NULL`
  tzs <- as.character(tzs)

  C_local_time(
    dt = dt,
    tzs = tzs
  )
}
