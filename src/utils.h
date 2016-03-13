#ifndef LUB_UTILS_H
#define LUB_UTILS_H

// leap year every 400 years; no leap every 100 years
#define IS_LEAP(y) ((y) % 4 == 0) && !((y) % 100 == 0 && (y) % 400 != 0);

int adjust_leap_years(int y, int m, int is_leap);
int check_ymd(int y, int m, int d, int is_leap);

#endif /* !defined LUB_UTILS_H */
