#include <cstdio>
#include <iostream>

#include <cstdint>
#include <limits>
#include <unordered_map>
#include <vector>
#include "R_ext/Arith.h"
#include "R_ext/Print.h"
#include "cctz/civil_time.h"
#include "cctz/time_zone.h"
#include <cpp11.hpp>
#include "utils.h"

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
      cpp11::stop("'tz' is not a character vector");
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
  cpp11::writable::doubles origin(1);
  origin[0] = 0;
  origin.attr("class") = {"POSIXct", "POSIXt"};
  auto as_posixlt = cpp11::package("base")["as.POSIXlt.POSIXct"];
  return tz_from_tzone_attr(as_posixlt(origin));
}

const char* get_system_tz() {
  auto sys_timezone = cpp11::package("base")["Sys.timezone"];
  SEXP sys_tz = STRING_ELT(sys_timezone(), 0);
  if (sys_tz == NA_STRING || strlen(CHAR(sys_tz)) == 0) {
    cpp11::warning("System timezone name is unknown. Please set environment variable TZ.");
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
    cpp11::warning("Environment variable TZ is set to \"\". Things might break.");
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

[[cpp11::register]]
cpp11::writable::strings C_local_tz() {
  const char* tz = local_tz();
  cpp11::writable::strings out({tz});
  return out;
}

[[cpp11::register]]
bool C_valid_tz(const cpp11::strings& tz_name) {
  cctz::time_zone tz;
  std::string tzstr = tz_name[0];
  return load_tz(tzstr, tz);
}

void load_tz_or_fail(std::string tzstr, cctz::time_zone& tz, std::string error_msg) {
  if (!load_tz(tzstr, tz)) {
    cpp11::stop(error_msg.c_str(), tzstr.c_str());
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
    else
      return NA_REAL;
  } else {
    // REPEATED
    // match pre or post time of original time
    const cctz::time_zone::civil_lookup cl_old = tz_orig.lookup(cs_orig);
    if (tp_orig >= cl_old.trans)
      tp_new = cl_new.post;
    else
      tp_new = cl_new.pre;
  }

  /* std::cout << cctz::format("tp_new:%Y-%m-%d %H:%M:%S %z", tp_new, tz_orig) << std::endl; */
  /* std::cout << cctz::format("pre:%Y-%m-%d %H:%M:%S %z", cl_new.pre, tz_orig) << std::endl; */
  /* std::cout << cctz::format("trans:%Y-%m-%d %H:%M:%S %z", cl_new.trans, tz_orig) << std::endl; */
  /* std::cout << cctz::format("post:%Y-%m-%d %H:%M:%S %z", cl_new.post, tz_orig) << std::endl; */

  return tp_new.time_since_epoch().count() + remainder;
}

static inline void init_posixct(cpp11::writable::doubles& x, const char* tz) {
  x.attr("class") = {"POSIXct", "POSIXt"};
  x.attr("tzone") = tz;
}

[[cpp11::register]]
cpp11::writable::doubles C_force_tz(const cpp11::doubles& dt,
                                    const cpp11::strings& tz,
                                    const bool roll) {
  // roll: logical, if `true`, and `time` falls into the DST-break, assume the
  // next valid civil time, otherwise return NA

  if (tz.size() != 1)
    cpp11::stop("`tz` argument must be a single character string");

  std::string tzfrom_name = tz_from_tzone_attr(dt);
  std::string tzto_name(tz[0]);
  cctz::time_zone tzfrom, tzto;
  load_tz_or_fail(tzfrom_name, tzfrom, "CCTZ: Unrecognized timezone of the input vector: \"%s\"");
  load_tz_or_fail(tzto_name, tzto, "CCTZ: Unrecognized output timezone: \"%s\"");

  /* std::cout << "TZ from:" << tzfrom.name() << std::endl; */
  /* std::cout << "TZ to:" << tzto.name() << std::endl; */

  size_t n = dt.size();
  cpp11::writable::doubles out(n);
  init_posixct(out, tzto_name.c_str());

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

  return out;
}


[[cpp11::register]]
cpp11::writable::doubles C_force_tzs(const cpp11::doubles& dt,
                                     const cpp11::strings& tzs,
                                     const cpp11::strings& tz_out,
                                     const bool roll) {
  // roll: logical, if `true`, and `time` falls into the DST-break, assume the
  // next valid civil time, otherwise return NA

  if (tz_out.size() != 1)
    cpp11::stop("In 'tzout' argument must be of length 1");

  if (tzs.size() != dt.size())
    cpp11::stop("In 'C_force_tzs' tzs and dt arguments must be of the same length");

  std::string tzfrom_name = tz_from_tzone_attr(dt);
  std::string tzout_name(tz_out[0]);

  cctz::time_zone tzfrom, tzto, tzout;
  load_tz_or_fail(tzfrom_name, tzfrom, "CCTZ: Unrecognized timezone of input vector: \"%s\"");
  load_tz_or_fail(tzout_name, tzout, "CCTZ: Unrecognized timezone: \"%s\"");

  std::string tzto_old_name("not-a-tz");
  size_t n = dt.size();
  cpp11::writable::doubles out(n);
  init_posixct(out, tzout_name.c_str());

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

  return out;
}

[[cpp11::register]]
cpp11::writable::doubles C_local_time(const cpp11::doubles& dt,
                                      const cpp11::strings& tzs) {

  if (tzs.size() != dt.size())
    cpp11::stop("`tzs` and `dt` arguments must be of the same length");

  std::string tzfrom_name = tz_from_tzone_attr(dt);
  std::string tzto_old_name("not-a-tz");
  cctz::time_zone tzto;

  size_t n = dt.size();
  cpp11::writable::doubles out(n);

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
