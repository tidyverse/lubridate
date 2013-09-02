
#define USE_RINTERNALS 1

#include <Rinternals.h>
#include <stdlib.h>

#define DIGIT(X) ((X) >= '0' && (X) <= '9')

/* start of each month in seconds */
static const int cml[] = { 0, 0, 2678400, 5097600, 7776000, 10368000, 13046400, 15638400,
			   18316800, 20995200, 23587200, 26265600, 28857600, 31536000 };

SEXP parse_hms(SEXP str, SEXP parseh, SEXP parses) {
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


SEXP parse_ts(SEXP str, SEXP sRequiredComp) {
  /* Adapted from package: fasttime */
  /* Version: 1.0-0 */
  /* Title: Fast utility function for time parsing and conversion */
  /* Author: Simon Urbanek <simon.urbanek@r-project.org> */
  /* Description: This package provides fast functions for timestamp */
  /* manipulation that avoid system calls and take shortcuts */
  /* to facilitate operations on very large data. */
  /* License: GPL-2 */
  /* URL: http://www.rforge.net/fasttime */

  /* I (Vitalie) made a slight modification to allow for "." as field
     separator. */

  /* VS[01-09-2013]: todo: also handle zulu timezones here */
  /* ## %Ou: "2013-04-16T04:59:59Z" */
  /* ## %Oo: "2013-04-16T04:59:59+01" */
  /* ## %Oz: "2013-04-16T04:59:59+0100" */
  /* ## %OO: "2013-04-16T04:59:59+01:00" */

  SEXP res;
  double *tsv;
  int required_components = Rf_asInteger(sRequiredComp);
  int n, i;
  if (TYPEOF(str) != STRSXP) Rf_error("invalid timestamp vector");
  n = LENGTH(str);
  res = Rf_allocVector(REALSXP, n);
  tsv = REAL(res);
  for (i = 0; i < n; i++) {
    const char *c = CHAR(STRING_ELT(str, i));
    int comp = 0;
    if (DIGIT(*c)) {
      double ts = 0.0;
      int y = 0, m = 0, d = 0, h = 0, mi = 0;
      while (DIGIT(*c)) { y = y * 10 + (*c - '0'); c++; }
      if (y < 100) y += 2000;
      y -= 1970;
      if (y >= 0) {
        ts += ((int)((y + 1) / 4)) * 86400;
        ts += y * 31536000;
        comp++;
        while (*c && !DIGIT(*c)) c++;
        if (*c) {
          while (DIGIT(*c)) { m = m * 10 + (*c - '0'); c++; }
          if (m > 0 && m < 13) {
            ts += cml[m];
            if (m > 2 && (y & 3) == 2) ts += 86400;
            comp++;
            while (*c && !DIGIT(*c)) c++;
            if (*c) {
              while (DIGIT(*c)) { d = d * 10 + (*c - '0'); c++; }
              if (d > 1) ts += (d - 1) * 86400;
              comp++;
              while (*c && !DIGIT(*c)) c++;
              if (*c) {
                while (DIGIT(*c)) { h = h * 10 + (*c - '0'); c++; }
                ts += h * 3600;
                comp++;
                while (*c && !DIGIT(*c)) c++;
                if (*c) {
                  while (DIGIT(*c)) { mi = mi * 10 + (*c - '0'); c++; }
                  ts += mi * 60;
                  comp++;
                  c++;
                  while (*c && !(DIGIT(*c) || *c == '.')) c++;
                  if (*c) {
                    ts += atof(c);
                    comp++;
                  }
                }
              }
            }
          }
        }
      }
      if (comp >= required_components)
        tsv[i] = ts;
    }
  }
  return res;
}

