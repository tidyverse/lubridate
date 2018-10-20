##' Clean a Vector
##' 
##' Remove NA values and trims edge white-space.
##'
##' @param x Vector to clean.
##' @param na.vals Values to consider NA.
##' @param verbose Print informative output via cat.
##'
##' @return Cleaned vector.
##' @export
##'
##' @examples
##' clean.vector( c( 'NA', 'Not NA') )
##'
clean_vector = function(
  x, 
  na.vals = lubridate::na_strings, 
  verbose = TRUE 
){
  
  # Handle NA strings.
  
    to.na = which( as.character(x) %in% as.character( na.vals ) )
    num.tona = length(to.na)
    rm(na.vals)
    
    if( num.tona > 0 ){
      na.vals = unique( x[ to.na ] )
      x[ to.na ] <- NA    
      if( verbose ) cat( 'Removed [', num.tona, '] NA strings: [', cc( na.vals, sep = ', ' ), ']. \n')
    }
    
  # Handle character data.
    
    if( is.character(x) ){
      x = stringr::str_trim(x)
    }
    
  return(x)
  
}