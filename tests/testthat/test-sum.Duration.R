test_that("`sum()` works for Durations", {

  x = lubridate::duration(1:2)
  expected = x[1] + x[2]
  expect_equal(expected, sum(x))
  expect_s4_class(sum(x), "Duration")

})
