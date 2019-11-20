#include <cstdint>
#include <limits>
#include <unordered_map>
#include "civil_time.h"
#include "time_zone.h"
#include "utils.h"
#include <Rcpp.h>

// CIVIL TIME:
// https://github.com/google/cctz/blob/master/include/civil_time.h
// https://github.com/devjgm/papers/blob/master/d0215r1.md

// TIME ZONES:
// https://github.com/google/cctz/blob/master/include/time_zone.h
// https://github.com/devjgm/papers/blob/master/d0216r1.md
// https://raw.githubusercontent.com/devjgm/papers/master/resources/struct-civil_lookup.png

// R's timezone registry:
// https://github.com/SurajGupta/r-source/blob/master/src/extra/tzone/registryTZ.c


/// floor

int_fast64_t NA_INT32 = static_cast<int_fast64_t>(NA_INTEGER);
int_fast64_t NA_INT64 = std::numeric_limits<int_fast64_t>::min();
double fINT64_MAX = static_cast<double>(std::numeric_limits<int_fast64_t>::max());
double fINT64_MIN = static_cast<double>(std::numeric_limits<int_fast64_t>::min());

int_fast64_t floor_to_int64(double x) {
  // maybe fixme: no warning yet on integer overflow
  if (ISNAN(x))
    return NA_INT64;

  x = std::floor(x);
  if (x > fINT64_MAX || x <= fINT64_MIN) {
    return NA_INT64;
  }

  return static_cast<int_fast64_t>(x);
}


/// tzone utilities

namespace chrono = std::chrono;
using sys_seconds = chrono::duration<int_fast64_t>;
using time_point = chrono::time_point<std::chrono::system_clock, sys_seconds>;

const std::unordered_map<std::string, int> TZMAP {
  {"CEST", 2}, {"CET", 1}, {"EDT", -4}, {"EEST", 3}, {"EET", 2}, {"EST", -5},
  {"PDT", -7}, {"PST", -8}, {"WEST", 1}, {"WET", 0}
};

const char* tz_from_R_tzone(SEXP tz) {
  if (Rf_isNull(tz)) {
    return "";
  } else {
    if (!Rf_isString(tz))
      Rf_error("'tz' is not a character vector");
    const char* tz0 = CHAR(STRING_ELT(tz, 0));
    if (strlen(tz0) == 0) {
      if (LENGTH(tz) > 1) {
        return CHAR(STRING_ELT(tz, 1));
      }
    }
    return tz0;
  }
}

const char* tz_from_tzone_attr(SEXP x){
  return tz_from_R_tzone(Rf_getAttrib(x, Rf_install("tzone")));
}

const char* get_current_tz() {
  // ugly workaround to get local time zone (abbreviation) as seen by R (not used)
  Rcpp::NumericVector origin = Rcpp::NumericVector::create(0);
  origin.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
  Rcpp::Environment base = Rcpp::Environment::base_namespace();
  Rcpp::Function as_posixlt(base["as.POSIXlt.POSIXct"]);
  return tz_from_R_tzone(as_posixlt(origin));
}

const char* get_system_tz() {
  Rcpp::Environment base = Rcpp::Environment::base_namespace();
  Rcpp::Function sys_timezone(base["Sys.timezone"]);
  SEXP sys_tz = STRING_ELT(sys_timezone(), 0);
  if (sys_tz == NA_STRING || strlen(CHAR(sys_tz)) == 0) {
    Rf_warning("System timezone name is unknown. Please set environment variable TZ.");
    return "UTC";
  } else {
    return CHAR(sys_tz);
  }
}

const char* local_tz() {
  // initialize once per session
  static const char* SYS_TZ = strdup(get_system_tz());
  const char* tz_env = std::getenv("TZ");
  if (tz_env == NULL) {
    return SYS_TZ;
  } else if (strlen(tz_env) == 0) {
    // FIXME:
    // if set but empty, it's system specific ...
    // Is there a way way to get TZ name as R sees it?
    Rf_warning("Environment variable TZ is set to \"\". Things might break.");
    return get_current_tz();
  }
  else {
    return tz_env;
  }
}

