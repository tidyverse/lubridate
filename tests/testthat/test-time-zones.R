test_that("with_tz works as expected", {
  x_ct <- as.POSIXct("2008-08-03 10:01:59", tz = "America/New_York")
  y_ct <- as.POSIXct("2008-08-03 14:01:59", tz = "UTC")

  expect_equal(with_tz(x_ct, "UTC"), y_ct)
  expect_s3_class(with_tz(x_ct, "UTC"), "POSIXct")

  x_lt <- as.POSIXlt("2008-08-03 10:01:59", tz = "America/New_York")
  y_lt <- as.POSIXlt("2008-08-03 14:01:59", tz = "UTC")

  expect_equal(with_tz(x_lt, "UTC"), y_lt)
  expect_equal(as.POSIXct(with_tz(y_lt, "America/New_York")), x_ct)
  expect_equal(x_ct, as.POSIXct(with_tz(y_lt, "America/New_York")))
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
  expect_equal(df$x, x_out)
  expect_equal(df$y, x_out)
})


test_that("force_tzs works as expected", {
  x <- ymd_hms(c("2009-08-07 00:00:01", "2009-08-07 00:00:01"))
  expect_equal(
    force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam")),
    ymd_hms("2009-08-07 04:00:01 UTC", "2009-08-06 22:00:01 UTC")
  )
  expect_equal(
    force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"), tzone_out = "America/New_York"),
    ymd_hms("2009-08-07 00:00:01 EDT", "2009-08-06 18:00:01 EDT", tz = "America/New_York")
  )
  ## recycling
  expect_equal(
    force_tzs(x, tzones = "America/New_York", tzone_out = "UTC"),
    ymd_hms("2009-08-07 04:00:01 UTC", "2009-08-07 04:00:01 UTC")
  )
  x <- ymd_hms("2009-08-07 00:00:01")
  expect_equal(
    force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam")),
    ymd_hms("2009-08-07 04:00:01 UTC", "2009-08-06 22:00:01 UTC")
  )
  expect_equal(
    force_tzs(x, tzones = c("America/New_York", "Europe/Amsterdam"), tzone_out = "America/New_York"),
    ymd_hms("2009-08-07 00:00:01 EDT", "2009-08-06 18:00:01 EDT", tz = "America/New_York")
  )
})

test_that("force_tzs is robusts against overflow", {
  x <- ymd_hms(c(
    "2038-01-19 03:14:06", "2038-01-19 03:14:07", "2038-01-19 03:14:08",
    "2038-01-19 03:14:09", "2038-01-19 03:14:10"
  ))
  expect_equal(
    force_tzs(x, tzones = "America/New_York"),
    with_tz(
      ymd_hms(c(
        "2038-01-19 03:14:06", "2038-01-19 03:14:07", "2038-01-19 03:14:08",
        "2038-01-19 03:14:09", "2038-01-19 03:14:10"
      ),
      tz = "America/New_York"
      ),
      "UTC"
    )
  )
})

test_that("force_tz doesn't return NA just because new time zone uses DST", {
  poslt <- as.POSIXlt("2009-03-14 02:59:59",
    tz = "UTC", format
    = "%Y-%m-%d %H:%M:%S"
  )
  poslt2 <- force_tz(poslt, tzone = "America/New_York")

  expect_true(!is.na(poslt2))
})

test_that("force_tz works within repeated DST", {
  ## "2014-11-02 00:00:00 CST"
  ch <- ymd_hms("2014-11-02 00:00:00", tz = "America/Chicago")
  eu <- ymd_hms("2014-11-02 00:00:00", tz = "Europe/Berlin")

  expect_equal(
    force_tz(eu + dminutes(95), "America/Chicago", roll_dst = "pre"),
    ch + dminutes(95))
  expect_equal(
    force_tz(eu + dminutes(95), "America/Chicago", roll_dst = "post"),
    ch + dminutes(155))
  expect_equal(
    force_tz(eu + dminutes(95), "America/Chicago", roll_dst = "boundary"),
    ch + dminutes(120))

  expect_equal(
    force_tz(eu + dminutes(95), "America/Chicago", roll_dst = "post"),
    ch + dminutes(155))
  expect_equal(
    force_tz(eu + dminutes(95), "America/Chicago", roll_dst = "pre"),
    ch + dminutes(95))
  expect_equal(
    force_tz(eu + dminutes(95), "America/Chicago", roll_dst = "boundary"),
    ch + dminutes(120))

  expect_equal(
    force_tz(ch + dminutes(95), "Europe/Berlin", roll_dst = "post"),
    eu + dminutes(95))
  expect_equal(
    force_tz(ch + dminutes(95), "Europe/Berlin", roll_dst = "pre"),
    eu + dminutes(95))
  expect_equal(
    force_tz(ch + dminutes(95), "Europe/Berlin", roll_dst = "boundary"),
    eu + dminutes(95))

  ## default roll_dst is "post"
  expect_equal(
    force_tz(eu + dminutes(95), "America/Chicago"),
    ch + dminutes(155))
  expect_equal(
    force_tz(ch + dminutes(95), "Europe/Berlin"),
    eu + dminutes(95))
  expect_equal(
    force_tz(ch + dminutes(155), "Europe/Berlin"),
    eu + dminutes(95))

})

# local_time --------------------------------------------------------------

