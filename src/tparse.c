#define USE_RINTERNALS 1 // 4% speed improvement
#include <Rinternals.h>
#include <stdlib.h>
/* #include <stdint.h> */

// start of each month in seconds in a common year
static const int sm[] = { 0, 0, 2678400, 5097600, 7776000, 10368000, 13046400, 15638400,
                          18316800, 20995200, 23587200, 26265600, 28857600, 31536000 };
static const int daylen = 86400; // day in seconds: 24*60*60
static const int d30 = 946684800; // seconds between 2000-01-01 and 1970-01-01
// need 64 type to avoid overflow on integer multiplication
// potential problem: is long long 64 bit on all machines?
// int64_t from stdint.h is a bit slower
static const long long yearlen = 31536000; // common year in sec: 365*24*60*60

/* quick way to check if the first char is a digit */
#define DIGIT(X) ((X) >= '0' && (X) <= '9')
#define PARSENUM(X) while (DIGIT(*c)) { X = X * 10 + (*c - '0'); c++; }

// originally inspired by Simon Urbanek fasttime package
SEXP parse_dt(SEXP str, SEXP ord) {

  if (TYPEOF(str) != STRSXP) Rf_error("Date-time must be a character vector");
  if ((TYPEOF(ord) != STRSXP) || (LENGTH(ord) > 1))
    Rf_error("Orders vector must be a character vector of length 1");

  int i, n = LENGTH(str);
  const char *O = CHAR(STRING_ELT(ord, i));

  SEXP res;
  double *data;

  res = Rf_allocVector(REALSXP, n);
  data = REAL(res);

  for (i = 0; i < n; i++) {

    const char *c = CHAR(STRING_ELT(str, i));
    const char *o = O;

    int y = 0, m = 0, d = 0, H = 0, M = 0 , S = 0;
    int succeed = 1, leap = 0;
    double secs = 0.0; // main accumulator

    // skip all leading non-digits
    while (*c && !DIGIT(*c)) c++;

    if (DIGIT(*c)) {

      while( *o && succeed ){
        switch( *o ) {
        case 'Y': // year in yyyy format
          PARSENUM(y)
          break;
        case 'y': // year in yy format
          PARSENUM(y)
          // we allow yyyy years, but interpret yy as > 2000
          if (y < 100) y += 2000;
          break;
        case 'm': // month
          PARSENUM(m)
          if (0 < m < 13) secs += sm[m];
          else succeed = 0;
          break;
        case 'd': // day
          PARSENUM(d)
          if ( d < 32 ) secs += (d - 1) * 86400;
          else succeed = 0;
          break;
        case 'H': // hour 24
          PARSENUM(H)
          if( H < 25 ) secs += H * 3600;
          else  succeed = 0;
          break;
        case 'M': // minute
          PARSENUM(M)
          if ( M < 61 ) secs += M * 60;
          else succeed = 0;
          break;
        case 'S':
          PARSENUM(S)
          // allow leap seconds
          if ( S < 62 ){
            secs += S;
            // both . and , as decimal separator are allowed
            if( *c == '.' || *c == ','){
              double ms = 0.0, msfact = 0.1;
              c++;
              while (DIGIT(*c)) { ms = ms + (*c - '0')*msfact; msfact *= 0.1; c++; }
              secs += ms;
            }
          } else succeed = 0;
          break;
        default:
          Rf_error("Unrecognized format %c supplied", *o);
        }
        while (*c && !DIGIT(*c)) c++;
        *o++;
      }

      if ( succeed ){

        y -= 2000;
        secs += y * yearlen;

        // leap year every 400 years; no leap every 100 years
        int leap4 = y % 4 == 0;
        int skip100leap = leap4 && y % 100 == 0 && y % 400 != 0;

        if ( y >= 0 ){
          // ordinary leap days before 2000-01-01 00:00:00
          secs += ( y / 4 ) * daylen + daylen;
          if( y > 99 )
            secs += (y / 400 - y / 100) * daylen;
          // adjust if within leap year
          if ( leap4 && m < 3 && !skip100leap )
            secs -= daylen;

        } else {
          secs += (y / 4) * daylen;
          if( y < -99 )
            secs += (y / 400 - y / 100) * daylen;
          if ( leap4 && m > 2 && !skip100leap )
            secs += daylen;
        }

        data[i] = secs + d30;

      } else {
        data[i] = NA_REAL;
      }
    }
  }
  return res;
}

SEXP parse_hms(SEXP str, SEXP parseh, SEXP parses) {
  // STR: character vector
  // parseh: logical, shall we parse hour (FALSE for ms parser)
  // parses: logical, shall we parse second (FALSE for hm parser)
  // RETURN: numeric vector (H1 M1 S1 H2 M2 S2 ...)
  SEXP res;
  double *tsv;
  int n, i, doh = asLogical(parseh), dos = asLogical(parses);
  n = LENGTH(str);
  if (!(TYPEOF(str) == STRSXP)) Rf_error("argument must be of type character");
  res = Rf_allocVector(REALSXP, n*3);
  tsv = REAL(res);
  for (i = 0; i < n*3; i++) tsv[i]=NA_REAL;
  for (i = 0; i < n; i++) {
    double s = 0.0;
    int h = 0, m = 0, j=i*3;
    const char *c = CHAR(STRING_ELT(str, i));
    // ignore first non-digits
    while (*c && !DIGIT(*c)) { c++; }
    if (DIGIT(*c)) {
      if(doh){
        while (DIGIT(*c)) { h = h * 10 + (*c - '0'); c++; }
        tsv[j]=h;
      }
      while (*c && !DIGIT(*c)) c++;
      if (*c) {
        while (DIGIT(*c)) { m = m * 10 + (*c - '0'); c++; }
        tsv[j+1]=m;
        c++;
        if(dos){
          while (*c && !(DIGIT(*c) || *c == '.')) c++;
          if (*c) {
            s += atof(c);
            tsv[j+2]=s;

          }
        }
      }
    }
  }
  return res;
}
