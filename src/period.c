/*
 *  Period and Duration Parser for lubridate
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

#define USE_RINTERNALS 1 // slight increase in speed
#include <Rinternals.h>
#include <stdlib.h>
#include "constants.h"
#include "utils.h"

static const char *EN_UNITS[] = {"S", "secs", "seconds",
                                 "M", "mins", "minutes",
                                 "H", "hours",  // 6
                                 "D", "days",   // 8
                                 "W", "weeks",  // 10
                                 "M", "months", // 12
                                 "Y", "years",  // 14
                                 // ISO period delimiters
                                 "M",           // 16
                                 "P",           // 17
                                 "T"            // 18
};
#define N_EN_UNITS 19

// S=0,  M=1, H=2, d=3, w=4, m=5, y=6

static const char *PERIOD_UNITS[] = {"seconds", "minutes", "hours",
                                     "days", "weeks", "months", "years"};
#define N_PERIOD_UNITS 7

// A '-', '+' or U+2212 MINUS SIGN (UTF-8 E2 88 92, which ISO 8601 uses) is a
// sign only when it immediately precedes a number or the ISO 'P' designator
// ("-PT30M", "PT-0.5H", "-1 day"). Elsewhere it is a separator. Returns the
// sign's length in bytes, or 0.
static inline int sign_len(const char *c) {
  int len = 0;
  if (*c == '-' || *c == '+')
    len = 1;
  else if ((unsigned char)c[0] == 0xE2 && (unsigned char)c[1] == 0x88 &&
           (unsigned char)c[2] == 0x92)
    len = 3;
  if (len && (DIGIT(c[len]) || c[len] == '.' || c[len] == 'P'))
    return len;
  return 0;
}

static inline int is_sign(const char *c) {
  return sign_len(c) > 0;
}

static inline int at_token(const char *c) {
  return ALPHA(*c) || DIGIT(*c) || *c == '.' || is_sign(c);
}

fractionUnit parse_period_unit(const char **c) {
  // assumes we are at the beg of a alpha-numeric input
  // units: invalid=-1, S=0,  M=1, H=2, d=3, w=4, m=5, y=6
  while(**c && !at_token(*c)) (*c)++;

  fractionUnit out;
  out.unit = -1;
  out.sign = 1;
  int slen = sign_len(*c);
  if (slen) {
    if (**c != '+') out.sign = -1;
    *c += slen;
  }
  if (**c) {
    out.val = parse_int(c, 100, FALSE);
    if (**c == '.') {
      (*c)++;
      // allow fractions without leading 0
      if (out.val == -1)
        out.val = 0;
      out.fraction = parse_fractional(c);
    } else {
      out.fraction = 0.0;
    }
  }

  if (**c) {
    out.unit = parse_alphanum(c, EN_UNITS, N_EN_UNITS, 0);
    if (out.unit < 0 || out.unit > 16) {
      return out;
    } else {
      // if only unit name supplied, default to 1 units
      if (out.val == -1)
        out.val = 1;
      if (out.unit < 3)
        out.unit = 0; // seconds
      else if (out.unit < 6)
        out.unit = 1; // minutes
      else if (out.unit < 16)
        out.unit = (out.unit - 6) / 2 + 2;
      return out;
    }
  } else {
    return out;
  }
}

void parse_period_1 (const char **c, double ret[N_PERIOD_UNITS]){
  int P = 0; // ISO period flag
  // A sign before the ISO 'P' ("-P1DT2H") negates every component after it; a
  // sign on one component ("P1DT-2H") negates that component only. The two
  // multiply, so "-PT-30M" is +30 minutes.
  int Psign = 1;
  int parsed1 = 0;
  while (**c) {
    fractionUnit fu = parse_period_unit(c);
    /* Rprintf("P:%d UNIT:%d\n", P, fu.unit); */
    if (fu.unit >= 0) {
      if (fu.unit == 17) { // ISO P
        P = 1;
        Psign = fu.sign;
      } else if (fu.unit == 18) { // ISO T
        P = 0;
      } else {
        if (fu.unit == 16) { // month or minute
          fu.unit = P ? 5 : 1;
        }
        parsed1 = 1;
        int sign = Psign * fu.sign;
        ret[fu.unit] += sign * fu.val;
        if (fu.fraction > 0) {
          if (fu.unit == 0) ret[fu.unit] += sign * fu.fraction;
          else ret[0] += sign * fu.fraction * SECONDS_IN_ONE[fu.unit];
        }
      }
    } else {
      ret[0] = NA_REAL;
      break;
    }

    while (**c && !at_token(*c)) {
      /* Rprintf("c=%c\n", **c); */
      if (**c == '(') {
        // skip till closing ')' to allow for as.duration round-trip #1005
        while (**c && **c != ')')
          (*c)++;
        (*c)++;
      } else {
        (*c)++;
      }
    }
  }

  if (!parsed1) {
    ret[0] = NA_REAL;
  }
}

SEXP period_names(void) {
  SEXP names = PROTECT(allocVector(STRSXP, N_PERIOD_UNITS));
  for (int i = 0; i < N_PERIOD_UNITS; i++) {
     SET_STRING_ELT(names, i, mkChar(PERIOD_UNITS[i]));
  }
  UNPROTECT(1);
  return names;
}

SEXP C_parse_period(SEXP str) {

  if (TYPEOF(str) != STRSXP) error("STR argument must be a character vector");

  int n = LENGTH(str);

  // store parsed units in a N_PERIOD_UNITS x n matrix
  SEXP out = PROTECT(allocMatrix(REALSXP, N_PERIOD_UNITS, n));
  double *data = REAL(out);

  for (int i = 0; i < n; i++) {
    // UTF-8 so that U+2212 is recognised whatever the input encoding
    const char *c = translateCharUTF8(STRING_ELT(str, i));
    double ret[N_PERIOD_UNITS] = {0};
    parse_period_1(&c, ret);
    int j = i * N_PERIOD_UNITS;
    for(int k = 0; k < N_PERIOD_UNITS; k++) {
      data[j + k] = ret[k];
    }
  }

  // Not adding names as mat[i, ] retains names when mat is a single column, thus
  // requiring additional pre-processing at R level

  /* SEXP dimnames = PROTECT(allocVector(VECSXP, 2)); */
  /* SET_VECTOR_ELT(dimnames, 0, period_names()); */
  /* SET_VECTOR_ELT(dimnames, 1, R_NilValue); */
  /* setAttrib(out, R_DimNamesSymbol, dimnames); */

  UNPROTECT(1);

  return out;
}