bool load_tz(std::string tzstr, cctz::time_zone& tz) {
  // return `true` if loaded, else false
  if (tzstr.size() == 0) {
    // CCTZ doesn't work on windows https://github.com/google/cctz/issues/53
    /* std::cout << "Local TZ: " << local_tz() << std::endl; */
    return cctz::load_time_zone(local_tz(), &tz);
  } else {
    if (!cctz::load_time_zone(tzstr, &tz)) {
      auto el = TZMAP.find(tzstr);
      if (el != TZMAP.end()) {
        tz = cctz::fixed_time_zone(chrono::hours(el->second));
      } else {
        return false;
      }
    }
    return true;
  }
}

// [[Rcpp::export]]
Rcpp::CharacterVector C_local_tz() {
    return Rf_mkString(local_tz());
}

// [[Rcpp::export]]
Rcpp::LogicalVector C_valid_tz(const Rcpp::CharacterVector& tz_name) {
  cctz::time_zone tz;
  std::string tzstr(tz_name[0]);
  return load_tz(tzstr, tz);
}

void load_tz_or_fail(std::string tzstr, cctz::time_zone& tz, std::string error_msg) {
  if (!load_tz(tzstr, tz)) {
    Rcpp::stop(error_msg.c_str(), tzstr);
  }
}

// Helper for conversion functions. Get seconds from civil_lookup, but relies on
// use original time pre/post time if cl_new falls in repeated interval.
double get_secs_from_civil_lookup(const cctz::time_zone::civil_lookup& cl_new, // new lookup
                                  const cctz::time_zone& tz_orig,              // original time zone
                                  const time_point& tp_orig,                   // original time point
                                  const cctz::civil_second& cs_orig,           // original time in secs
                                  bool roll, double remainder = 0.0) {

  time_point tp_new;

  if (cl_new.kind == cctz::time_zone::civil_lookup::UNIQUE) {
    // UNIQUE
    tp_new = cl_new.pre;
  } else if (cl_new.kind == cctz::time_zone::civil_lookup::SKIPPED) {
    // SKIPPED
    if (roll)
      tp_new = cl_new.trans;
    else {
      return NA_REAL;
    }
  } else {
    // REPEATED
    // match pre or post time of original time
    const cctz::time_zone::civil_lookup cl_old = tz_orig.lookup(cs_orig);
    if (tp_orig >= cl_old.trans){
      tp_new = cl_new.post;
    } else {
      tp_new = cl_new.pre;
    }
    /* Rcpp::Rcout << cctz::format("tp:%Y-%m-%d %H:%M:%S %z", tp1, tz1) << std::endl; */
    /* Rcpp::Rcout << cctz::format("pre:%Y-%m-%d %H:%M:%S %z", cl1.pre, tz1) << std::endl; */
    /* Rcpp::Rcout << cctz::format("trans:%Y-%m-%d %H:%M:%S %z", cl1.trans, tz1) << std::endl; */
    /* Rcpp::Rcout << cctz::format("post:%Y-%m-%d %H:%M:%S %z", cl1.post, tz1) << std::endl; */
  }

  return tp_new.time_since_epoch().count() + remainder;
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
                                    const bool roll = false,
                                    const int week_start = 7) {

  if (dt.size() == 0) return(Rcpp::newDatetimeVector(dt));

  std::vector<R_xlen_t> sizes
                        {year.size(), month.size(), yday.size(), mday.size(),
                         wday.size(), hour.size(), minute.size(), second.size()};

  // tz is always there, so the output is at least length 1
  R_xlen_t N = std::max(*std::max_element(sizes.begin(), sizes.end()), dt.size());

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

  if (dt.size() > 1 && !loop_dt)
    Rcpp::stop("C_update_dt: length of dt vector must be 1 or match the length of updating vectors");

  if (do_yday + do_mday + do_wday > 1)
    Rcpp::stop("Conflicting days input, only one of yday, mday and wday must be supplied");

  std::string tzfrom = tz_from_tzone_attr(dt);
  cctz::time_zone tzone1;
  load_tz_or_fail(tzfrom, tzone1, "CCTZ: Invalid timezone of the input vector: \"%s\"");

  std::string tzto;
  cctz::time_zone tzone2;
  if (Rf_isNull(tz)) {
    tzto = tzfrom;
  } else {
    tzto = tz_from_R_tzone(tz);
  }
  load_tz_or_fail(tzto, tzone2, "CCTZ: Unrecognized tzone: \"%s\"");

  Rcpp::NumericVector out(N);

  // all vectors are either size N or 1
  for (R_xlen_t i = 0; i < N; i++)
    {
      double dti = loop_dt ? dt[i] : dt[0];
      int_fast64_t secs = floor_to_int64(dti);

      if (ISNAN(dti) || secs == NA_INT64) {
        out[i] = NA_REAL;
        continue;
      }

      double rem = 0.0;
      sys_seconds ss(secs);
      time_point tp1(ss);
      cctz::civil_second ct1 = cctz::convert(tp1, tzone1);

      int_fast64_t
        y = ct1.year(), m = ct1.month(), d = ct1.day(),
        H = ct1.hour(), M = ct1.minute(), S = ct1.second();

      if (do_year) {
        y = loop_year ? year[i] : year[0];
        if (y == NA_INT32) {out[i] = NA_REAL; continue; }
      }
      if (do_month) {
        m = loop_month ? month[i] : month[0];
        if (m == NA_INT32) {out[i] = NA_REAL; continue; }
      }
      if (do_mday) {
        d = loop_mday ? mday[i] : mday[0];
        if (d == NA_INT32) {out[i] = NA_REAL; continue; }
      }
      if (do_hour) {
        H = loop_hour ? hour[i] : hour[0];
        if (H == NA_INT32) {out[i] = NA_REAL; continue; }
      }
      if (do_minute) {
        M = loop_minute ? minute[i] : minute[0];
        if (M == NA_INT32) {out[i] = NA_REAL; continue; }
      }
      if (do_second) {
        if (loop_second) {
          S = floor_to_int64(second[i]);
          rem = second[i] - S;
        } else {
          S = floor_to_int64(second[0]);
          rem = second[0] - S;
        }
        if (S == NA_INT64) {out[i] = NA_REAL; continue; }
      }

      if (do_yday) {
        // yday and d are 1 based
        d = d - cctz::get_yearday(cctz::civil_day(ct1));
        /* if (IS_LEAP(y) && ct1.month() > 2) d -= 1; */
        if (loop_yday) d += yday[i]; else d += yday[0];
      }

      if (do_wday) {
        // wday is 1 based and starts on week_start
        int cur_wday = (static_cast<int>(cctz::get_weekday(cctz::civil_day(ct1))) + 8 - week_start) % 7;
        d = d - cur_wday - 1;
        if (loop_wday) d += wday[i]; else d += wday[0];
      }

      const cctz::civil_second cs2(y, m, d, H, M, S);
      const cctz::time_zone::civil_lookup cl2 = tzone2.lookup(cs2);

      out[i] = get_secs_from_civil_lookup(cl2, tzone1, tp1, ct1, roll, rem);

    }

  return Rcpp::newDatetimeVector(out, tzto.c_str());

}

