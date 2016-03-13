#include "constants.h"

// return adjustment (in seconds) due to leap years
// y: years after (positive) or before (negative) 2000-01-01 00:00:00
int adjust_leap_years(int y, int m, int is_leap){
  int SECS = 0;

  if ( y >= 0 ){
	// ordinary leap days after 2000-01-01 00:00:00
	SECS += ( y / 4 ) * daylen + daylen;
	if( y > 99 )
	  SECS += (y / 400 - y / 100) * daylen;
	// adjust if within a leap year
	if ( is_leap && m < 3 )
	  SECS -= daylen;
  } else {
	SECS += (y / 4) * daylen;
	if( y < -99 )
	  SECS += (y / 400 - y / 100) * daylen;
	if ( is_leap && m > 2 )
	  SECS += daylen;
  }

  return SECS;
}

// check if y, m, d make sense
int check_ymd(int y, int m, int d, int is_leap){

  int succeed = 1;

  if ( m == 2 ){
	// no check for d > 0 because we allow missing days in parsing
	if ( is_leap )
	  succeed = d < 30;
	else
	  succeed = d < 29;
  } else {
	succeed = d <= mdays[m];
  }

  return succeed;
}
