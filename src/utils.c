#include "constants.h"
#include "utils.h"
#include <stdio.h>

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

/* parse N digit characters from **c. Return parsed non-negative integer. If
   failed to pass N chars, return -1.*/
int parse_int (const char **c, const int N, const int strict) {
  int tN = N, X = 0;
  while (DIGIT(**c) && tN > 0) {
    X = X * 10 + (**c - '0');
    (*c)++;
    tN--;
  }
  if (strict && tN > 0) return -1; // not all numbers have been consumed
  else if (tN == N) return -1; // no parsing happened
  else return X;
}


// Increment **c and return index in 0..length(strings) if match was found, -1
// if not.
//
// - **c: pointer to a character in a C string (automatically incremented)
// - *stings: pointer to an array of C strings to be matched to.
// - strings_len: length of strings array.
int parse_alphanum(const char **c, const char **strings, const int strings_len){

  // tracking array: all valid objects are marked with 1, invalid with 0
  int track[strings_len];
  for (int i = 0; i < strings_len; i++){
    track[i] = 1;
  }

  int j = 0, go = 1, out = -1;
  while (**c && !ALPHA(**c)) (*c)++;

  while (**c && go) {
    // stop when all tracks where exhausted
    go = 0;
    for (int i = 0; i < strings_len; i++){
      if (track[i]){
        // keep going while at least one valid track
        if (strings[i][j]){
          if(**c == strings[i][j]){
            out = i;
            go = 1;
          } else {
            // invalidate track i if not matching
            track[i] = 0;
          }
        } else {
          // reached to the end of string i; return it
          go = 0;
          out = i;
          break;
        }
      }
    }
    if(go){
      (*c)++;
      j++;
    }
  }
  if (out >= 0) return out;
  else return -1;
}
