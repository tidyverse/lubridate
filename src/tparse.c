/*
 *  time date parser for lubridate
 *  Author: Vitalie Spinu
 *  Copyright (C) 2013--2016  Vitalie Spinu, Garrett Grolemund, Hadley Wickham,
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

/* Comments:

   See the parse_date_time2 and fast_strptime in lubridate for how to use
   parse_dt from R code.

   See R function .parse_hms for how to use parse_hms.
*/

#define USE_RINTERNALS 1 // slight increase in speed
#include <Rinternals.h>
#include <stdlib.h>
#include "constants.h"
#include "utils.h"

/* quick way to check if the first char is a digit */
#define DIGIT(X) ((X) >= '0' && (X) <= '9')
/* parse N characters from *c into integer X */
#define PARSENUM(X, N) tN = N; while ( DIGIT(*c) && tN > 0) { X = X * 10 + (*c - '0'); c++; tN--; }
static const char ltnames [][5] = {"sec", "min", "hour", "mday", "mon", "year"};


SEXP parse_dt(SEXP str, SEXP ord, SEXP formats,  SEXP lt) {
  // STR: character vector of date-times.
  // ORD: formats (as in strptime) or orders (as in parse_date_time)
  // FORMATS: TRUE if ord is a string of formats (as in strptime)
  // LT: TRUE - return POSIXlt type list, FALSE - return POSIXct seconds

  if ( !isString(str) ) error("Date-time must be a character vector");
  if ( !isString(ord) || (LENGTH(ord) > 1))
    error("Format argument must be a character vector of length 1");

  R_len_t tN, n = LENGTH(str);
  int is_fmt = *LOGICAL(formats);
  int out_lt = *LOGICAL(lt);

  SEXP oYEAR, oMONTH, oDAY, oHOUR, oMIN, oSEC;

  if(out_lt){
    oYEAR  = PROTECT(allocVector(INTSXP, n));
    oMONTH = PROTECT(allocVector(INTSXP, n));
    oDAY   = PROTECT(allocVector(INTSXP, n));
    oHOUR  = PROTECT(allocVector(INTSXP, n));
    oMIN   = PROTECT(allocVector(INTSXP, n));
    oSEC   = PROTECT(allocVector(REALSXP, n));
  } else {
    oSEC = PROTECT(allocVector(REALSXP, n));
  }

  const char *O = CHAR(STRING_ELT(ord, 0));

  for (int i = 0; i < n; i++) {

    const char *c = CHAR(STRING_ELT(str, i));
    const char *o = O;

    double secs = 0.0; // only accumulator for POSIXct case
    int y = 0, m = 0, d = 0, H = 0, M = 0 , S = 0;
    int succeed = 1, O_format=0; // control booleans

    // read order/format character by character
    while( *o && succeed ) {

      if( is_fmt && (*o != '%')) {
        // with fmt: non formatting characters should match exactly
        if ( *c == *o ) { c++; o++; } else succeed = 0;

      } else {

        if ( is_fmt ){
          o++; // skip %
        } else if ( *o != 'O' && *o != 'z' ) {
          // O and z formats are treated specially below
          while (*c && !DIGIT(*c)) c++; // skip non-digits
		}

        if ( *o == 'O' ) {
          // Special two letter orders/formats:
		  // Ou (Z), Oz (-0800), OO (-08:00) and Oo (-08)
          O_format = 1;
          o++;
        } else {
		  O_format = 0;
		}

        if (!(DIGIT(*c) || O_format || *o == 'z')) {
          succeed = 0;
        } else {

          switch( *o ) {
          case 'Y': // year in yyyy format
            PARSENUM(y, 4);
            break;
          case 'y': // year in yy format
            PARSENUM(y, 2);
			if (y <= 68)
			  y += 2000;
			else
			  y += 1900;
            break;
          case 'm': // month
            PARSENUM(m, 2);
            if (!(0 < m && m < 13)) succeed = 0;
            break;
          case 'd': // day
            PARSENUM(d, 2);
            if (!(0 < d && d < 32)) succeed = 0;
            break;
          case 'H': // hour 24
            PARSENUM(H, 2);
            if (H > 23) succeed = 0;
            break;
          case 'M': // minute
            PARSENUM(M, 2);
            if ( M > 59 ) succeed = 0;
            break;
          case 'S': // second
            if( O_format && !is_fmt ){
              while (*c && !DIGIT(*c)) c++;
              if ( !*c ) {
                succeed = 0;
                break;
              }
            }
            PARSENUM(S, 2);
            if ( S < 62 ){ // allow leap seconds
              secs += S;
              if( O_format ){
                // Parse milliseconds; both . and , as decimal separator are allowed
                if( *c == '.' || *c == ','){
                  double ms = 0.0, msfact = 0.1;
                  c++;
                  while (DIGIT(*c)) { ms = ms + (*c - '0')*msfact; msfact *= 0.1; c++; }
                  secs += ms;
                }
              }
            } else succeed = 0;
            break;
		  // special treatment of %O_ and %z follows
		  case 'u':
			// %Ou: "2013-04-16T04:59:59Z"
            if( O_format )
              if( *c == 'Z' || *c == 'z') c++;
              else succeed = 0;
            else succeed  = 0;
            break;
          case 'z':
            // for %z: "+O100" or "+O1" or "+01:00"
            if( !O_format ){
              if( !is_fmt ) {
                while (*c && *c != '+' && *c != '-' && *c != 'Z') c++; // skip non + -
                if( !*c ) { succeed = 0; break; };
              }
              int Z = 0, sig;
              if( *c == 'Z') {c++; break;}
              else if ( *c == '+' ) sig = -1;
              else if ( *c == '-') sig = 1;
              else { succeed = 0; break; }
              c++;
              PARSENUM(Z, 2);
              secs += sig*Z*3600;
              if( *c == ':' ){
                c++;
                if ( !DIGIT(*c) ){ succeed = 0; break; }
              }
              if( DIGIT(*c) ){
                Z = 0;
                PARSENUM(Z, 2);
                secs += sig*Z*60;
              }
              break;
            } // else %Oz: "+0100". Pass through.
          case 'O':
            // %OO: "+01:00"
          case 'o':
            // %Oo: "+01"
            if( O_format ){
              while (*c && *c != '+' && *c != '-' ) c++; // skip non + -
              int Z = 0, sig;
              if ( *c == '+' ) sig = -1;
              else if ( *c == '-') sig = 1;
              else { succeed = 0; break; }
              c++;
              PARSENUM(Z, 2);
              secs += sig*Z*3600;
              if( *o == 'O'){
                if ( *c == ':') c++;
				else { succeed = 0; break; }
			  }
              if ( *o != 'o' ){
                Z = 0;
                PARSENUM(Z, 2);
                secs += sig*Z*60;
              }
            } else error("Unrecognized format '%c' supplied", *o);
            break;
          default:
            error("Unrecognized format %c supplied", *o);
          }

          o++;
        }
      }
    }

    // skip all remaining non digits
    if( !is_fmt )
      while (*c && !DIGIT(*c)) c++;

    // If at least one subparser hasn't finished it's a failure.
    if ( *c || *o ) succeed = 0;

    int is_leap;

    if (succeed) {
      // leap year every 400 years; no leap every 100 years
      is_leap = IS_LEAP(y);

      // check month
      if (m == 2){
		// no check for d > 0 because we allow missing days in parsing
        if (is_leap)
          succeed = d < 30;
        else
          succeed = d < 29;
      } else {
		succeed = d <= mdays[m];
      }
    }

    if (succeed ) {
      if(out_lt){

        INTEGER(oYEAR)[i] = y - 1900;
        INTEGER(oMONTH)[i] = m - 1;
        INTEGER(oDAY)[i] = d;
        INTEGER(oHOUR)[i] = H;
        INTEGER(oMIN)[i] = M;
        REAL(oSEC)[i] = secs;

      } else {

        secs += sm[m];
        secs += (d - 1) * 86400;
        secs += H * 3600;
        secs += M * 60;
        // process leap years
        y -= 2000;
        secs += y * yearlen;
        secs += adjust_leap_years(y, m, is_leap);

        REAL(oSEC)[i] = secs + d30;
      }

    } else {
      if(out_lt){
        INTEGER(oYEAR)[i] = NA_INTEGER;
        INTEGER(oMONTH)[i] = NA_INTEGER;
        INTEGER(oDAY)[i] = NA_INTEGER;
        INTEGER(oHOUR)[i] = NA_INTEGER;
        INTEGER(oMIN)[i] = NA_INTEGER;
        REAL(oSEC)[i] = NA_REAL;
      } else {
        REAL(oSEC)[i] = NA_REAL;
      }
    }
  }

  if (out_lt){
    SEXP names, out;
    PROTECT(names = allocVector(STRSXP, 6));
    for(int i = 0; i < 6; i++)
      SET_STRING_ELT(names, i, mkChar(ltnames[i]));
    PROTECT(out = allocVector(VECSXP, 6));
    SET_VECTOR_ELT(out, 0, oSEC);
    SET_VECTOR_ELT(out, 1, oMIN);
    SET_VECTOR_ELT(out, 2, oHOUR);
    SET_VECTOR_ELT(out, 3, oDAY);
    SET_VECTOR_ELT(out, 4, oMONTH);
    SET_VECTOR_ELT(out, 5, oYEAR);
    setAttrib(out, R_NamesSymbol, names);
    UNPROTECT(8);
    return out;
  } else {
    UNPROTECT(1);
    return oSEC;
  }

}



