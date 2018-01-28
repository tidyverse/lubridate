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


#ifndef LUB_UTILS_H
#define LUB_UTILS_H

typedef struct {
  int  val;
  int unit;
} intUnit;

typedef struct {
  int  val;
  double fraction;
  int unit;
} fractionUnit;

// leap year every 400 years; no leap every 100 years
#define IS_LEAP(y) (((y) % 4 == 0) && !((y) % 100 == 0 && (y) % 400 != 0))

/* quick checkers */
#define ALPHA(X) (((X) >= 'a' && (X) <= 'z') || ((X) >= 'A' && (X) <= 'Z'))
#define DIGIT(X) ((X) >= '0' && (X) <= '9')
#define SDIGIT(X) (((X) == '-') || ((X) >= '0' && (X) <= '9'))

/* skippers */
#define SKIP_NON_ALPHANUMS(X) while(*X && !(ALPHA(*X) || DIGIT(*X))) {(X)++;}
#define SKIP_NON_DIGITS(X) while(*X && !(DIGIT(*X))) {(X)++;}

int adjust_leap_years(int y, int m, int is_leap);
int check_ymd(int y, int m, int d, int is_leap);
int parse_alphanum(const char **c, const char **strings, const int strings_len, const char ignore_case);
double parse_fractional (const char **c);
int parse_int (const char **c, const int N, const int strict);

#endif /* !defined LUB_UTILS_H */
