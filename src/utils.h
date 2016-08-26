#ifndef LUB_UTILS_H
#define LUB_UTILS_H

typedef struct {
  int  val;
  int unit;
} intUnit;

// leap year every 400 years; no leap every 100 years
#define IS_LEAP(y) ((y) % 4 == 0) && !((y) % 100 == 0 && (y) % 400 != 0);

/* quick checkers */
#define ALPHA(X) (((X) >= 'a' && (X) <= 'z') || ((X) >= 'A' && (X) <= 'Z'))
#define DIGIT(X) ((X) >= '0' && (X) <= '9')
#define SDIGIT(X) (((X) == '-') || ((X) >= '0' && (X) <= '9'))

/* skippers */
#define SKIP_NON_ALPHANUMS(X) while(*X && !(ALPHA(*X) || DIGIT(*X))) {(X)++;}
#define SKIP_NON_DIGITS(X) while(*X && !(DIGIT(*X))) {(X)++;}

int adjust_leap_years(int y, int m, int is_leap);
int check_ymd(int y, int m, int d, int is_leap);
int parse_alphanum(const char **c, const char **strings, const int strings_len);
int parse_int (const char **c, const int N, const int strict);

#endif /* !defined LUB_UTILS_H */
