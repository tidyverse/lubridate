/*
 *  period and duration parser for lubridate
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

#define USE_RINTERNALS 1 // slight increase in speed
#include <Rinternals.h>
#include <stdlib.h>
#include "constants.h"
#include "utils.h"

static const char *en_units[] = {"SECS", "secs", "seconds",
                                 "MINS", "mins", "minutes",
                                 "HOURS", "hours",
                                 "days",
                                 "weeks",
                                 "months",
                                 "years"};
#define N_EN_UNITS 12
#define N_PERIOD_UNITS 7

intUnit parse_period_unit (const char **c) {
  // units: invalid=-1, S=0,  M=1, H=2, d=3, w=4, m=5, y=6
  // SKIP_NON_ALPHANUMS(*c);   //  why this macro doesn't work here?
  while(**c && !(ALPHA(**c) || DIGIT(**c))) (*c)++;;

  intUnit out;
  out.unit = -1;
  out.val = parse_int(c, 100, FALSE);

  if(**c){
    out.unit = parse_alphanum(c, en_units, N_EN_UNITS);
    if (out.unit < 0){
      return out;
    } else {
      // if only unit name supplied, default to 1 units
      if(out.val == -1)
        out.val = 1;
      if(out.unit < 3) out.unit = 0;
      else if (out.unit < 6) out.unit = 1;
      else if (out.unit < 8) out.unit = 2;
      else out.unit = out.unit - 5;
      return out;
    }
  } else {
    return out;
  }
}

void parse_period_1 (const char **c, int ret[N_PERIOD_UNITS]){
  while (**c) {
    intUnit iu = parse_period_unit(c);
    if (iu.unit >= 0) {
      ret[iu.unit] = ret[iu.unit] + iu.val;
    } else {
      ret[0] = NA_INTEGER;
      break;
    }
  }
}

SEXP c_parse_period(SEXP str) {
  if (TYPEOF(str) != STRSXP) error("STR argument must be a character vector");
  int n = LENGTH(str);
  SEXP out = allocVector(INTSXP, n * N_PERIOD_UNITS);
  int *data = INTEGER(out);

  for (int i = 0; i < n; i++) {
    const char *c = CHAR(STRING_ELT(str, i));

    int ret[N_PERIOD_UNITS] = {0};
    parse_period_1(&c, ret);
    int j = i * N_PERIOD_UNITS;
    for(int k = 0; k < N_PERIOD_UNITS; k++) {
      data[j + k] = ret[k];
    }
  }
  return out;
}
