/*
 *  C level Utilities for lubridate
 *
 *  Author: Vitalie Spinu
 *  Copyright (C) 2013--2018  Vitalie Spinu, Garrett Grolemund, Hadley Wickham,
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License as published by the Free
 *  Software Foundation; either version 2 of the License, or (at your option)
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 *  more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, a copy is available at
 *  http://www.r-project.org/Licenses/
 */


#include "constants.h"
#include "utils.h"
#include <stdio.h>
#include <ctype.h>

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

// parse fractional part
double parse_fractional(const char **c) {
  double out = 0.0, factor = 0.1;
  while (DIGIT(**c)) { out = out + (**c - '0')*factor; factor *= 0.1; (*c)++; }
  return out;
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


// Find maximal partial match in `strings`.
//
// Increment *c and return index in 0..(length(strings)-1) if match was found,
// -1 if not. Matching starts from *c, with all non-alpha-numeric characters
// pre-skipped.
//
// - *c: pointer to a character in a C string (incremented by side effect)
// - *stings: pointer to an array of C strings to be matched to
// - strings_len: length of strings array
int parse_alphanum(const char **c, const char **strings, const int strings_len, const char ignore_case){

  // tracking array: all valid objects are marked with 1, invalid with 0
  int track[strings_len];
  for (int i = 0; i < strings_len; i++){
    track[i] = 1;
  }

  int j = 0, out = -1, good_tracks = strings_len;
  while (**c && !ALPHA(**c) && !DIGIT(**c)) (*c)++;

  while (**c && good_tracks) {
    // stop when all tracks have been exhausted
    for (int i = 0; i < strings_len; i++){

      // keep going while at least one valid track
      if (track[i]){

        if (strings[i][j]) {
          if (**c == strings[i][j] || (ignore_case && (tolower(**c) == strings[i][j]))) {
            out = i;
          } else { // invalidate track i if not matching
            track[i] = 0;
            good_tracks--;
          }
        } else { // reached to the end of string i; return it if the last track
          good_tracks--;
          out = i;
        }
      }
    }
    if (good_tracks) {
      (*c)++;
      j++;
    }
  }
  return out;
}
