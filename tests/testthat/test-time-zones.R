context("Time zones")

test_that("with_tz works as expected", {
  x_ct <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  y_ct <- as.POSIXct("2008-08-03 14:01:59", tz = "UTC")

  expect_equal(with_tz(x_ct, "UTC"), y_ct)
  expect_s3_class(with_tz(x_ct, "UTC"), "POSIXct")

  x_lt <- as.POSIXlt(x_ct)
  y_lt <- as.POSIXlt(y_ct)

  expect_equal(with_tz(y_lt, "UTC"), y_lt)
  expect_s3_class(with_tz(y_lt, "UTC"), "POSIXlt")
})

test_that("with_tz handles data.frames", {
  x <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  df <- data.frame(x = x, y = as.POSIXlt(x), z = "blabla")
  df <- with_tz(df, "UTC")
  x_out <- as.POSIXct(format(as.POSIXct(x), tz = "UTC"), tz = "UTC")
  expect_equal(df$x, x_out)
  expect_equal(df$y, x_out)
})

test_that("with_tz throws warning on unrecognized time zones", {
  t <- now()
  expect_warning(with_tz(t, "blablabla"))
  expect_silent(with_tz(t, "UTC"))
  expect_silent(with_tz(t, ""))
  expect_silent(with_tz(t, "America/New_York"))
})

# force_tz ----------------------------------------------------------------

test_that("force_tz works as expected", {
  x_ct <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  y_ct <- as.POSIXct("2008-08-03 10:01:59", tz = "UTC")

  expect_equal(force_tz(x_ct, "UTC"), y_ct)
  expect_s3_class(force_tz(x_ct, "UTC"), "POSIXct")

  x_lt <- as.POSIXlt(x_ct)
  y_lt <- as.POSIXlt(y_ct)

  expect_equal(force_tz(y_lt, "UTC"), y_lt)
  expect_s3_class(force_tz(y_lt, "UTC"), "POSIXlt")
})

test_that("force_tz handles data.frames", {
  x <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  x_out <- as.POSIXct(format(as.POSIXct(x)), tz = "UTC")
  df <- data.frame(x = x, y = as.POSIXlt(x), z = "blabla")
  df <- force_tz(df, "UTC")
  expect_that(df$x, equals(x_out))
  expect_that(df$y, equals(x_out))
})


test_that("force_tzs works as expected", {
  x <- ymd_hms(c("2009-08-07 00:00:01", "2009-08-07 00:00:01"))
  expect_equal(force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam")),
               ymd_hms("2009-08-07 04:00:01 UTC", "2009-08-06 22:00:01 UTC"))
  expect_equal(force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"), tzone_out = "America/New_York"),
               ymd_hms("2009-08-07 00:00:01 EDT", "2009-08-06 18:00:01 EDT", tz = "America/New_York"))
  ## recycling
  expect_equal(force_tzs(x, tzones = "America/New_York", tzone_out = "UTC"),
               ymd_hms("2009-08-07 04:00:01 UTC", "2009-08-07 04:00:01 UTC"))
  x <- ymd_hms("2009-08-07 00:00:01")
  expect_equal(force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam")),
               ymd_hms("2009-08-07 04:00:01 UTC", "2009-08-06 22:00:01 UTC"))
  expect_equal(force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"), tzone_out = "America/New_York"),
               ymd_hms("2009-08-07 00:00:01 EDT", "2009-08-06 18:00:01 EDT", tz = "America/New_York"))
})

test_that("force_tzs is robusts against overflow", {
  x <- ymd_hms(c("2038-01-19 03:14:06", "2038-01-19 03:14:07", "2038-01-19 03:14:08",
                 "2038-01-19 03:14:09", "2038-01-19 03:14:10"))
  expect_equal(force_tzs(x, tzones = "America/New_York"),
               with_tz(ymd_hms(c("2038-01-19 03:14:06", "2038-01-19 03:14:07", "2038-01-19 03:14:08",
                                 "2038-01-19 03:14:09", "2038-01-19 03:14:10"),
                               tz = "America/New_York"),
                       "UTC"))
})

test_that("force_tz doesn't return NA just because new time zone uses DST", {
  poslt <- as.POSIXlt("2009-03-14 02:59:59", tz = "UTC", format
                      = "%Y-%m-%d %H:%M:%S")
  poslt2 <- force_tz(poslt, tzone = "America/New_York")

  expect_true(!is.na(poslt2))
})

# local_time --------------------------------------------------------------

test_that("local_time works as expected", {
  x <- ymd_hms(c("2009-08-07 01:02:03", "2009-08-07 10:20:30"))
  expect_equal(local_time(x, units = "secs"),
               as.difftime(c(3723, 37230), units = "secs"))
  expect_equal(local_time(x, units = "hours"),
               as.difftime(c(3723, 37230)/3600, units = "hours"))
  expect_equal(local_time(x, "Europe/Amsterdam"),
               local_time(with_tz(x, "Europe/Amsterdam")))

  x1 <- ymd_hms("2009-08-07 01:02:03")
  x2 <- local_time(x1, c("America/New_York", "Europe/Amsterdam", "Asia/Shanghai"))

  expect_equal(x2[1], local_time(with_tz(x1, "America/New_York")))
  expect_equal(x2[2], local_time(with_tz(x1, "Europe/Amsterdam")))
  expect_equal(x2[3], local_time(with_tz(x1, "Asia/Shanghai")))
})

# tz --------------------------------------------------------------------

test_that("tz() returns UTC on special objects", {
  expect_equal(tz(NA), "UTC")
  expect_equal(tz("character"), "UTC")
  expect_equal(tz(today()), "UTC")
  expect_equal(tz(POSIXct()), "UTC")
  expect_equal(tz(Date()), "UTC")
})
