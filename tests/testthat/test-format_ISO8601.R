context("format_ISO8601")

test_that("Formatting a date works", {
  expect_equal(format_ISO8601(as.Date("02-01-2018", format="%m-%d-%Y")),
               "2018-02-01",
               info="Standard date formatting works")
  expect_equal(format_ISO8601(as.Date("02-01-2018", format="%m-%d-%Y"), usetz=TRUE),
               "2018-02-01",
               info="usetz is ignored with dates")
  expect_equal(format_ISO8601(as.Date("02-01-2018", format="%m-%d-%Y"), precision="y"),
               "2018",
               info="precision is respected (y)")
  expect_equal(format_ISO8601(as.Date("02-01-2018", format="%m-%d-%Y"), precision="ym"),
               "2018-02",
               info="precision is respected (ym)")
  expect_equal(format_ISO8601(as.Date("02-01-2018", format="%m-%d-%Y"), precision="ymd"),
               "2018-02-01",
               info="precision is respected (ymd)")
  expect_warning(
    expect_equal(format_ISO8601(as.Date("02-01-2018", format="%m-%d-%Y"), precision="ymdh"),
                 "2018-02-01",
                 info="precision is respected (ymdh)"),
    info="Requesting too much precision gives a warning and the maximum precision.")
})

test_that("Formatting a datetime works", {
  expect_equal(format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz="EST")),
               "2018-02-01T03:04:05",
               info="Standard datetime formatting works")
  expect_equal(format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz="EST"), usetz=TRUE),
               "2018-02-01T03:04:05-0500",
               info="usetz is respected with datetimes")
  expect_equal(format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz="EST"), precision="y"),
               "2018",
               info="precision is respected (y)")
  # Uncertain if this is the best result; including a test so that if it changes
  # the change is caught.
  expect_equal(format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz="EST"), precision="y", usetz=TRUE),
               "2018-0500",
               info="precision is respected (y) with timezone")
  expect_equal(format_ISO8601(as.POSIXct("2018-02-01 03:04:05", tz="EST"), precision="ymdhm"),
               "2018-02-01T03:04",
               info="precision is respected (ymdhm)")
})

test_that("Formatting a Duration works", {
  expect_equal(format_ISO8601(duration(20, units="seconds")),
               "PT20S",
               info="Standard duration formatting works")
  expect_equal(format_ISO8601(duration(20, units="minutes")),
               paste0("PT", 20*60,"S"),
               info="Duration always formats as seconds to ensure precision.")
  expect_warning(format_ISO8601(duration(20, units="minutes"), precision="y"),
                 regexp="precision is not used for Duration objects",
                 fixed=TRUE)
})

test_that("Formatting a Period works", {
  expect_equal(format_ISO8601(period(1, units="seconds")),
               "PT1S",
               info="A period of 1 second works")
  expect_equal(format_ISO8601(period(1, units="minute")),
               "PT1M",
               info="A period of 1 minute works")
  expect_equal(format_ISO8601(period(1, units="hour")),
               "PT1H",
               info="A period of 1 hour works")
  expect_equal(format_ISO8601(period(1, units="day")),
               "P1D",
               info="A period of 1 day works")
  expect_equal(format_ISO8601(period(1, units="month")),
               "P1M",
               info="A period of 1 month works")
  expect_equal(format_ISO8601(period(1, units="year")),
               "P1Y",
               info="A period of 1 year works")

  expect_equal(format_ISO8601(period(1, units="seconds") + period(1, units="year")),
               "P1YT1S",
               info="More than one unit works")

  expect_equal(format_ISO8601(period(0, units="seconds")),
               "PT0S",
               info="zero-length period (seconds specified)")

  expect_equal(format_ISO8601(period(0, units="year")),
               "PT0S",
               info="zero-length period (years specified)")
})

test_that("Formatting an Interval works", {
  expect_equal(format_ISO8601(interval(start="2018-02-01", end="2018-03-04")),
               "2018-02-01T00:00:00/2018-03-04T00:00:00",
               info="Standard interval formatting works")
  expect_equal(format_ISO8601(interval(start="2018-02-01", end="2018-03-04"), precision="ymd"),
               "2018-02-01/2018-03-04",
               info="interval formatting respects precision (ymd)")
  expect_equal(format_ISO8601(interval(start="2018-02-01", end="2018-03-04", tzone="EST"), usetz=TRUE),
               "2018-02-01T00:00:00-0500/2018-03-04T00:00:00-0500",
               info="interval formatting respects timezone")
})

test_that("formatting precision provides accurate format strings", {
  expect_equal(format_ISO8601_precision_check(precision="y", max_precision="ymd", usetz=FALSE),
               "%Y",
               info="simple formatting works")
  expect_equal(format_ISO8601_precision_check(precision="y", max_precision="ymd", usetz=TRUE),
               "%Y%z",
               info="timezone formatting works")
  expect_equal(format_ISO8601_precision_check(precision=NULL, max_precision="ymd", usetz=FALSE),
               "%Y-%m-%d",
               info="NULL yields max_precision")
  expect_error(format_ISO8601_precision_check(precision="foo", max_precision="ymd", usetz=FALSE),
               regexp="Invalid value for precision provided: foo",
               fixed=TRUE,
               info="invalid precision is an error")
  expect_error(format_ISO8601_precision_check(precision=NULL, max_precision="foo", usetz=FALSE),
               regexp="Invalid value for max_precision provided: foo",
               fixed=TRUE,
               info="invalid max_precision is an error")
  expect_error(format_ISO8601_precision_check(precision="ymd", max_precision="foo", usetz=FALSE),
               regexp="Invalid value for max_precision provided: foo",
               fixed=TRUE,
               info="invalid max_precision is an error (even if it's not used)")
  expect_error(format_ISO8601_precision_check(precision=c("ymd", "ymdh"), max_precision="ymdh", usetz=FALSE),
                 regexp="precision must be a scalar")
  expect_warning(
    expect_equal(format_ISO8601_precision_check(precision="ymdh", max_precision="ymd", usetz=FALSE),
                 "%Y-%m-%d",
                 info="max_precision is respected"),
    regexp="More precision requested (ymdh) than allowed (ymd) for this format.  Using maximum allowed precision.",
    fixed=TRUE,
    info="max_precision is warned")
})