// [[Rcpp::export]]
Rcpp::newDatetimeVector C_force_tz(const Rcpp::NumericVector dt,
                                   const Rcpp::CharacterVector tz,
                                   const bool roll = false) {
  // roll: logical, if `true`, and `time` falls into the DST-break, assume the
  // next valid civil time, otherwise return NA

  if (tz.size() != 1)
    Rcpp::stop("`tz` argument must be a single character string");

  std::string tzfrom_name = tz_from_tzone_attr(dt);
  std::string tzto_name(tz[0]);
  cctz::time_zone tzfrom, tzto;
  load_tz_or_fail(tzfrom_name, tzfrom, "CCTZ: Unrecognized timezone of the input vector: \"%s\"");
  load_tz_or_fail(tzto_name, tzto, "CCTZ: Unrecognized output timezone: \"%s\"");

  /* std::cout << "TZ from:" << tzfrom.name() << std::endl; */
  /* std::cout << "TZ to:" << tzto.name() << std::endl; */

  size_t n = dt.size();
  Rcpp::NumericVector out(n);

  for (size_t i = 0; i < n; i++)
    {
      int_fast64_t secs = floor_to_int64(dt[i]);
      /* printf("na: %i na64: %+" PRIiFAST64 "  secs: %+" PRIiFAST64 "  dt: %f\n", NA_INTEGER, INT_FAST64_MIN, secs, dt[i]); */
      if (secs == NA_INT64) {out[i] = NA_REAL; continue; }
      double rem = dt[i] - secs;
      sys_seconds d1(secs);
      time_point tp1(d1);
      cctz::civil_second ct1 = cctz::convert(tp1, tzfrom);
      const cctz::time_zone::civil_lookup cl2 = tzto.lookup(ct1);
      out[i] = get_secs_from_civil_lookup(cl2, tzfrom, tp1, ct1, roll, rem);
    }

  return Rcpp::newDatetimeVector(out, tzto_name.c_str());
}


