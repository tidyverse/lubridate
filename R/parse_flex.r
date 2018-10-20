##' Flexible parse for common date types, including Excel numeric dates.
##' 
##' By default, returns vector unchanged if new NAs would be created. 
##' You can send non-dates in loops (or otherwise) and they won't be affected. Can be useful for checking if something is a date.
##'
##' @param x Vector to convert.
##' @param do.time Allow processing to time values.
##' @param do.excel Allow conversion of excel date integers.
##' @param already.clean.vector Sometimes in multi-step data operations clean.vector will have already been called.
##' @param verbose Print useful information via cat.
##' @param do.na What to do in case new NAs are created during conversion. If all NAs, the vector will be returned unchanged. Otherwise, this argument determines behavior: return-unchnaged returns the vector unchanged. warning returns new NAs with a warning. stop throws an error. return-na prints a message with cat which can be turned off with verbose = FALSE.
##' @param min.acceptable.date Set to NULL to ignore. Sometimes numbers are assumed to be excel-formatted. One way to prevent this is to set min/max acceptable dates to help the conversion know if something is a meaningful data or not.
##' @param max.acceptable.date Set to NULL to ignore. Sometimes numbers are assumed to be excel-formatted. One way to prevent this is to set min/max acceptable dates to help the conversion know if something is a meaningful data or not.
##'
##' @return Processed vector.
##' @export
##'
##' @examples
##' 
##' todate( c( '12/3/14', 'Hello'), do.na = 'return-na' )
##' todate( c( '12/3/14', 'Hello') )
##' todate( c( "2018-10-20", "2018-10-20", "2018-10-20", "2018-10-20" ), verbose = FALSE )
##' todate( c( "6/12/2015 20:45:00", "4/4/2015 22:20:00" , "4/11/2016 23:24:00", "9/29/2016 1:10:00" ), do.time = TRUE )
##' todate( 43393.5138888889, do.time = TRUE ) # this is 2018-10-20 12:20:00 in Excel.
##' 
parse_flex = function( 
  x,
  do.time = FALSE,
  do.excel = TRUE,
  na.vals = lubridate::na_strings,
  already.clean.vector = FALSE,
  verbose = TRUE,
  do.na = c( 'return-unchanged', 'warning', 'stop', 'return-na' ),
  min.acceptable.date = '1-1-1900', 
  max.acceptable.date = '12-31-2100'
){
  
  if( lubridate::is.Date(x) || lubridate::is.POSIXt(x) ) return(x)
  
  if( !is.null( ncol(x) ) ) stop( 'todate only accepts vector arguments. Error E807 todate.' )
  do.na  = match.arg(do.na)
  
  orig.x = x
  
  if( !is.null(min.acceptable.date) ) min.acceptable.date = lubridate::parse_date_time( min.acceptable.date, c( 'mdy', 'ymd', 'dmy' ) )
  if( !is.null(max.acceptable.date) ) max.acceptable.date = lubridate::parse_date_time( max.acceptable.date, c( 'mdy', 'ymd', 'dmy' ) )
  
  if( ! already.clean.vector ) x = lubridate::clean.vector( x, verbose = verbose, na.vals = na.vals )
  
  # Attempt date-time conversion.
  
  try.formats = c( 
    'mdy IM p', 'ymd IM p', 'dmy IM p', 
    'mdy IMS p', 'ymd IMS p', 'dmy IMS p', 
    'mdy HM', 'ymd HM', 'dmy HM',
    'mdy HMS', 'ymd HMS', 'dmy HMS'  
  )
  
  convert.attempt.time = suppressWarnings( lubridate::parse_date_time( x, try.formats ) )
  if( ! do.time ) convert.attempt.time = as.Date( convert.attempt.time )
  
  if( !is.null(min.acceptable.date) ) convert.attempt.time[ which( convert.attempt.time < min.acceptable.date ) ] <- NA
  if( !is.null(max.acceptable.date) ) convert.attempt.time[ which( convert.attempt.time > max.acceptable.date ) ] <- NA
  
  # If no new NAs were created, return the data.
  if( ! any( is.na(convert.attempt.time) & ! is.na(x) ) ) return( convert.attempt.time )
  
  # Attempt date conversion.
  
  try.formats = c( 'mdy', 'ymd', 'dmy' )
  convert.attempt.date = suppressWarnings( lubridate::parse_date_time( x, try.formats ) )
  if( ! do.time ) convert.attempt.date = as.Date( convert.attempt.date )
  
  if( !is.null(min.acceptable.date) ) convert.attempt.date[ which( convert.attempt.date < min.acceptable.date ) ] <- NA
  if( !is.null(max.acceptable.date) ) convert.attempt.date[ which( convert.attempt.date > max.acceptable.date ) ] <- NA
  
  # If no new NAs were created, return the data.
  if( ! any( is.na(convert.attempt.date) & ! is.na(x) ) ) return( convert.attempt.date )
  
  # Attempt excel date conversion.
  
  if( do.excel ){
    
    # Excel requires numeric input.
    attempt.numeric = suppressWarnings( as.numeric(x) )
    if( !lubridate::is.POSIXct(x) && !lubridate::is.Date(x) && !any( is.na(attempt.numeric) & !is.na(x) ) ){
      
      convert.attempt.xl = as.POSIXct( x * 24 * 60 * 60, origin = '1899-12-30', tz = 'UTC' )
      if( ! do.time ) convert.attempt.xl = as.Date( convert.attempt.xl )
      
      if( !is.null(min.acceptable.date) ) convert.attempt.xl[ which( convert.attempt.xl < min.acceptable.date ) ] <- NA
      if( !is.null(max.acceptable.date) ) convert.attempt.xl[ which( convert.attempt.xl > max.acceptable.date ) ] <- NA
      
      # If no new NAs were created, return the data.
      if( ! any( is.na(convert.attempt.xl) & ! is.na(x) ) ) return( convert.attempt.xl )
      
    } else { do.excel = FALSE }
    
  }
  
  if( ! do.excel ){
    convert.attempt.xl = as.POSIXct( rep( NA, length(x) ), origin = '1899-12-30' )
    if( ! do.time ) convert.attempt.xl = as.Date( convert.attempt.xl )
  }
  
  # Combine convert attempts.
  
  all.attempts = dplyr::coalesce( convert.attempt.time, convert.attempt.date, convert.attempt.xl )
  rm( convert.attempt.time, convert.attempt.date, convert.attempt.xl )
  
  # If convert attempts are all NA, return original x.
  if( all( is.na( x ) ) ) return( orig.x )
  
  # If no new NAs, return x.
  if( ! any( is.na(all.attempts) & ! is.na(x) ) ) return( all.attempts )
  
  # Otherwise, some dates weren't converted. Choose what to do.
  
  not.converted = which( !is.na(x) & is.na(all.attempts) )
    num.not.converted = length(not.converted)
    not.converted = unique( orig.x[ not.converted ] )
    
    if( do.na == 'return-unchanged' ){
      
      if( verbose) cat( 
        'todate:: Returned unchanged vector due to [', num.not.converted, '] invalid date values including [', 
        cc( head( not.converted, 5 ), sep = ', ' ), ']. \n'
      )
      return(orig.x)
      
    } else if( do.na == 'warning' ){
      
      warning( 
        'todate:: Returned vector with [', num.not.converted, '] new NAs due to invalid date values including [', 
        cc( head( not.converted, 5 ), sep = ', ' ), ']. \n'
      )
      return(all.attempts)
      
    } else if( do.na == 'stop' ){
      
      stop( 
        'todate:: [', num.not.converted, '] new NAs due to invalid date values including [', 
        cc( head( not.converted, 5 ), sep = ', ' ), ']. \n'
      )
      
    } else if( do.na == 'return-na' ){
      
      if( verbose) cat( 
        'todate:: Returned vector with [', num.not.converted, '] new NAs due to invalid date values including [', 
        cc( head( not.converted, 5 ), sep = ', ' ), ']. \n'
      )
      return(all.attempts)
      
    } else { 
    
      stop( 'Unhandled new NAs. Error E845 todate' )
        
    }
  
}