cpp_update_dt <- function(dt,
                          year,
                          month,
                          yday,
                          mday,
                          wday,
                          hour,
                          minute,
                          second,
                          tz,
                          roll,
                          week_start) {
  # Catch rare integer POSIXct, retaining attributes
  storage.mode(dt) <- "double"

  year <- as.integer(year)
  month <- as.integer(month)
  yday <- as.integer(yday)
  mday <- as.integer(mday)
  wday <- as.integer(wday)
  hour <- as.integer(hour)
  minute <- as.integer(minute)

  second <- as.double(second)

  roll <- as.logical(roll)
  week_start <- as.integer(week_start)

  C_update_dt(
    dt = dt,
    year = year,
    month = month,
    yday = yday,
    mday = mday,
    wday = wday,
    hour = hour,
    minute = minute,
    second = second,
    tz = tz,
    roll = roll,
    week_start = week_start
  )
}