// [[Rcpp::export]]
Rcpp::newDatetimeVector C_force_tzs(const Rcpp::NumericVector dt,
                                    const Rcpp::CharacterVector tzs,
                                    const Rcpp::CharacterVector tz_out,
                                    const bool roll = false) {
  // roll: logical, if `true`, and `time` falls into the DST-break, assume the
  // next valid civil time, otherwise return NA

  if (tz_out.size() != 1)
    Rcpp::stop("In 'tzout' argument must be of length 1");

  if (tzs.size() != dt.size())
    Rcpp::stop("In 'C_force_tzs' tzs and dt arguments must be of the same length");

  std::string tzfrom_name = tz_from_tzone_attr(dt);
  std::string tzout_name(tz_out[0]);

  cctz::time_zone tzfrom, tzto, tzout;
  load_tz_or_fail(tzfrom_name, tzfrom, "CCTZ: Unrecognized timezone of input vector: \"%s\"");
  load_tz_or_fail(tzout_name, tzout, "CCTZ: Unrecognized timezone: \"%s\"");

  std::string tzto_old_name("not-a-tz");
  size_t n = dt.size();
  Rcpp::NumericVector out(n);

  for (size_t i = 0; i < n; i++)
    {
      std::string tzto_name(tzs[i]);
      if (tzto_name != tzto_old_name) {
        load_tz_or_fail(tzto_name, tzto, "CCTZ: Unrecognized timezone: \"%s\"");
        tzto_old_name = tzto_name;
      }

      int_fast64_t secs = floor_to_int64(dt[i]);
      if (secs == NA_INT64) { out[i] = NA_REAL; continue; }
      double rem = dt[i] - secs;
      sys_seconds secsfrom(secs);
      time_point tpfrom(secsfrom);
      cctz::civil_second csfrom = cctz::convert(tpfrom, tzfrom);

      const cctz::time_zone::civil_lookup clto = tzto.lookup(csfrom);
      out[i] = get_secs_from_civil_lookup(clto, tzfrom, tpfrom, csfrom, roll, rem);

    }

  return Rcpp::newDatetimeVector(out, tzout_name.c_str());
}

// [[Rcpp::export]]
Rcpp::NumericVector C_local_time(const Rcpp::NumericVector dt,
                                 const Rcpp::CharacterVector tzs) {

  if (tzs.size() != dt.size())
    Rcpp::stop("`tzs` and `dt` arguments must be of the same length");

  std::string tzfrom_name = tz_from_tzone_attr(dt);
  std::string tzto_old_name("not-a-tz");
  cctz::time_zone tzto;

  size_t n = dt.size();
  Rcpp::NumericVector out(n);

  for (size_t i = 0; i < n; i++)
    {
      std::string tzto_name(tzs[i]);
      if (tzto_name != tzto_old_name) {
        load_tz_or_fail(tzto_name, tzto, "CCTZ: Unrecognized timezone: \"%s\"");
        tzto_old_name = tzto_name;
      }

      int_fast64_t secs = floor_to_int64(dt[i]);
      if (secs == NA_INT64) { out[i] = NA_REAL; continue; }
      double rem = dt[i] - secs;

      sys_seconds secsfrom(secs);
      time_point tpfrom(secsfrom);
      cctz::civil_second cs = cctz::convert(tpfrom, tzto);
      cctz::civil_second cs_floor = cctz::civil_second(cctz::civil_day(cs));
      out[i] = cs - cs_floor + rem;
    }

  return out;
}
