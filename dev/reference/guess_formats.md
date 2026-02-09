# Guess possible date-times formats from a character vector

Guess possible date-times formats from a character vector.

## Usage

``` r
guess_formats(
  x,
  orders,
  locale = Sys.getlocale("LC_TIME"),
  preproc_wday = TRUE,
  print_matches = FALSE
)
```

## Arguments

- x:

  input vector of date-times.

- orders:

  format orders to look for. See examples.

- locale:

  locale to use. Defaults to the current locale.

- preproc_wday:

  whether to preprocess weekday names. Internal optimization used by
  [`ymd_hms()`](https://lubridate.tidyverse.org/dev/reference/ymd_hms.md)
  family of functions. If `TRUE`, weekdays are substituted with %a or %A
  accordingly, so that there is no need to supply this format
  explicitly.

- print_matches:

  for development purposes mainly. If `TRUE`, prints a matrix of matched
  templates.

## Value

a vector of matched formats

## Examples

``` r
x <- c('February 20th 1973',
       "february  14, 2004",
       "Sunday, May 1, 2000",
       "Sunday, May 1, 2000",
       "february  14, 04",
       'Feb 20th 73',
       "January 5 1999 at 7pm",
       "jan 3 2010",
       "Jan 1, 1999",
       "jan 3   10",
       "01 3 2010",
       "1 3 10",
       '1 13 89',
       "5/27/1979",
       "12/31/99",
       "DOB:12/11/00",
       "-----------",
       'Thu, 1 July 2004 22:30:00',
       'Thu, 1st of July 2004 at 22:30:00',
       'Thu, 1July 2004 at 22:30:00',
       'Thu, 1July2004 22:30:00',
       'Thu, 1July04 22:30:00',
       "21 Aug 2011, 11:15:34 pm",
       "-----------",
       "1979-05-27 05:00:59",
       "1979-05-27",
       "-----------",
       "3 jan 2000",
       "17 april 85",
       "27/5/1979",
       '20 01 89',
       '00/13/10',
       "-------",
       "14 12 00",
       "03:23:22 pm")

guess_formats(x, "BdY")
#>                 ObdY                 ObdY                 ObdY 
#>        "%Ob %dth %Y"        "%Ob  %d, %Y"     "%A, %Ob %d, %Y" 
#>                 ObdY                 ObdY                 ObdY 
#>     "%A, %Ob %d, %Y"          "%Ob %d %Y"         "%Ob %d, %Y" 
#>                  BdY                  BdY                  BdY 
#>         "%B %dth %Y"         "%B  %d, %Y"      "%A, %B %d, %Y" 
#>                  BdY                 ObdY                 ObdY 
#>      "%A, %B %d, %Y"        "%Ob %dth %Y"        "%Ob  %d, %Y" 
#>                 ObdY                 ObdY                 ObdY 
#> "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y"          "%Ob %d %Y" 
#>                 ObdY                  BdY                  BdY 
#>         "%Ob %d, %Y"         "%B %dth %Y"         "%B  %d, %Y" 
#>                  BdY                  BdY 
#>  "Sunday, %B %d, %Y"  "Sunday, %B %d, %Y" 
guess_formats(x, "Bdy")
#>                 Obdy                 Obdy                 Obdy 
#>        "%Ob %dth %Y"        "%Ob  %d, %Y"     "%A, %Ob %d, %Y" 
#>                 Obdy                 Obdy                 Obdy 
#>     "%A, %Ob %d, %Y"        "%Ob  %d, %y"        "%Ob %dth %y" 
#>                 Obdy                 Obdy                 Obdy 
#>          "%Ob %d %Y"         "%Ob %d, %Y"        "%Ob %d   %y" 
#>                  Bdy                  Bdy                  Bdy 
#>         "%B %dth %Y"         "%B  %d, %Y"      "%A, %B %d, %Y" 
#>                  Bdy                  Bdy                 Obdy 
#>      "%A, %B %d, %Y"         "%B  %d, %y"        "%Ob %dth %Y" 
#>                 Obdy                 Obdy                 Obdy 
#>        "%Ob  %d, %Y" "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y" 
#>                 Obdy                 Obdy                 Obdy 
#>        "%Ob  %d, %y"        "%Ob %dth %y"          "%Ob %d %Y" 
#>                 Obdy                 Obdy                  Bdy 
#>         "%Ob %d, %Y"        "%Ob %d   %y"         "%B %dth %Y" 
#>                  Bdy                  Bdy                  Bdy 
#>         "%B  %d, %Y"  "Sunday, %B %d, %Y"  "Sunday, %B %d, %Y" 
#>                  Bdy 
#>         "%B  %d, %y" 
## m also matches b and B; y also matches Y
guess_formats(x, "mdy", print_matches = TRUE)
#>                                           Omdy                
#>  [1,] "February 20th 1973"                "%Om %dth %Y"       
#>  [2,] "february  14, 2004"                "%Om  %d, %Y"       
#>  [3,] "Sunday, May 1, 2000"               "Sunday, %Om %d, %Y"
#>  [4,] "Sunday, May 1, 2000"               "Sunday, %Om %d, %Y"
#>  [5,] "february  14, 04"                  "%Om  %d, %y"       
#>  [6,] "Feb 20th 73"                       "%Om %dth %y"       
#>  [7,] "January 5 1999 at 7pm"             ""                  
#>  [8,] "jan 3 2010"                        "%Om %d %Y"         
#>  [9,] "Jan 1, 1999"                       "%Om %d, %Y"        
#> [10,] "jan 3   10"                        "%Om %d   %y"       
#> [11,] "01 3 2010"                         "%Om %d %Y"         
#> [12,] "1 3 10"                            "%Om %d %y"         
#> [13,] "1 13 89"                           "%Om %d %y"         
#> [14,] "5/27/1979"                         "%Om/%d/%Y"         
#> [15,] "12/31/99"                          "%Om/%d/%y"         
#> [16,] "DOB:12/11/00"                      "DOB:%Om/%d/%y"     
#> [17,] "-----------"                       ""                  
#> [18,] "Thu, 1 July 2004 22:30:00"         ""                  
#> [19,] "Thu, 1st of July 2004 at 22:30:00" ""                  
#> [20,] "Thu, 1July 2004 at 22:30:00"       ""                  
#> [21,] "Thu, 1July2004 22:30:00"           ""                  
#> [22,] "Thu, 1July04 22:30:00"             ""                  
#> [23,] "21 Aug 2011, 11:15:34 pm"          ""                  
#> [24,] "-----------"                       ""                  
#> [25,] "1979-05-27 05:00:59"               ""                  
#> [26,] "1979-05-27"                        ""                  
#> [27,] "-----------"                       ""                  
#> [28,] "3 jan 2000"                        ""                  
#> [29,] "17 april 85"                       ""                  
#> [30,] "27/5/1979"                         ""                  
#> [31,] "20 01 89"                          ""                  
#> [32,] "00/13/10"                          ""                  
#> [33,] "-------"                           ""                  
#> [34,] "14 12 00"                          ""                  
#> [35,] "03:23:22 pm"                       "%Om:%d:%y pm"      
#>       mdy                
#>  [1,] "%B %dth %Y"       
#>  [2,] "%B  %d, %Y"       
#>  [3,] "Sunday, %b %d, %Y"
#>  [4,] "Sunday, %b %d, %Y"
#>  [5,] "%B  %d, %y"       
#>  [6,] "%b %dth %y"       
#>  [7,] ""                 
#>  [8,] "%b %d %Y"         
#>  [9,] "%b %d, %Y"        
#> [10,] "%b %d   %y"       
#> [11,] "%m %d %Y"         
#> [12,] "%m %d %y"         
#> [13,] "%m %d %y"         
#> [14,] "%m/%d/%Y"         
#> [15,] "%m/%d/%y"         
#> [16,] "DOB:%m/%d/%y"     
#> [17,] ""                 
#> [18,] ""                 
#> [19,] ""                 
#> [20,] ""                 
#> [21,] ""                 
#> [22,] ""                 
#> [23,] ""                 
#> [24,] ""                 
#> [25,] ""                 
#> [26,] ""                 
#> [27,] ""                 
#> [28,] ""                 
#> [29,] ""                 
#> [30,] ""                 
#> [31,] ""                 
#> [32,] ""                 
#> [33,] ""                 
#> [34,] ""                 
#> [35,] "%m:%d:%y pm"      
#>                 Omdy                 Omdy                 Omdy 
#>        "%Om %dth %Y"        "%Om  %d, %Y"     "%A, %Om %d, %Y" 
#>                 Omdy                 Omdy                 Omdy 
#>     "%A, %Om %d, %Y"        "%Om  %d, %y"        "%Om %dth %y" 
#>                 Omdy                 Omdy                 Omdy 
#>          "%Om %d %Y"         "%Om %d, %Y"        "%Om %d   %y" 
#>                 Omdy                 Omdy                 Omdy 
#>          "%Om %d %Y"          "%Om %d %y"          "%Om %d %y" 
#>                 Omdy                 Omdy                 Omdy 
#>          "%Om/%d/%Y"          "%Om/%d/%y"      "DOB:%Om/%d/%y" 
#>                 Omdy                  mdy                  mdy 
#>       "%Om:%d:%y pm"         "%B %dth %Y"         "%B  %d, %Y" 
#>                  mdy                  mdy                  mdy 
#>      "%A, %b %d, %Y"      "%A, %b %d, %Y"         "%B  %d, %y" 
#>                  mdy                  mdy                  mdy 
#>         "%b %dth %y"           "%b %d %Y"          "%b %d, %Y" 
#>                  mdy                  mdy                  mdy 
#>         "%b %d   %y"           "%m %d %Y"           "%m %d %y" 
#>                  mdy                  mdy                  mdy 
#>           "%m %d %y"           "%m/%d/%Y"           "%m/%d/%y" 
#>                  mdy                  mdy                 Omdy 
#>       "DOB:%m/%d/%y"        "%m:%d:%y pm"        "%Om %dth %Y" 
#>                 Omdy                 Omdy                 Omdy 
#>        "%Om  %d, %Y" "Sunday, %Om %d, %Y" "Sunday, %Om %d, %Y" 
#>                 Omdy                 Omdy                 Omdy 
#>        "%Om  %d, %y"        "%Om %dth %y"          "%Om %d %Y" 
#>                 Omdy                 Omdy                 Omdy 
#>         "%Om %d, %Y"        "%Om %d   %y"          "%Om %d %Y" 
#>                 Omdy                 Omdy                 Omdy 
#>          "%Om %d %y"          "%Om %d %y"          "%Om/%d/%Y" 
#>                 Omdy                 Omdy                 Omdy 
#>          "%Om/%d/%y"      "DOB:%Om/%d/%y"       "%Om:%d:%y pm" 
#>                  mdy                  mdy                  mdy 
#>         "%B %dth %Y"         "%B  %d, %Y"  "Sunday, %b %d, %Y" 
#>                  mdy                  mdy                  mdy 
#>  "Sunday, %b %d, %Y"         "%B  %d, %y"         "%b %dth %y" 
#>                  mdy                  mdy                  mdy 
#>           "%b %d %Y"          "%b %d, %Y"         "%b %d   %y" 
#>                  mdy                  mdy                  mdy 
#>           "%m %d %Y"           "%m %d %y"           "%m %d %y" 
#>                  mdy                  mdy                  mdy 
#>           "%m/%d/%Y"           "%m/%d/%y"       "DOB:%m/%d/%y" 
#>                  mdy 
#>        "%m:%d:%y pm" 

## T also matches IMSp order
guess_formats(x, "T", print_matches = TRUE)
#>                                           HMSOp         
#>  [1,] "February 20th 1973"                ""            
#>  [2,] "february  14, 2004"                ""            
#>  [3,] "Sunday, May 1, 2000"               ""            
#>  [4,] "Sunday, May 1, 2000"               ""            
#>  [5,] "february  14, 04"                  ""            
#>  [6,] "Feb 20th 73"                       ""            
#>  [7,] "January 5 1999 at 7pm"             ""            
#>  [8,] "jan 3 2010"                        ""            
#>  [9,] "Jan 1, 1999"                       ""            
#> [10,] "jan 3   10"                        ""            
#> [11,] "01 3 2010"                         ""            
#> [12,] "1 3 10"                            ""            
#> [13,] "1 13 89"                           ""            
#> [14,] "5/27/1979"                         ""            
#> [15,] "12/31/99"                          ""            
#> [16,] "DOB:12/11/00"                      ""            
#> [17,] "-----------"                       ""            
#> [18,] "Thu, 1 July 2004 22:30:00"         ""            
#> [19,] "Thu, 1st of July 2004 at 22:30:00" ""            
#> [20,] "Thu, 1July 2004 at 22:30:00"       ""            
#> [21,] "Thu, 1July2004 22:30:00"           ""            
#> [22,] "Thu, 1July04 22:30:00"             ""            
#> [23,] "21 Aug 2011, 11:15:34 pm"          ""            
#> [24,] "-----------"                       ""            
#> [25,] "1979-05-27 05:00:59"               ""            
#> [26,] "1979-05-27"                        ""            
#> [27,] "-----------"                       ""            
#> [28,] "3 jan 2000"                        ""            
#> [29,] "17 april 85"                       ""            
#> [30,] "27/5/1979"                         ""            
#> [31,] "20 01 89"                          ""            
#> [32,] "00/13/10"                          ""            
#> [33,] "-------"                           ""            
#> [34,] "14 12 00"                          ""            
#> [35,] "03:23:22 pm"                       "%H:%M:%S %Op"
#>       T                   
#>  [1,] ""                  
#>  [2,] "february  %H, %M%S"
#>  [3,] ""                  
#>  [4,] ""                  
#>  [5,] ""                  
#>  [6,] ""                  
#>  [7,] ""                  
#>  [8,] ""                  
#>  [9,] ""                  
#> [10,] ""                  
#> [11,] ""                  
#> [12,] "%H %M %S"          
#> [13,] ""                  
#> [14,] ""                  
#> [15,] ""                  
#> [16,] "DOB:%H/%M/%S"      
#> [17,] ""                  
#> [18,] ""                  
#> [19,] ""                  
#> [20,] ""                  
#> [21,] ""                  
#> [22,] ""                  
#> [23,] ""                  
#> [24,] ""                  
#> [25,] ""                  
#> [26,] ""                  
#> [27,] ""                  
#> [28,] ""                  
#> [29,] ""                  
#> [30,] ""                  
#> [31,] ""                  
#> [32,] "%H/%M/%S"          
#> [33,] ""                  
#> [34,] "%H %M %S"          
#> [35,] "%I:%M:%S %p"       
#>                HMSOp                    T                    T 
#>       "%H:%M:%S %Op" "february  %H, %M%S"           "%H %M %S" 
#>                    T                    T                    T 
#>       "DOB:%H/%M/%S"           "%H/%M/%S"           "%H %M %S" 
#>                    T 
#>        "%I:%M:%S %p" 

## b and B are equivalent and match, both, abreviated and full names
guess_formats(x, c("mdY", "BdY", "Bdy", "bdY", "bdy"), print_matches = TRUE)
#>                                           ObdY                
#>  [1,] "February 20th 1973"                "%Ob %dth %Y"       
#>  [2,] "february  14, 2004"                "%Ob  %d, %Y"       
#>  [3,] "Sunday, May 1, 2000"               "Sunday, %Ob %d, %Y"
#>  [4,] "Sunday, May 1, 2000"               "Sunday, %Ob %d, %Y"
#>  [5,] "february  14, 04"                  ""                  
#>  [6,] "Feb 20th 73"                       ""                  
#>  [7,] "January 5 1999 at 7pm"             ""                  
#>  [8,] "jan 3 2010"                        "%Ob %d %Y"         
#>  [9,] "Jan 1, 1999"                       "%Ob %d, %Y"        
#> [10,] "jan 3   10"                        ""                  
#> [11,] "01 3 2010"                         ""                  
#> [12,] "1 3 10"                            ""                  
#> [13,] "1 13 89"                           ""                  
#> [14,] "5/27/1979"                         ""                  
#> [15,] "12/31/99"                          ""                  
#> [16,] "DOB:12/11/00"                      ""                  
#> [17,] "-----------"                       ""                  
#> [18,] "Thu, 1 July 2004 22:30:00"         ""                  
#> [19,] "Thu, 1st of July 2004 at 22:30:00" ""                  
#> [20,] "Thu, 1July 2004 at 22:30:00"       ""                  
#> [21,] "Thu, 1July2004 22:30:00"           ""                  
#> [22,] "Thu, 1July04 22:30:00"             ""                  
#> [23,] "21 Aug 2011, 11:15:34 pm"          ""                  
#> [24,] "-----------"                       ""                  
#> [25,] "1979-05-27 05:00:59"               ""                  
#> [26,] "1979-05-27"                        ""                  
#> [27,] "-----------"                       ""                  
#> [28,] "3 jan 2000"                        ""                  
#> [29,] "17 april 85"                       ""                  
#> [30,] "27/5/1979"                         ""                  
#> [31,] "20 01 89"                          ""                  
#> [32,] "00/13/10"                          ""                  
#> [33,] "-------"                           ""                  
#> [34,] "14 12 00"                          ""                  
#> [35,] "03:23:22 pm"                       ""                  
#>       Obdy                 ObdY                 Obdy                
#>  [1,] "%Ob %dth %Y"        "%Ob %dth %Y"        "%Ob %dth %Y"       
#>  [2,] "%Ob  %d, %Y"        "%Ob  %d, %Y"        "%Ob  %d, %Y"       
#>  [3,] "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y"
#>  [4,] "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y"
#>  [5,] "%Ob  %d, %y"        ""                   "%Ob  %d, %y"       
#>  [6,] "%Ob %dth %y"        ""                   "%Ob %dth %y"       
#>  [7,] ""                   ""                   ""                  
#>  [8,] "%Ob %d %Y"          "%Ob %d %Y"          "%Ob %d %Y"         
#>  [9,] "%Ob %d, %Y"         "%Ob %d, %Y"         "%Ob %d, %Y"        
#> [10,] "%Ob %d   %y"        ""                   "%Ob %d   %y"       
#> [11,] ""                   ""                   ""                  
#> [12,] ""                   ""                   ""                  
#> [13,] ""                   ""                   ""                  
#> [14,] ""                   ""                   ""                  
#> [15,] ""                   ""                   ""                  
#> [16,] ""                   ""                   ""                  
#> [17,] ""                   ""                   ""                  
#> [18,] ""                   ""                   ""                  
#> [19,] ""                   ""                   ""                  
#> [20,] ""                   ""                   ""                  
#> [21,] ""                   ""                   ""                  
#> [22,] ""                   ""                   ""                  
#> [23,] ""                   ""                   ""                  
#> [24,] ""                   ""                   ""                  
#> [25,] ""                   ""                   ""                  
#> [26,] ""                   ""                   ""                  
#> [27,] ""                   ""                   ""                  
#> [28,] ""                   ""                   ""                  
#> [29,] ""                   ""                   ""                  
#> [30,] ""                   ""                   ""                  
#> [31,] ""                   ""                   ""                  
#> [32,] ""                   ""                   ""                  
#> [33,] ""                   ""                   ""                  
#> [34,] ""                   ""                   ""                  
#> [35,] ""                   ""                   ""                  
#>       OmdY                 mdY                 BdY                
#>  [1,] "%Om %dth %Y"        "%B %dth %Y"        "%B %dth %Y"       
#>  [2,] "%Om  %d, %Y"        "%B  %d, %Y"        "%B  %d, %Y"       
#>  [3,] "Sunday, %Om %d, %Y" "Sunday, %b %d, %Y" "Sunday, %B %d, %Y"
#>  [4,] "Sunday, %Om %d, %Y" "Sunday, %b %d, %Y" "Sunday, %B %d, %Y"
#>  [5,] ""                   ""                  ""                 
#>  [6,] ""                   ""                  ""                 
#>  [7,] ""                   ""                  ""                 
#>  [8,] "%Om %d %Y"          "%b %d %Y"          ""                 
#>  [9,] "%Om %d, %Y"         "%b %d, %Y"         ""                 
#> [10,] ""                   ""                  ""                 
#> [11,] "%Om %d %Y"          "%m %d %Y"          ""                 
#> [12,] ""                   ""                  ""                 
#> [13,] ""                   ""                  ""                 
#> [14,] "%Om/%d/%Y"          "%m/%d/%Y"          ""                 
#> [15,] ""                   ""                  ""                 
#> [16,] ""                   ""                  ""                 
#> [17,] ""                   ""                  ""                 
#> [18,] ""                   ""                  ""                 
#> [19,] ""                   ""                  ""                 
#> [20,] ""                   ""                  ""                 
#> [21,] ""                   ""                  ""                 
#> [22,] ""                   ""                  ""                 
#> [23,] ""                   ""                  ""                 
#> [24,] ""                   ""                  ""                 
#> [25,] ""                   ""                  ""                 
#> [26,] ""                   ""                  ""                 
#> [27,] ""                   ""                  ""                 
#> [28,] ""                   ""                  ""                 
#> [29,] ""                   ""                  ""                 
#> [30,] ""                   ""                  ""                 
#> [31,] ""                   ""                  ""                 
#> [32,] ""                   ""                  ""                 
#> [33,] ""                   ""                  ""                 
#> [34,] ""                   ""                  ""                 
#> [35,] ""                   ""                  ""                 
#>       Bdy                 bdY                 bdy                
#>  [1,] "%B %dth %Y"        "%B %dth %Y"        "%B %dth %Y"       
#>  [2,] "%B  %d, %Y"        "%B  %d, %Y"        "%B  %d, %Y"       
#>  [3,] "Sunday, %B %d, %Y" "Sunday, %b %d, %Y" "Sunday, %b %d, %Y"
#>  [4,] "Sunday, %B %d, %Y" "Sunday, %b %d, %Y" "Sunday, %b %d, %Y"
#>  [5,] "%B  %d, %y"        ""                  "%B  %d, %y"       
#>  [6,] ""                  ""                  "%b %dth %y"       
#>  [7,] ""                  ""                  ""                 
#>  [8,] ""                  "%b %d %Y"          "%b %d %Y"         
#>  [9,] ""                  "%b %d, %Y"         "%b %d, %Y"        
#> [10,] ""                  ""                  "%b %d   %y"       
#> [11,] ""                  ""                  ""                 
#> [12,] ""                  ""                  ""                 
#> [13,] ""                  ""                  ""                 
#> [14,] ""                  ""                  ""                 
#> [15,] ""                  ""                  ""                 
#> [16,] ""                  ""                  ""                 
#> [17,] ""                  ""                  ""                 
#> [18,] ""                  ""                  ""                 
#> [19,] ""                  ""                  ""                 
#> [20,] ""                  ""                  ""                 
#> [21,] ""                  ""                  ""                 
#> [22,] ""                  ""                  ""                 
#> [23,] ""                  ""                  ""                 
#> [24,] ""                  ""                  ""                 
#> [25,] ""                  ""                  ""                 
#> [26,] ""                  ""                  ""                 
#> [27,] ""                  ""                  ""                 
#> [28,] ""                  ""                  ""                 
#> [29,] ""                  ""                  ""                 
#> [30,] ""                  ""                  ""                 
#> [31,] ""                  ""                  ""                 
#> [32,] ""                  ""                  ""                 
#> [33,] ""                  ""                  ""                 
#> [34,] ""                  ""                  ""                 
#> [35,] ""                  ""                  ""                 
#>                 ObdY                 ObdY                 ObdY 
#>        "%Ob %dth %Y"        "%Ob  %d, %Y"     "%A, %Ob %d, %Y" 
#>                 ObdY                 ObdY                 ObdY 
#>     "%A, %Ob %d, %Y"          "%Ob %d %Y"         "%Ob %d, %Y" 
#>                 Obdy                 Obdy                 Obdy 
#>        "%Ob %dth %Y"        "%Ob  %d, %Y"     "%A, %Ob %d, %Y" 
#>                 Obdy                 Obdy                 Obdy 
#>     "%A, %Ob %d, %Y"        "%Ob  %d, %y"        "%Ob %dth %y" 
#>                 Obdy                 Obdy                 Obdy 
#>          "%Ob %d %Y"         "%Ob %d, %Y"        "%Ob %d   %y" 
#>                 ObdY                 ObdY                 ObdY 
#>        "%Ob %dth %Y"        "%Ob  %d, %Y"     "%A, %Ob %d, %Y" 
#>                 ObdY                 ObdY                 ObdY 
#>     "%A, %Ob %d, %Y"          "%Ob %d %Y"         "%Ob %d, %Y" 
#>                 Obdy                 Obdy                 Obdy 
#>        "%Ob %dth %Y"        "%Ob  %d, %Y"     "%A, %Ob %d, %Y" 
#>                 Obdy                 Obdy                 Obdy 
#>     "%A, %Ob %d, %Y"        "%Ob  %d, %y"        "%Ob %dth %y" 
#>                 Obdy                 Obdy                 Obdy 
#>          "%Ob %d %Y"         "%Ob %d, %Y"        "%Ob %d   %y" 
#>                 OmdY                 OmdY                 OmdY 
#>        "%Om %dth %Y"        "%Om  %d, %Y"     "%A, %Om %d, %Y" 
#>                 OmdY                 OmdY                 OmdY 
#>     "%A, %Om %d, %Y"          "%Om %d %Y"         "%Om %d, %Y" 
#>                 OmdY                 OmdY                  mdY 
#>          "%Om %d %Y"          "%Om/%d/%Y"         "%B %dth %Y" 
#>                  mdY                  mdY                  mdY 
#>         "%B  %d, %Y"      "%A, %b %d, %Y"      "%A, %b %d, %Y" 
#>                  mdY                  mdY                  mdY 
#>           "%b %d %Y"          "%b %d, %Y"           "%m %d %Y" 
#>                  mdY                  BdY                  BdY 
#>           "%m/%d/%Y"         "%B %dth %Y"         "%B  %d, %Y" 
#>                  BdY                  BdY                  Bdy 
#>      "%A, %B %d, %Y"      "%A, %B %d, %Y"         "%B %dth %Y" 
#>                  Bdy                  Bdy                  Bdy 
#>         "%B  %d, %Y"      "%A, %B %d, %Y"      "%A, %B %d, %Y" 
#>                  Bdy                  bdY                  bdY 
#>         "%B  %d, %y"         "%B %dth %Y"         "%B  %d, %Y" 
#>                  bdY                  bdY                  bdY 
#>      "%A, %b %d, %Y"      "%A, %b %d, %Y"           "%b %d %Y" 
#>                  bdY                  bdy                  bdy 
#>          "%b %d, %Y"         "%B %dth %Y"         "%B  %d, %Y" 
#>                  bdy                  bdy                  bdy 
#>      "%A, %b %d, %Y"      "%A, %b %d, %Y"         "%B  %d, %y" 
#>                  bdy                  bdy                  bdy 
#>         "%b %dth %y"           "%b %d %Y"          "%b %d, %Y" 
#>                  bdy                 ObdY                 ObdY 
#>         "%b %d   %y"        "%Ob %dth %Y"        "%Ob  %d, %Y" 
#>                 ObdY                 ObdY                 ObdY 
#> "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y"          "%Ob %d %Y" 
#>                 ObdY                 Obdy                 Obdy 
#>         "%Ob %d, %Y"        "%Ob %dth %Y"        "%Ob  %d, %Y" 
#>                 Obdy                 Obdy                 Obdy 
#> "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y"        "%Ob  %d, %y" 
#>                 Obdy                 Obdy                 Obdy 
#>        "%Ob %dth %y"          "%Ob %d %Y"         "%Ob %d, %Y" 
#>                 Obdy                 ObdY                 ObdY 
#>        "%Ob %d   %y"        "%Ob %dth %Y"        "%Ob  %d, %Y" 
#>                 ObdY                 ObdY                 ObdY 
#> "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y"          "%Ob %d %Y" 
#>                 ObdY                 Obdy                 Obdy 
#>         "%Ob %d, %Y"        "%Ob %dth %Y"        "%Ob  %d, %Y" 
#>                 Obdy                 Obdy                 Obdy 
#> "Sunday, %Ob %d, %Y" "Sunday, %Ob %d, %Y"        "%Ob  %d, %y" 
#>                 Obdy                 Obdy                 Obdy 
#>        "%Ob %dth %y"          "%Ob %d %Y"         "%Ob %d, %Y" 
#>                 Obdy                 OmdY                 OmdY 
#>        "%Ob %d   %y"        "%Om %dth %Y"        "%Om  %d, %Y" 
#>                 OmdY                 OmdY                 OmdY 
#> "Sunday, %Om %d, %Y" "Sunday, %Om %d, %Y"          "%Om %d %Y" 
#>                 OmdY                 OmdY                 OmdY 
#>         "%Om %d, %Y"          "%Om %d %Y"          "%Om/%d/%Y" 
#>                  mdY                  mdY                  mdY 
#>         "%B %dth %Y"         "%B  %d, %Y"  "Sunday, %b %d, %Y" 
#>                  mdY                  mdY                  mdY 
#>  "Sunday, %b %d, %Y"           "%b %d %Y"          "%b %d, %Y" 
#>                  mdY                  mdY                  BdY 
#>           "%m %d %Y"           "%m/%d/%Y"         "%B %dth %Y" 
#>                  BdY                  BdY                  BdY 
#>         "%B  %d, %Y"  "Sunday, %B %d, %Y"  "Sunday, %B %d, %Y" 
#>                  Bdy                  Bdy                  Bdy 
#>         "%B %dth %Y"         "%B  %d, %Y"  "Sunday, %B %d, %Y" 
#>                  Bdy                  Bdy                  bdY 
#>  "Sunday, %B %d, %Y"         "%B  %d, %y"         "%B %dth %Y" 
#>                  bdY                  bdY                  bdY 
#>         "%B  %d, %Y"  "Sunday, %b %d, %Y"  "Sunday, %b %d, %Y" 
#>                  bdY                  bdY                  bdy 
#>           "%b %d %Y"          "%b %d, %Y"         "%B %dth %Y" 
#>                  bdy                  bdy                  bdy 
#>         "%B  %d, %Y"  "Sunday, %b %d, %Y"  "Sunday, %b %d, %Y" 
#>                  bdy                  bdy                  bdy 
#>         "%B  %d, %y"         "%b %dth %y"           "%b %d %Y" 
#>                  bdy                  bdy 
#>          "%b %d, %Y"         "%b %d   %y" 
guess_formats(x, c("dmy", "dbY", "dBy", "dBY"), print_matches = TRUE)
#>                                           dObY        dOby       
#>  [1,] "February 20th 1973"                ""          ""         
#>  [2,] "february  14, 2004"                ""          ""         
#>  [3,] "Sunday, May 1, 2000"               ""          ""         
#>  [4,] "Sunday, May 1, 2000"               ""          ""         
#>  [5,] "february  14, 04"                  ""          ""         
#>  [6,] "Feb 20th 73"                       ""          ""         
#>  [7,] "January 5 1999 at 7pm"             ""          ""         
#>  [8,] "jan 3 2010"                        ""          ""         
#>  [9,] "Jan 1, 1999"                       ""          ""         
#> [10,] "jan 3   10"                        ""          ""         
#> [11,] "01 3 2010"                         ""          ""         
#> [12,] "1 3 10"                            ""          ""         
#> [13,] "1 13 89"                           ""          ""         
#> [14,] "5/27/1979"                         ""          ""         
#> [15,] "12/31/99"                          ""          ""         
#> [16,] "DOB:12/11/00"                      ""          ""         
#> [17,] "-----------"                       ""          ""         
#> [18,] "Thu, 1 July 2004 22:30:00"         ""          ""         
#> [19,] "Thu, 1st of July 2004 at 22:30:00" ""          ""         
#> [20,] "Thu, 1July 2004 at 22:30:00"       ""          ""         
#> [21,] "Thu, 1July2004 22:30:00"           ""          ""         
#> [22,] "Thu, 1July04 22:30:00"             ""          ""         
#> [23,] "21 Aug 2011, 11:15:34 pm"          ""          ""         
#> [24,] "-----------"                       ""          ""         
#> [25,] "1979-05-27 05:00:59"               ""          ""         
#> [26,] "1979-05-27"                        ""          ""         
#> [27,] "-----------"                       ""          ""         
#> [28,] "3 jan 2000"                        "%d %Ob %Y" "%d %Ob %Y"
#> [29,] "17 april 85"                       ""          "%d %Ob %y"
#> [30,] "27/5/1979"                         ""          ""         
#> [31,] "20 01 89"                          ""          ""         
#> [32,] "00/13/10"                          ""          ""         
#> [33,] "-------"                           ""          ""         
#> [34,] "14 12 00"                          ""          ""         
#> [35,] "03:23:22 pm"                       ""          ""         
#>       dObY        dOmy            dmy            dbY        dBy       
#>  [1,] ""          ""              ""             ""         ""        
#>  [2,] ""          ""              ""             ""         ""        
#>  [3,] ""          ""              ""             ""         ""        
#>  [4,] ""          ""              ""             ""         ""        
#>  [5,] ""          ""              ""             ""         ""        
#>  [6,] ""          ""              ""             ""         ""        
#>  [7,] ""          ""              ""             ""         ""        
#>  [8,] ""          ""              ""             ""         ""        
#>  [9,] ""          ""              ""             ""         ""        
#> [10,] ""          ""              ""             ""         ""        
#> [11,] ""          "%d %Om %Y"     "%d %m %Y"     ""         ""        
#> [12,] ""          "%d %Om %y"     "%d %m %y"     ""         ""        
#> [13,] ""          ""              ""             ""         ""        
#> [14,] ""          ""              ""             ""         ""        
#> [15,] ""          ""              ""             ""         ""        
#> [16,] ""          "DOB:%d/%Om/%y" "DOB:%d/%m/%y" ""         ""        
#> [17,] ""          ""              ""             ""         ""        
#> [18,] ""          ""              ""             ""         ""        
#> [19,] ""          ""              ""             ""         ""        
#> [20,] ""          ""              ""             ""         ""        
#> [21,] ""          ""              ""             ""         ""        
#> [22,] ""          ""              ""             ""         ""        
#> [23,] ""          ""              ""             ""         ""        
#> [24,] ""          ""              ""             ""         ""        
#> [25,] ""          ""              ""             ""         ""        
#> [26,] ""          ""              ""             ""         ""        
#> [27,] ""          ""              ""             ""         ""        
#> [28,] "%d %Ob %Y" "%d %Om %Y"     "%d %b %Y"     "%d %b %Y" ""        
#> [29,] ""          "%d %Om %y"     "%d %B %y"     ""         "%d %B %y"
#> [30,] ""          "%d/%Om/%Y"     "%d/%m/%Y"     ""         ""        
#> [31,] ""          "%d %Om %y"     "%d %m %y"     ""         ""        
#> [32,] ""          ""              ""             ""         ""        
#> [33,] ""          ""              ""             ""         ""        
#> [34,] ""          "%d %Om %y"     "%d %m %y"     ""         ""        
#> [35,] ""          ""              ""             ""         ""        
#>       dBY
#>  [1,] "" 
#>  [2,] "" 
#>  [3,] "" 
#>  [4,] "" 
#>  [5,] "" 
#>  [6,] "" 
#>  [7,] "" 
#>  [8,] "" 
#>  [9,] "" 
#> [10,] "" 
#> [11,] "" 
#> [12,] "" 
#> [13,] "" 
#> [14,] "" 
#> [15,] "" 
#> [16,] "" 
#> [17,] "" 
#> [18,] "" 
#> [19,] "" 
#> [20,] "" 
#> [21,] "" 
#> [22,] "" 
#> [23,] "" 
#> [24,] "" 
#> [25,] "" 
#> [26,] "" 
#> [27,] "" 
#> [28,] "" 
#> [29,] "" 
#> [30,] "" 
#> [31,] "" 
#> [32,] "" 
#> [33,] "" 
#> [34,] "" 
#> [35,] "" 
#>            dObY            dOby            dOby            dObY 
#>     "%d %Ob %Y"     "%d %Ob %Y"     "%d %Ob %y"     "%d %Ob %Y" 
#>            dOmy            dOmy            dOmy            dOmy 
#>     "%d %Om %Y"     "%d %Om %y" "DOB:%d/%Om/%y"     "%d %Om %Y" 
#>            dOmy            dOmy            dOmy            dOmy 
#>     "%d %Om %y"     "%d/%Om/%Y"     "%d %Om %y"     "%d %Om %y" 
#>             dmy             dmy             dmy             dmy 
#>      "%d %m %Y"      "%d %m %y"  "DOB:%d/%m/%y"      "%d %b %Y" 
#>             dmy             dmy             dmy             dmy 
#>      "%d %B %y"      "%d/%m/%Y"      "%d %m %y"      "%d %m %y" 
#>             dbY             dBy 
#>      "%d %b %Y"      "%d %B %y" 


guess_formats(x, c("dBY HMS", "dbY HMS", "dmyHMS", "BdY H"), print_matches = TRUE)
#>                                          
#>  [1,] "February 20th 1973"               
#>  [2,] "february  14, 2004"               
#>  [3,] "Sunday, May 1, 2000"              
#>  [4,] "Sunday, May 1, 2000"              
#>  [5,] "february  14, 04"                 
#>  [6,] "Feb 20th 73"                      
#>  [7,] "January 5 1999 at 7pm"            
#>  [8,] "jan 3 2010"                       
#>  [9,] "Jan 1, 1999"                      
#> [10,] "jan 3   10"                       
#> [11,] "01 3 2010"                        
#> [12,] "1 3 10"                           
#> [13,] "1 13 89"                          
#> [14,] "5/27/1979"                        
#> [15,] "12/31/99"                         
#> [16,] "DOB:12/11/00"                     
#> [17,] "-----------"                      
#> [18,] "Thu, 1 July 2004 22:30:00"        
#> [19,] "Thu, 1st of July 2004 at 22:30:00"
#> [20,] "Thu, 1July 2004 at 22:30:00"      
#> [21,] "Thu, 1July2004 22:30:00"          
#> [22,] "Thu, 1July04 22:30:00"            
#> [23,] "21 Aug 2011, 11:15:34 pm"         
#> [24,] "-----------"                      
#> [25,] "1979-05-27 05:00:59"              
#> [26,] "1979-05-27"                       
#> [27,] "-----------"                      
#> [28,] "3 jan 2000"                       
#> [29,] "17 april 85"                      
#> [30,] "27/5/1979"                        
#> [31,] "20 01 89"                         
#> [32,] "00/13/10"                         
#> [33,] "-------"                          
#> [34,] "14 12 00"                         
#> [35,] "03:23:22 pm"                      
#>       dObYHMS                          
#>  [1,] ""                               
#>  [2,] ""                               
#>  [3,] ""                               
#>  [4,] ""                               
#>  [5,] ""                               
#>  [6,] ""                               
#>  [7,] ""                               
#>  [8,] ""                               
#>  [9,] ""                               
#> [10,] ""                               
#> [11,] ""                               
#> [12,] ""                               
#> [13,] ""                               
#> [14,] ""                               
#> [15,] ""                               
#> [16,] ""                               
#> [17,] ""                               
#> [18,] "Thu, %d %Ob %Y %H:%M:%S"        
#> [19,] "Thu, %dst of %Ob %Y at %H:%M:%S"
#> [20,] "Thu, %d%Ob %Y at %H:%M:%S"      
#> [21,] "Thu, %d%Ob%Y %H:%M:%S"          
#> [22,] ""                               
#> [23,] "%d %Ob %Y, %H:%M:%S pm"         
#> [24,] ""                               
#> [25,] ""                               
#> [26,] ""                               
#> [27,] ""                               
#> [28,] ""                               
#> [29,] ""                               
#> [30,] ""                               
#> [31,] ""                               
#> [32,] ""                               
#> [33,] ""                               
#> [34,] ""                               
#> [35,] ""                               
#>       dObYHMS                           ObdYH              
#>  [1,] ""                                ""                 
#>  [2,] ""                                ""                 
#>  [3,] ""                                ""                 
#>  [4,] ""                                ""                 
#>  [5,] ""                                ""                 
#>  [6,] ""                                ""                 
#>  [7,] ""                                "%Ob %d %Y at %Hpm"
#>  [8,] ""                                ""                 
#>  [9,] ""                                ""                 
#> [10,] ""                                ""                 
#> [11,] ""                                ""                 
#> [12,] ""                                ""                 
#> [13,] ""                                ""                 
#> [14,] ""                                ""                 
#> [15,] ""                                ""                 
#> [16,] ""                                ""                 
#> [17,] ""                                ""                 
#> [18,] "Thu, %d %Ob %Y %H:%M:%S"         ""                 
#> [19,] "Thu, %dst of %Ob %Y at %H:%M:%S" ""                 
#> [20,] "Thu, %d%Ob %Y at %H:%M:%S"       ""                 
#> [21,] "Thu, %d%Ob%Y %H:%M:%S"           ""                 
#> [22,] ""                                ""                 
#> [23,] "%d %Ob %Y, %H:%M:%S pm"          ""                 
#> [24,] ""                                ""                 
#> [25,] ""                                ""                 
#> [26,] ""                                ""                 
#> [27,] ""                                ""                 
#> [28,] ""                                ""                 
#> [29,] ""                                ""                 
#> [30,] ""                                ""                 
#> [31,] ""                                ""                 
#> [32,] ""                                ""                 
#> [33,] ""                                ""                 
#> [34,] ""                                ""                 
#> [35,] ""                                ""                 
#>       dOmyHMS                          
#>  [1,] ""                               
#>  [2,] ""                               
#>  [3,] ""                               
#>  [4,] ""                               
#>  [5,] ""                               
#>  [6,] ""                               
#>  [7,] ""                               
#>  [8,] ""                               
#>  [9,] ""                               
#> [10,] ""                               
#> [11,] ""                               
#> [12,] ""                               
#> [13,] ""                               
#> [14,] ""                               
#> [15,] ""                               
#> [16,] ""                               
#> [17,] ""                               
#> [18,] "Thu, %d %Om %Y %H:%M:%S"        
#> [19,] "Thu, %dst of %Om %Y at %H:%M:%S"
#> [20,] "Thu, %d%Om %Y at %H:%M:%S"      
#> [21,] "Thu, %d%Om%Y %H:%M:%S"          
#> [22,] "Thu, %d%Om%y %H:%M:%S"          
#> [23,] "%d %Om %Y, %H:%M:%S pm"         
#> [24,] ""                               
#> [25,] ""                               
#> [26,] ""                               
#> [27,] ""                               
#> [28,] ""                               
#> [29,] ""                               
#> [30,] ""                               
#> [31,] ""                               
#> [32,] ""                               
#> [33,] ""                               
#> [34,] ""                               
#> [35,] ""                               
#>       dBYHMS                          
#>  [1,] ""                              
#>  [2,] ""                              
#>  [3,] ""                              
#>  [4,] ""                              
#>  [5,] ""                              
#>  [6,] ""                              
#>  [7,] ""                              
#>  [8,] ""                              
#>  [9,] ""                              
#> [10,] ""                              
#> [11,] ""                              
#> [12,] ""                              
#> [13,] ""                              
#> [14,] ""                              
#> [15,] ""                              
#> [16,] ""                              
#> [17,] ""                              
#> [18,] "Thu, %d %B %Y %H:%M:%S"        
#> [19,] "Thu, %dst of %B %Y at %H:%M:%S"
#> [20,] "Thu, %d%B %Y at %H:%M:%S"      
#> [21,] "Thu, %d%B%Y %H:%M:%S"          
#> [22,] ""                              
#> [23,] ""                              
#> [24,] ""                              
#> [25,] ""                              
#> [26,] ""                              
#> [27,] ""                              
#> [28,] ""                              
#> [29,] ""                              
#> [30,] ""                              
#> [31,] ""                              
#> [32,] ""                              
#> [33,] ""                              
#> [34,] ""                              
#> [35,] ""                              
#>       dbYHMS                          
#>  [1,] ""                              
#>  [2,] ""                              
#>  [3,] ""                              
#>  [4,] ""                              
#>  [5,] ""                              
#>  [6,] ""                              
#>  [7,] ""                              
#>  [8,] ""                              
#>  [9,] ""                              
#> [10,] ""                              
#> [11,] ""                              
#> [12,] ""                              
#> [13,] ""                              
#> [14,] ""                              
#> [15,] ""                              
#> [16,] ""                              
#> [17,] ""                              
#> [18,] "Thu, %d %B %Y %H:%M:%S"        
#> [19,] "Thu, %dst of %B %Y at %H:%M:%S"
#> [20,] "Thu, %d%B %Y at %H:%M:%S"      
#> [21,] "Thu, %d%B%Y %H:%M:%S"          
#> [22,] ""                              
#> [23,] "%d %b %Y, %H:%M:%S pm"         
#> [24,] ""                              
#> [25,] ""                              
#> [26,] ""                              
#> [27,] ""                              
#> [28,] ""                              
#> [29,] ""                              
#> [30,] ""                              
#> [31,] ""                              
#> [32,] ""                              
#> [33,] ""                              
#> [34,] ""                              
#> [35,] ""                              
#>       dmyHMS                           BdYH              
#>  [1,] ""                               ""                
#>  [2,] ""                               ""                
#>  [3,] ""                               ""                
#>  [4,] ""                               ""                
#>  [5,] ""                               ""                
#>  [6,] ""                               ""                
#>  [7,] ""                               "%B %d %Y at %Hpm"
#>  [8,] ""                               ""                
#>  [9,] ""                               ""                
#> [10,] ""                               ""                
#> [11,] ""                               ""                
#> [12,] ""                               ""                
#> [13,] ""                               ""                
#> [14,] ""                               ""                
#> [15,] ""                               ""                
#> [16,] ""                               ""                
#> [17,] ""                               ""                
#> [18,] "Thu, %d %B %Y %H:%M:%S"         ""                
#> [19,] "Thu, %dst of %B %Y at %H:%M:%S" ""                
#> [20,] "Thu, %d%B %Y at %H:%M:%S"       ""                
#> [21,] "Thu, %d%B%Y %H:%M:%S"           ""                
#> [22,] "Thu, %d%B%y %H:%M:%S"           ""                
#> [23,] "%d %b %Y, %H:%M:%S pm"          ""                
#> [24,] ""                               ""                
#> [25,] ""                               ""                
#> [26,] ""                               ""                
#> [27,] ""                               ""                
#> [28,] ""                               ""                
#> [29,] ""                               ""                
#> [30,] ""                               ""                
#> [31,] ""                               ""                
#> [32,] ""                               ""                
#> [33,] ""                               ""                
#> [34,] ""                               ""                
#> [35,] ""                               ""                
#>                           dObYHMS                           dObYHMS 
#>          "%a, %d %Ob %Y %H:%M:%S"  "%a, %dst of %Ob %Y at %H:%M:%S" 
#>                           dObYHMS                           dObYHMS 
#>        "%a, %d%Ob %Y at %H:%M:%S"            "%a, %d%Ob%Y %H:%M:%S" 
#>                           dObYHMS                           dObYHMS 
#>          "%d %Ob %Y, %H:%M:%S pm"          "%a, %d %Ob %Y %H:%M:%S" 
#>                           dObYHMS                           dObYHMS 
#>  "%a, %dst of %Ob %Y at %H:%M:%S"        "%a, %d%Ob %Y at %H:%M:%S" 
#>                           dObYHMS                           dObYHMS 
#>            "%a, %d%Ob%Y %H:%M:%S"          "%d %Ob %Y, %H:%M:%S pm" 
#>                             ObdYH                           dOmyHMS 
#>               "%Ob %d %Y at %Hpm"          "%a, %d %Om %Y %H:%M:%S" 
#>                           dOmyHMS                           dOmyHMS 
#>  "%a, %dst of %Om %Y at %H:%M:%S"        "%a, %d%Om %Y at %H:%M:%S" 
#>                           dOmyHMS                           dOmyHMS 
#>            "%a, %d%Om%Y %H:%M:%S"            "%a, %d%Om%y %H:%M:%S" 
#>                           dOmyHMS                            dBYHMS 
#>          "%d %Om %Y, %H:%M:%S pm"           "%a, %d %B %Y %H:%M:%S" 
#>                            dBYHMS                            dBYHMS 
#>   "%a, %dst of %B %Y at %H:%M:%S"         "%a, %d%B %Y at %H:%M:%S" 
#>                            dBYHMS                            dbYHMS 
#>             "%a, %d%B%Y %H:%M:%S"           "%a, %d %B %Y %H:%M:%S" 
#>                            dbYHMS                            dbYHMS 
#>   "%a, %dst of %B %Y at %H:%M:%S"         "%a, %d%B %Y at %H:%M:%S" 
#>                            dbYHMS                            dbYHMS 
#>             "%a, %d%B%Y %H:%M:%S"           "%d %b %Y, %H:%M:%S pm" 
#>                            dmyHMS                            dmyHMS 
#>           "%a, %d %B %Y %H:%M:%S"   "%a, %dst of %B %Y at %H:%M:%S" 
#>                            dmyHMS                            dmyHMS 
#>         "%a, %d%B %Y at %H:%M:%S"             "%a, %d%B%Y %H:%M:%S" 
#>                            dmyHMS                            dmyHMS 
#>             "%a, %d%B%y %H:%M:%S"           "%d %b %Y, %H:%M:%S pm" 
#>                              BdYH                           dObYHMS 
#>                "%B %d %Y at %Hpm"         "Thu, %d %Ob %Y %H:%M:%S" 
#>                           dObYHMS                           dObYHMS 
#> "Thu, %dst of %Ob %Y at %H:%M:%S"       "Thu, %d%Ob %Y at %H:%M:%S" 
#>                           dObYHMS                           dObYHMS 
#>           "Thu, %d%Ob%Y %H:%M:%S"          "%d %Ob %Y, %H:%M:%S pm" 
#>                           dObYHMS                           dObYHMS 
#>         "Thu, %d %Ob %Y %H:%M:%S" "Thu, %dst of %Ob %Y at %H:%M:%S" 
#>                           dObYHMS                           dObYHMS 
#>       "Thu, %d%Ob %Y at %H:%M:%S"           "Thu, %d%Ob%Y %H:%M:%S" 
#>                           dObYHMS                             ObdYH 
#>          "%d %Ob %Y, %H:%M:%S pm"               "%Ob %d %Y at %Hpm" 
#>                           dOmyHMS                           dOmyHMS 
#>         "Thu, %d %Om %Y %H:%M:%S" "Thu, %dst of %Om %Y at %H:%M:%S" 
#>                           dOmyHMS                           dOmyHMS 
#>       "Thu, %d%Om %Y at %H:%M:%S"           "Thu, %d%Om%Y %H:%M:%S" 
#>                           dOmyHMS                           dOmyHMS 
#>           "Thu, %d%Om%y %H:%M:%S"          "%d %Om %Y, %H:%M:%S pm" 
#>                            dBYHMS                            dBYHMS 
#>          "Thu, %d %B %Y %H:%M:%S"  "Thu, %dst of %B %Y at %H:%M:%S" 
#>                            dBYHMS                            dBYHMS 
#>        "Thu, %d%B %Y at %H:%M:%S"            "Thu, %d%B%Y %H:%M:%S" 
#>                            dbYHMS                            dbYHMS 
#>          "Thu, %d %B %Y %H:%M:%S"  "Thu, %dst of %B %Y at %H:%M:%S" 
#>                            dbYHMS                            dbYHMS 
#>        "Thu, %d%B %Y at %H:%M:%S"            "Thu, %d%B%Y %H:%M:%S" 
#>                            dbYHMS                            dmyHMS 
#>           "%d %b %Y, %H:%M:%S pm"          "Thu, %d %B %Y %H:%M:%S" 
#>                            dmyHMS                            dmyHMS 
#>  "Thu, %dst of %B %Y at %H:%M:%S"        "Thu, %d%B %Y at %H:%M:%S" 
#>                            dmyHMS                            dmyHMS 
#>            "Thu, %d%B%Y %H:%M:%S"            "Thu, %d%B%y %H:%M:%S" 
#>                            dmyHMS                              BdYH 
#>           "%d %b %Y, %H:%M:%S pm"                "%B %d %Y at %Hpm" 

guess_formats(x, c("ymd HMS"), print_matches = TRUE)
#>                                           yOmdHMS             
#>  [1,] "February 20th 1973"                ""                  
#>  [2,] "february  14, 2004"                ""                  
#>  [3,] "Sunday, May 1, 2000"               ""                  
#>  [4,] "Sunday, May 1, 2000"               ""                  
#>  [5,] "february  14, 04"                  ""                  
#>  [6,] "Feb 20th 73"                       ""                  
#>  [7,] "January 5 1999 at 7pm"             ""                  
#>  [8,] "jan 3 2010"                        ""                  
#>  [9,] "Jan 1, 1999"                       ""                  
#> [10,] "jan 3   10"                        ""                  
#> [11,] "01 3 2010"                         ""                  
#> [12,] "1 3 10"                            ""                  
#> [13,] "1 13 89"                           ""                  
#> [14,] "5/27/1979"                         ""                  
#> [15,] "12/31/99"                          ""                  
#> [16,] "DOB:12/11/00"                      ""                  
#> [17,] "-----------"                       ""                  
#> [18,] "Thu, 1 July 2004 22:30:00"         ""                  
#> [19,] "Thu, 1st of July 2004 at 22:30:00" ""                  
#> [20,] "Thu, 1July 2004 at 22:30:00"       ""                  
#> [21,] "Thu, 1July2004 22:30:00"           ""                  
#> [22,] "Thu, 1July04 22:30:00"             ""                  
#> [23,] "21 Aug 2011, 11:15:34 pm"          ""                  
#> [24,] "-----------"                       ""                  
#> [25,] "1979-05-27 05:00:59"               "%Y-%Om-%d %H:%M:%S"
#> [26,] "1979-05-27"                        ""                  
#> [27,] "-----------"                       ""                  
#> [28,] "3 jan 2000"                        ""                  
#> [29,] "17 april 85"                       ""                  
#> [30,] "27/5/1979"                         ""                  
#> [31,] "20 01 89"                          ""                  
#> [32,] "00/13/10"                          ""                  
#> [33,] "-------"                           ""                  
#> [34,] "14 12 00"                          ""                  
#> [35,] "03:23:22 pm"                       ""                  
#>       ymdHMS             
#>  [1,] ""                 
#>  [2,] ""                 
#>  [3,] ""                 
#>  [4,] ""                 
#>  [5,] ""                 
#>  [6,] ""                 
#>  [7,] ""                 
#>  [8,] ""                 
#>  [9,] ""                 
#> [10,] ""                 
#> [11,] ""                 
#> [12,] ""                 
#> [13,] ""                 
#> [14,] ""                 
#> [15,] ""                 
#> [16,] ""                 
#> [17,] ""                 
#> [18,] ""                 
#> [19,] ""                 
#> [20,] ""                 
#> [21,] ""                 
#> [22,] ""                 
#> [23,] ""                 
#> [24,] ""                 
#> [25,] "%Y-%m-%d %H:%M:%S"
#> [26,] ""                 
#> [27,] ""                 
#> [28,] ""                 
#> [29,] ""                 
#> [30,] ""                 
#> [31,] ""                 
#> [32,] ""                 
#> [33,] ""                 
#> [34,] ""                 
#> [35,] ""                 
#>              yOmdHMS               ymdHMS 
#> "%Y-%Om-%d %H:%M:%S"  "%Y-%m-%d %H:%M:%S" 
```
