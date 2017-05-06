#include <Rcpp.h>
#include "civil_time.h"
#include "time_zone.h"
#include "time_zone_if.h"
#include <unordered_map>

// CIVIL TIME:
// https://github.com/google/cctz/blob/master/include/civil_time.h
// https://github.com/devjgm/papers/blob/master/d0215r1.md

// TIME ZONES:
// https://github.com/google/cctz/blob/master/include/time_zone.h
// https://github.com/devjgm/papers/blob/master/d0216r1.md
// https://raw.githubusercontent.com/devjgm/papers/master/resources/struct-civil_lookup.png

namespace chrono = std::chrono;

const std::unordered_map<std::string, int> TZMAP {
  {"CEST", 2}, {"CET", 1}, {"EDT", -4}, {"EEST", 3}, {"EET", 2}, {"EST", -5},
  {"PDT", -7}, {"PST", -8}, {"WEST", 1}, {"WET", 0}
};

void load_tz_or_fail(std::string tzstr, cctz::time_zone& tz, std::string error_msg) {
  if (tzstr.size() == 0){
    tz = cctz::local_time_zone();
  } else {
    if (!cctz::load_time_zone(tzstr, &tz)) {
      auto el = TZMAP.find(tzstr);
      if (el != TZMAP.end()) {
        tz = cctz::fixed_time_zone(std::chrono::hours(el->second));
      } else {
        Rcpp::stop(error_msg.c_str(), tzstr);
      }
    }
  }
}


const char* get_tzone(SEXP tz) {
  if (Rf_isNull(tz)) {
    return "";
  } else {
    if (!Rf_isString(tz))
      Rcpp::stop("'tz' is not a character vector");
    return CHAR(STRING_ELT(tz, 0));
  }
}

std::string get_tzone_attr(SEXP tz){
  return get_tzone(Rf_getAttrib(tz, Rf_install("tzone")));
}

