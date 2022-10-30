#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>


extern SEXP C_make_d(SEXP, SEXP, SEXP);
extern SEXP C_parse_dt(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP C_parse_hms(SEXP, SEXP);
extern SEXP C_parse_period(SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"C_make_d",              (DL_FUNC) &C_make_d,              3},
  {"C_parse_dt",            (DL_FUNC) &C_parse_dt,            5},
  {"C_parse_hms",           (DL_FUNC) &C_parse_hms,           2},
  {"C_parse_period",        (DL_FUNC) &C_parse_period,        1},
  {NULL, NULL, 0}
};

void R_init_lubridate(DllInfo* dll){
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
  R_forceSymbols(dll, TRUE);
}
