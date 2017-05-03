#include <Rcpp.h>
#include "civil_time.h"
#include "time_zone.h"
#include "time_zone_if.h"
#include <unordered_map>

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

// [[Rcpp::export]]
Rcpp::newDatetimeVector C_force_tz(const Rcpp::NumericVector dt,
                                   const Rcpp::CharacterVector tz,
                                   const bool roll = false) {

  typedef std::chrono::duration<double, std::ratio<1>> dseconds;


  std::string tzfrom;
  SEXP attr = dt.attr("tzone");
  if (Rf_isNull(attr)) {
    tzfrom = "";
  } else {
    tzfrom = std::string(CHAR(STRING_ELT(attr, 0)));
  }

  std::string tzto(tz[0]);
  size_t n = dt.size();

  if (tz.size() > 1)
    Rcpp::stop("In 'force_tz' tz argument must be a single character string");

  cctz::time_zone tz1, tz2;   // two time zone objects
  load_tz_or_fail(tzfrom, tz1, "Invalid timezone of input vector: \"%s\"");
  load_tz_or_fail(tzto, tz2, "Unrecognized timezone: \"%s\"");

  Rcpp::NumericVector out(n);

  for (size_t i = 0; i < n; i++)
    {
      int secs = std::floor(dt[i]);
      double rem1 = dt[i] - secs;
      cctz::sys_seconds d1(secs);
      cctz::time_point<cctz::sys_seconds> tp1(d1);
      cctz::civil_second ct1 = cctz::convert(tp1, tz1);
      const cctz::time_zone::civil_lookup cl2 = tz2.lookup(ct1);

      cctz::time_point<cctz::sys_seconds> tp2;
      if (cl2.kind == cctz::time_zone::civil_lookup::SKIPPED) {
        if (roll)
          tp2 = cl2.trans;
        else {
          out[i] = NA_REAL;
          continue;
        }
      } else if (cl2.kind == cctz::time_zone::civil_lookup::REPEATED) {
        // match pre or post time of ct1
        const cctz::time_zone::civil_lookup cl1 = tz1.lookup(ct1);
        /* Rcpp::Rcout << cctz::format("tp:%Y-%m-%d %H:%M:%S %z", tp1, tz1) << std::endl; */
        /* Rcpp::Rcout << cctz::format("pre:%Y-%m-%d %H:%M:%S %z", cl1.pre, tz1) << std::endl; */
        /* Rcpp::Rcout << cctz::format("trans:%Y-%m-%d %H:%M:%S %z", cl1.trans, tz1) << std::endl; */
        /* Rcpp::Rcout << cctz::format("post:%Y-%m-%d %H:%M:%S %z", cl1.post, tz1) << std::endl; */
        if (tp1 >= cl1.trans){
          tp2 = cl2.post;
        } else {
          tp2 = cl2.pre;
        }
      } else {
        // UNIQUE
        tp2 = cl2.pre;
      }

      out[i] = tp2.time_since_epoch().count() + rem1;
    }

  return Rcpp::newDatetimeVector(out, tzto.c_str());
}
