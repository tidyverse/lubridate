context("difftimes")

test_that("is.difftime works as expected",{
  ct_time <- as.POSIXct("2008-08-03 13:01:59", tz = "UTC")
  lt_time <- as.POSIXlt("2009-08-03 13:01:59", tz = "UTC")
	
  expect_true(!is.difftime(234))
  expect_true(!is.difftime(ct_time))
  expect_true(!is.difftime(lt_time))
  expect_true(!is.difftime(Sys.Date()))
  expect_true(!is.difftime(minutes(1)))
  expect_true(!is.difftime(eminutes(1)))
  expect_true(!is.difftime(interval(ct_time, lt_time)))
  
  expect_true(is.difftime(new_difftime(1000)))
  expect_true(is.difftime(ct_time - lt_time))

})

test_that("is.difftime handle vectors",{
  expect_true(is.difftime(new_difftime(1:3)))
})