// [[Rcpp::export]]
Rcpp::newDatetimeVector C_update_dt(const Rcpp::NumericVector& dt,
                                    const Rcpp::IntegerVector& year,
                                    const Rcpp::IntegerVector& month,
                                    const Rcpp::IntegerVector& yday,
                                    const Rcpp::IntegerVector& mday,
                                    const Rcpp::IntegerVector& wday,
                                    const Rcpp::IntegerVector& hour,
                                    const Rcpp::IntegerVector& minute,
                                    const Rcpp::NumericVector& second,
                                    const SEXP tz = R_NilValue,
                                    const bool roll = false) {

  if (dt.size() == 0) return(Rcpp::newDatetimeVector(dt));

  std::vector<R_xlen_t> sizes
                        {year.size(), month.size(), yday.size(), mday.size(),
                         wday.size(), hour.size(), minute.size(), second.size()};

  // tz is always there, so the output is at least length 1
  size_t N = std::max(*std::max_element(sizes.begin(), sizes.end()), dt.size());

  bool do_year = sizes[0] > 0, do_month = sizes[1] > 0,
    do_yday = sizes[2] > 0, do_mday = sizes[3] > 0, do_wday = sizes[4] > 0,
    do_hour = sizes[5] > 0, do_minute = sizes[6] > 0, do_second = sizes[7] > 0;

  bool loop_year = sizes[0] == N, loop_month = sizes[1] == N,
    loop_yday = sizes[2] == N, loop_mday = sizes[3] == N, loop_wday = sizes[4] == N,
    loop_hour = sizes[5] == N, loop_minute = sizes[6] == N, loop_second = sizes[7] == N,
    loop_dt = dt.size() == N;

  if (sizes[0] > 1 && !loop_year) Rcpp::stop("C_update_dt: Invalid size of 'year' vector");
  if (sizes[1] > 1 && !loop_month) Rcpp::stop("C_update_dt: Invalid size of 'month' vector");
  if (sizes[2] > 1 && !loop_yday) Rcpp::stop("C_update_dt: Invalid size of 'yday' vector");
  if (sizes[3] > 1 && !loop_mday) Rcpp::stop("C_update_dt: Invalid size of 'mday' vector");
  if (sizes[4] > 1 && !loop_wday) Rcpp::stop("C_update_dt: Invalid size of 'wday' vector");
  if (sizes[5] > 1 && !loop_hour) Rcpp::stop("C_update_dt: Invalid size of 'hour' vector");
  if (sizes[6] > 1 && !loop_minute) Rcpp::stop("C_update_dt: Invalid size of 'minute' vector");
  if (sizes[7] > 1 && !loop_second) Rcpp::stop("C_update_dt: Invalid size of 'second' vector");

  if (dt.size() > 1 && !loop_dt) Rcpp::stop("C_update_dt: length of dt vector must be 1 or match the length of updating vectors");

  if (do_yday + do_mday + do_wday > 1)
    Rcpp::stop("Conflicting days input, only one of yday, mday and wday must be supplied");

  std::string fromtz = get_tzone_attr(dt);
  cctz::time_zone tzone1;
  load_tz_or_fail(fromtz, tzone1, "Invalid timezone of input vector: \"%s\"");

  std::string totz;
  cctz::time_zone tzone2;
  if (Rf_isNull(tz)) {
    totz = fromtz;
  } else {
    totz = get_tzone(tz);
  }
  load_tz_or_fail(totz, tzone2, "Unrecognized tzone in 'tz' argument: \"%s\"");

  Rcpp::NumericVector out(N);

  // all vectors are either size N or 1
  for (size_t i = 0; i < N; i++)
    {
      double dti = loop_dt ? dt[i] : dt[0];
      if (ISNA(dti)) {
        out[i] = NA_REAL;
        continue;
      }
      int secs = std::floor(dti);
      double rem = do_second ? 0.0 : dti - secs;
      cctz::sys_seconds ss(secs);
      cctz::time_point<cctz::sys_seconds> tp1(ss);
      cctz::civil_second ct1 = cctz::convert(tp1, tzone1);

      int
        y = ct1.year(), m = ct1.month(), d = ct1.day(),
        H = ct1.hour(), M = ct1.minute(), S = ct1.second();

      if (loop_year) y = year[i]; else if (do_year) y = year[0];
      if (loop_month) m = month[i]; else if (do_month) m = month[0];
      if (loop_mday) d = mday[i]; else if (do_mday) d = mday[0];
      if (loop_hour) H = hour[i]; else if (do_hour) H = hour[0];
      if (loop_minute) M = minute[i]; else if (do_minute) M = minute[0];
      if (loop_second) {
        S = std::floor(second[i]);
        rem = second[i] - S;
      } else if (do_second) {
        S = std::floor(second[0]);
        rem = second[0] - S;
      }

      if (y == NA_INTEGER || m == NA_INTEGER || d == NA_INTEGER ||
          H == NA_INTEGER || M == NA_INTEGER || S == NA_INTEGER) {
        out[i] = NA_REAL;
        continue;
      }

      if (do_yday) {
        // yday and d are 1 based
        d = d - cctz::get_yearday(cctz::civil_day(ct1));
        if (loop_yday) d += yday[i]; else d += yday[0];
      }
      if (do_wday) {
        // wday is 1 based and starts on Sunday
        int cur_wday = (static_cast<int>(cctz::get_weekday(cctz::civil_day(ct1))) + 1) % 7;
        d = d - cur_wday - 1;
        if (loop_wday) d += wday[i]; else d += wday[0];
      }

      const cctz::civil_second cs2(y, m, d, H, M, S);
      const cctz::time_zone::civil_lookup cl2 = tzone2.lookup(cs2);
      cctz::time_point<cctz::sys_seconds> tp2;
      if (cl2.kind == cctz::time_zone::civil_lookup::UNIQUE) {
        tp2 = cl2.pre;
      } else if (cl2.kind == cctz::time_zone::civil_lookup::SKIPPED) {
        if (roll) {
          tp2 = cl2.trans;
        } else {
          out[i] = NA_REAL;
          continue;
        }
      } else { // REPEATED
        // match pre or post time of ct1
        const cctz::time_zone::civil_lookup cl1 = tzone1.lookup(ct1);
        /* Rcpp::Rcout << cctz::format("tp:%Y-%m-%d %H:%M:%S %z", tp1, tz1) << std::endl; */
        /* Rcpp::Rcout << cctz::format("pre:%Y-%m-%d %H:%M:%S %z", cl1.pre, tz1) << std::endl; */
        /* Rcpp::Rcout << cctz::format("trans:%Y-%m-%d %H:%M:%S %z", cl1.trans, tz1) << std::endl; */
        /* Rcpp::Rcout << cctz::format("post:%Y-%m-%d %H:%M:%S %z", cl1.post, tz1) << std::endl; */
        if (tp1 >= cl1.trans){
          tp2 = cl2.post;
        } else {
          tp2 = cl2.pre;
        }
      }
      out[i] = tp2.time_since_epoch().count() + rem;
    }

  return Rcpp::newDatetimeVector(out, totz.c_str());

}