test_that("local_time works as expected", {
  x <- ymd_hms(c("2009-08-07 01:02:03", "2009-08-07 10:20:30"))
  expect_equal(
    local_time(x, units = "secs"),
    as.difftime(c(3723, 37230), units = "secs")
  )
  expect_equal(
    local_time(x, units = "hours"),
    as.difftime(c(3723, 37230) / 3600, units = "hours")
  )
  expect_equal(
    local_time(x, "Europe/Amsterdam"),
    local_time(with_tz(x, "Europe/Amsterdam"))
  )

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


test_that("If original post/pre is known, ignore roll_DST", {

  tt <- ymd_hms("2014-11-02 01:35:00")
  chpst <- force_tz(tt, "America/Chicago", roll_dst = "post")
  chpdt <- force_tz(tt, "America/Chicago", roll_dst = "pre")
  lapst <- force_tz(tt, "America/Los_Angeles", roll_dst = "post")
  lapdt <- force_tz(tt, "America/Los_Angeles", roll_dst = "pre")

  expect_equal(lapst, force_tz(chpst, "America/Los_Angeles", roll_dst = "pre"))
  expect_equal(lapst, force_tz(chpst, "America/Los_Angeles", roll_dst = "post"))
  expect_equal(lapst, force_tz(chpst, "America/Los_Angeles", roll_dst = "boundary"))

  expect_equal(lapdt, force_tz(chpdt, "America/Los_Angeles", roll_dst = "pre"))
  expect_equal(lapdt, force_tz(chpdt, "America/Los_Angeles", roll_dst = "post"))
  expect_equal(lapdt, force_tz(chpdt, "America/Los_Angeles", roll_dst = "boundary"))

  expect_equal(lapst, force_tzs(chpst, "America/Los_Angeles", "America/Los_Angeles", roll_dst = "pre"))
  expect_equal(lapst, force_tzs(chpst, "America/Los_Angeles", "America/Los_Angeles", roll_dst = "post"))
  expect_equal(lapst, force_tzs(chpst, "America/Los_Angeles", "America/Los_Angeles", roll_dst = "boundary"))
  expect_equal(lapst, force_tzs(chpst, "America/Los_Angeles", "America/Los_Angeles", roll_dst = "pre"))
  expect_equal(lapst, force_tzs(chpst, "America/Los_Angeles", "America/Los_Angeles", roll_dst = "post"))
  expect_equal(lapst, force_tzs(chpst, "America/Los_Angeles", "America/Los_Angeles", roll_dst = "boundary"))

  expect_equal(with_tz(c(tt, chpdt, lapdt), "America/Chicago"),
    force_tzs(tt,  #c(tt, chpdt, lapdt),
      c("UTC", "America/Chicago", "America/Los_Angeles"),
      tzone_out = "America/Chicago",
      roll_dst = "pre"))

  expect_equal(with_tz(c(tt, chpst, lapst), "America/Chicago"),
    force_tzs(tt,  #c(tt, chpdt, lapdt),
      c("UTC", "America/Chicago", "America/Los_Angeles"),
      tzone_out = "America/Chicago",
      roll_dst = "post"))

  expect_equal(with_tz(c(tt, chpdt, lapdt), "America/Chicago"),
    force_tzs(chpdt,
      c("UTC", "America/Chicago", "America/Los_Angeles"),
      tzone_out = "America/Chicago",
      roll_dst = "pre"))

  expect_equal(with_tz(c(tt, chpdt, lapdt), "America/Chicago"),
    force_tzs(chpdt,
      c("UTC", "America/Chicago", "America/Los_Angeles"),
      tzone_out = "America/Chicago",
      roll_dst = "post"))

  expect_equal(with_tz(c(tt, chpst, lapst), "America/Chicago"),
    force_tzs(chpst,
      c("UTC", "America/Chicago", "America/Los_Angeles"),
      tzone_out = "America/Chicago",
      roll_dst = "post"))

  expect_equal(with_tz(c(tt, chpst + 100, chpst + 3600), "America/Chicago"),
    force_tzs(with_tz(c(chpst, chpst + 100, chpdt), "America/Chicago"),
      c("UTC", "America/Chicago", "America/Los_Angeles"),
      tzone_out = "America/Chicago",
      roll_dst = "post"))
})


test_that("as_datetime does not loose time zone", {
  ## #1085
  x <- ymd_hms("2022-01-01 23:40:36", tz = "US/Pacific")
  expect_identical(x, as_datetime(x))
  expect_identical(with_tz(x, "Europe/Amsterdam"), as_datetime(x, tz = "Europe/Amsterdam"))
  x <- as.POSIXlt(x)
  expect_identical(x, as_datetime(x))
  expect_identical(with_tz(x, "Europe/Amsterdam"), as_datetime(x, tz = "Europe/Amsterdam"))
})

test_that("as_datetime parsers with exact formats", {
  ## #1097
  expect_equal(
    as_datetime("blabla2022-xyz01-03", format = "blabla%Y-xyz%m-%d"),
    ymd("2022-01-03", tz = "UTC"))
  expect_equal(
    as_datetime(c("2022-01-01", "blabla2022-xyz01-03"), format = c("%Y-%m-%d", "blabla%Y-xyz%m-%d")),
    ymd(c("2022-01-01", "2022-01-03"), tz = "UTC"))
})
