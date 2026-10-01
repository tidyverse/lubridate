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

// Single-letter ISO 8601 designators, as indices into EN_UNITS: S, M, H, D, W,
// M, Y and the ambiguous M (16).
static inline int is_designator(int i) {
  return i == 0 || i == 3 || i == 6 || i == 8 || i == 10 || i == 12 ||
         i == 14 || i == 16;
}

fractionUnit parse_period_unit(const char **c) {
  // assumes we are at the beg of a alpha-numeric input
  // units: invalid=-1, S=0,  M=1, H=2, d=3, w=4, m=5, y=6
  while(**c && !(ALPHA(**c) || DIGIT(**c) || **c == '.')) (*c)++;

  fractionUnit out;
  out.unit = -1;
  out.has_num = 0;
  out.designator = 0;
  if (**c) {
    out.val = parse_int(c, 100, FALSE);
    out.has_num = out.val != -1;
    if (**c == '.') {
      (*c)++;
      // allow fractions without leading 0
      if (out.val == -1)
        out.val = 0;
      const char *frac = *c;
      out.fraction = parse_fractional(c);
      // "1." and ".5" are numbers, a lone "." (as in ".h") is not
      if (*c == frac && !out.has_num)
        return out;
      out.has_num = 1;
    } else {
      out.fraction = 0.0;
    }
  }

  if (**c) {
    out.unit = parse_alphanum(c, EN_UNITS, N_EN_UNITS, 0);
    if (out.unit < 0 || out.unit > 16) {
      return out;
    } else {
      out.designator = is_designator(out.unit);
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
  int P = 0; // in the ISO date part, where M is months
  int iso = 0; // an ISO 'P' has been seen
  int T = 0; // an ISO 'T' still awaits its first component
  int seen = 0; // bit per unit: ISO designators used so far
  int parsed1 = 0;
  while (**c) {
    fractionUnit fu = parse_period_unit(c);
    /* Rprintf("P:%d UNIT:%d\n", P, fu.unit); */
    if (fu.unit >= 0) {
      if (fu.unit == 17) { // ISO P
        P = 1;
        iso = 1;
      } else if (fu.unit == 18) { // ISO T
        // T follows a P or a component ("PT1H", "10DT10M"), never another T,
        // and must be followed by a component
        if (T || (!iso && !parsed1)) {
          ret[0] = NA_REAL;
          return;
        }
        P = 0;
        T = 1;
      } else {
        if (fu.unit == 16) { // month or minute
          fu.unit = P ? 5 : 1;
        }
        if (iso && fu.designator) {
          // an ISO designator needs a number and may occur only once
          int bit = 1 << fu.unit;
          if (!fu.has_num || (seen & bit)) {
            ret[0] = NA_REAL;
            return;
          }
          seen |= bit;
          // an hours or seconds designator before 'T' ("P2H30M") starts the
          // time part, so a later M is minutes, not months
          if (P && (fu.unit == 2 || fu.unit == 0))
            P = 0;
        }
        parsed1 = 1;
        T = 0;
        ret[fu.unit] += fu.val;
        if (fu.fraction > 0) {
          if (fu.unit == 0) ret[fu.unit] += fu.fraction;
          else ret[0] += fu.fraction * SECONDS_IN_ONE[fu.unit];
        }
      }
    } else {
      ret[0] = NA_REAL;
      break;
    }

    while (**c && !(ALPHA(**c) || DIGIT(**c) || **c == '.')) {
      /* Rprintf("c=%c\n", **c); */
      if (**c == '(') {
        // skip till closing ')' to allow for as.duration round-trip #1005;
        // nothing nests there, so a second '(' is malformed
        (*c)++;
        while (**c && **c != ')') {
          if (**c == '(') {
            ret[0] = NA_REAL;
            return;
          }
          (*c)++;
        }
        if (**c) (*c)++; // step over ')' but never past the terminator
      } else {
        (*c)++;
      }
    }
  }

  if (!parsed1 || T) {
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
    const char *c = CHAR(STRING_ELT(str, i));
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
