context("iso-8601 parsing")

test_that("ymd_hms_z parses correctly ",{
  expect_that(ymd_hms_z("2012-03-04T05:06:07Z"), 
              equals(ymd_hms("2012-03-04 05:06:07", tz="UTC")))
})

test_that("ymd_hms_o parses correctly", {
  # +00:00
  expect_that(ymd_hms_o("2012-03-04T05:06:07+00:00"), 
              equals(ymd_hms("2012-03-04 05:06:07", tz="UTC")))
  # -HH
  expect_that(ymd_hms_o("2012-03-04T05:06:07-01"), 
              equals(ymd_hms("2012-03-04 06:06:07", tz="UTC")))
  # -HHMM
  expect_that(ymd_hms_o("2012-03-04T05:06:07-0130"), 
              equals(ymd_hms("2012-03-04 06:36:07", tz="UTC")))
  # -HH:MM
  expect_that(ymd_hms_o("2012-03-04T05:06:07-01:30"), 
              equals(ymd_hms("2012-03-04 06:36:07", tz="UTC")))
  # +HH
  expect_that(ymd_hms_o("2012-03-04T05:06:07+01"), 
              equals(ymd_hms("2012-03-04 04:06:07", tz="UTC")))
  # +HHMM
  expect_that(ymd_hms_o("2012-03-04T05:06:07+0130"), 
              equals(ymd_hms("2012-03-04 03:36:07", tz="UTC")))
  # +HH:MM
  expect_that(ymd_hms_o("2012-03-04T05:06:07+01:30"), 
              equals(ymd_hms("2012-03-04 03:36:07", tz="UTC")))
  # vectorizes
  expect_that(ymd_hms_o(c("2012-03-04T05:06:07+01", "2012-03-04T05:06:07+01:30")), 
              equals(ymd_hms(c("2012-03-04 04:06:07", "2012-03-04 03:36:07"), tz="UTC")))
  
})

test_that("helper_offset parses correctly", {
  expect_that(helper_offset(ymd_hms("2012-03-04T05:06:07", tz="Europe/Paris")), 
              equals("+01:00"))
  expect_that(helper_offset(ymd_hms("2012-03-04T05:06:07", tz="America/New_York")), 
              equals("-05:00"))
  expect_that(helper_offset(ymd_hms("2012-03-04T05:06:07", tz="America/New_York"), sep=":"), 
              equals("-05:00"))
  expect_that(helper_offset(ymd_hms("2012-03-04T05:06:07", tz="America/New_York"), sep=""), 
              equals("-0500"))
  # change through daylight-saving time change
  expect_that(helper_offset(ymd_hms("2012-03-11T01:00:00", tz="America/New_York"), sep=""), 
              equals("-0500"))
  expect_that(helper_offset(ymd_hms("2012-03-11T03:00:00", tz="America/New_York"), sep=""), 
              equals("-0400"))
  # change through daylight-saving time + vector
  expect_that(helper_offset(ymd_hms(c("2012-03-11T01:00:00", "2012-03-11T03:00:00"), 
                                    tz="America/New_York"), sep=""), 
              equals(c("-0500", "-0400")))  
})
