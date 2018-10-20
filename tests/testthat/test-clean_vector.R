context( "clean.vector" )

test_that( "works as expected", {
  
  expect_equal(
    clean_vector( c( 'NA', 'Not NA'), verbose = FALSE ),
    c( NA, 'Not NA' )
  )
  
})