// STR: string in HxMyS format where x and y are arbitrary non-numeric separators
// ORD: orders. Can be any combination of "h", "m" and "s"
// RETURN: numeric vector (H1 M1 S1 H2 M2 S2 ...)
SEXP parse_hms(SEXP str, SEXP ord) {

  if (TYPEOF(str) != STRSXP) error("HMS argument must be a character vector");
  if ((TYPEOF(ord) != STRSXP) || (LENGTH(ord) > 1))
    error("Orders vector must be a character vector of length 1");

  int n = LENGTH(str);
  int len = 3*n;
  const char *O = CHAR(STRING_ELT(ord, 0));
  SEXP res;
  double *data;
  res = allocVector(REALSXP, len);
  data = REAL(res);

  for (int i = 0; i < n; i++) {

    const char *c = CHAR(STRING_ELT(str, i));
    const char *o = O;
    int H=0, M=0, j=i*3;
    double S=0.0;
    while (*c && !DIGIT(*c)) c++;

    if (DIGIT(*c)) {

      while( *o ){

        switch( *o ) {

        case 'H':
          if(!DIGIT(*c)) {data[j] = NA_REAL; break;}
          while ( DIGIT(*c) ) { H = H * 10 + (*c - '0'); c++; }
          data[j] = H;
          break;
        case 'M':
          if(!DIGIT(*c)) {data[j+1] = NA_REAL; break;}
          while ( DIGIT(*c) ) { M = M * 10 + (*c - '0'); c++; }
          data[j+1]=M;
          break;
        case 'S':
          if(!DIGIT(*c)) {data[j+2] = NA_REAL; break;}
          while ( DIGIT(*c) ) { S = S * 10 + (*c - '0'); c++; }
          // both . and , as decimal Seconds separator are allowed
          if( *c == '.' || *c == ','){
            double ms = 0.0, msfact = 0.1;
            c++;
            while (DIGIT(*c)) { ms = ms + (*c - '0')*msfact; msfact *= 0.1; c++; }
            S += ms;
          }
          data[j+2] = S;
          break;
        default:
          error("Unrecognized format %c supplied", *o);
        }

        while (*c && !DIGIT(*c)) c++;

        o++;
      }
    }

    // unfinished parsing, return NA
    if ( *c || *o ){
      data[j] = NA_REAL;
      data[j+1] = NA_REAL;
      data[j+2] = NA_REAL;
    }
  }
  return res;
}
