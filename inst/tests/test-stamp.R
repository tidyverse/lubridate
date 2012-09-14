

## y <- c('February 20th 1973',
##        "february  14, 2004",
##        "Sunday, May 1, 2000",
##        "Sunday, May012000",
##        "february  14, 04",       
##        'Feb 20th 73',
##        "January 5 1999 at 7pm",
##        "jan 3 2010",
##        "Jan 1, 1999", 
##        "jan 3   10",
##        "01 3 2010",
##        "1 3 10",
##        '1 13 89',
##        "5/27/1979", 
##        "12/31/99", 
##        "DOB:12/11/00", 
##        'Thu, 1 July 2004 22:30:00',
##        'Thu, 1st of July 2004 at 22:30:00',
##        'Thu, 1July 2004 at 22:30:00',
##        'Thu, 1July2004 22:30:00',
##        "21 Aug 2011, 11:15:34 pm", 
##        "1979-05-27 05:00:59",
##        "1979-05-27", 
##        "3 jan 2000", 
##        "17 april 85", 
##        "27/5/1979", 
##        '20 01 89', 
##        '00/13/10',
##        "14 12 00",
##        "03:23:22 pm")
## cbind(y, unlist(lapply(y, function(x) stamp(x)(D))))



test_that("stamp selects the correct format",{
          
  test_dates <- read.table( header = T, stringsAsFactors=F,
                                   textConnection("
      date                              expected                                                                     
'February 20th 1973'                'August 13th 2012'                    
'february  14, 2004'                'August  13, 2012'                    
'Sunday, May 1, 2000'               'Monday, Aug 13, 2012'                
'Sunday, May 1, 2000'               'Monday, Aug 13, 2012'                
'february  14, 04'                  'August  13, 12'                      
'Feb 20th 73'                       'Aug 13th 12'                         
'January 5 1999 at 7pm'             'August 13 2012 at 11AM'              
'jan 3 2010'                        'Aug 13 2012'                         
'Jan 1, 1999'                       'Aug 13, 2012'                        
'jan 3   10'                        'Aug 13   12'                         
'01 3 2010'                         '08 13 2012'                          
'1 3 10'                            '08 13 12'                            
'1 13 89'                           '08 13 12'                            
'5/27/1979'                         '08/13/2012'                          
'12/31/99'                          '08/13/12'                            
'DOB:12/11/00'                      'DOB:08/13/12'                        
'Thu, 1 July 2004 22:30:00'         'Mon, 13 August 2012 11:37:53'        
'Thu, 1st of July 2004 at 22:30:00' 'Mon, 13st of August 2012 at 11:37:53'
'Thu, 1July 2004 at 22:30:00'       'Mon, 13August 2012 at 11:37:53'      
'Thu, 1July2004 22:30:00'           'Mon, 13August2012 11:37:53'          
'21 Aug 2011, 11:15:34 pm'          '13 Aug 2012, 11:37:53 AM'            
'1979-05-27 05:00:59'               '2012-08-13 11:37:53'                 
'1979-05-27'                        '2012-08-13'                          
'3 jan 2000'                        '13 Aug 2012'                         
'17 april 85'                       '13 August 12'                        
'27/5/1979'                         '13/08/2012'                          
'20 01 89'                          '13 08 12'                            
'00/13/10'                          '12/13/08'                            
'14 12 00'                          '13 08 12'                            
'03:23:22 pm'                       '11:37:53 AM'
"))

  D <- as.POSIXct("2012-08-13 11:37:53", tz = "UTC")

  for( i in seq_along(test_dates$date) )
    test_that(stamp(test_dates[[i, "date"]])(D), equals(test_dates[[i, "expected"]]))
  
  })
