
// start of each month in seconds in a common year (1 indexed)
static const int sm[] = {0, 0, 2678400, 5097600, 7776000, 10368000, 13046400, 15638400,
						 18316800, 20995200, 23587200, 26265600, 28857600, 31536000 };
// days in months
static const int mdays[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
// seconds in a day: 24*60*60
static const int daylen = 86400;
// seconds between 2000-01-01 and 1970-01-01
static const int d30 = 946684800; 
// need 64 type to avoid overflow on integer multiplication
// int64_t from stdint.h is a bit slower
// potential problem: is long long 64 bit on all machines?
static const long long yearlen = 31536000; // common year in sec: 365*24*60*60

// leap year every 400 years; no leap every 100 years
#define LEAP(y) (y % 4 == 0) && !(y % 100 == 0 && y % 400 != 0);

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
