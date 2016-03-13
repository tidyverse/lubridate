#ifndef LUB_CONSTANTS_H
#define LUB_CONSTANTS_H

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
