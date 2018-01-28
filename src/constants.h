/*
 *  Constants for lubridate
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


#ifndef LUB_CONSTANTS_H
#define LUB_CONSTANTS_H

#define FALSE 0
#define TRUE 1


static const int SECONDS_IN_ONE[] = {
    1, // second
    60, // minute
    3600, // hour
    86400, // day
    604800, // week
    31557600 // year
};

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

#endif /* !defined LUB_CONSTANTS_H */