// [[Rcpp::export]]
Rcpp::newDatetimeVector C_force_tz(const Rcpp::NumericVector dt,
                                   const Rcpp::CharacterVector tz,
                                   const bool roll = false) {

  typedef std::chrono::duration<double, std::ratio<1>> dseconds;

  size_t n = dt.size();

  std::string tzfrom = get_tzone_attr(dt);
  std::string tzto(tz[0]);

  if (tz.size() > 1)
    Rcpp::stop("In 'force_tz' tz argument must be a single character string");

  cctz::time_zone tz1, tz2;   // two time zone objects
  load_tz_or_fail(tzfrom, tz1, "Invalid timezone of input vector: \"%s\"");
  load_tz_or_fail(tzto, tz2, "Unrecognized timezone: \"%s\"");

  Rcpp::NumericVector out(n);

  for (size_t i = 0; i < n; i++)
    {
      int secs = std::floor(dt[i]);
      double rem = dt[i] - secs;
      cctz::sys_seconds d1(secs);
      cctz::time_point<cctz::sys_seconds> tp1(d1);
      cctz::civil_second ct1 = cctz::convert(tp1, tz1);
      const cctz::time_zone::civil_lookup cl2 = tz2.lookup(ct1);

      cctz::time_point<cctz::sys_seconds> tp2;
      if (cl2.kind == cctz::time_zone::civil_lookup::UNIQUE) {
        // UNIQUE
        tp2 = cl2.pre;
      } else if (cl2.kind == cctz::time_zone::civil_lookup::SKIPPED) {
        if (roll)
          tp2 = cl2.trans;
        else {
          out[i] = NA_REAL;
          continue;
        }
      } else { // REPEATED
        // match pre or post time of ct1
        const cctz::time_zone::civil_lookup cl1 = tz1.lookup(ct1);
        if (tp1 >= cl1.trans){
          tp2 = cl2.post;
        } else {
          tp2 = cl2.pre;
        }
        /* Rcpp::Rcout << cctz::format("tp:%Y-%m-%d %H:%M:%S %z", tp1, tz1) << std::endl; */
        /* Rcpp::Rcout << cctz::format("pre:%Y-%m-%d %H:%M:%S %z", cl1.pre, tz1) << std::endl; */
        /* Rcpp::Rcout << cctz::format("trans:%Y-%m-%d %H:%M:%S %z", cl1.trans, tz1) << std::endl; */
        /* Rcpp::Rcout << cctz::format("post:%Y-%m-%d %H:%M:%S %z", cl1.post, tz1) << std::endl; */
      }

      out[i] = tp2.time_since_epoch().count() + rem;
    }

  return Rcpp::newDatetimeVector(out, tzto.c_str());
}
