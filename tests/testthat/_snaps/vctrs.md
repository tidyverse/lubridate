# vctrs methods have informative errors

    Code
      # # no common type when mixing Period/Duration/Interval
      vec_ptype2(period(), duration())
    Condition
      Error:
      ! Can't combine `period()` <Period> and `duration()` <Duration>.
    Code
      vec_ptype2(duration(), period())
    Condition
      Error:
      ! Can't combine `duration()` <Duration> and `period()` <Period>.
    Code
      vec_ptype2(period(), interval())
    Condition
      Error:
      ! Can't combine `period()` <Period> and `interval()` <Interval>.
    Code
      vec_ptype2(interval(), period())
    Condition
      Error:
      ! Can't combine `interval()` <Interval> and `period()` <Period>.
    Code
      vec_ptype2(duration(), interval())
    Condition
      Error:
      ! Can't combine `duration()` <Duration> and `interval()` <Interval>.
    Code
      vec_ptype2(interval(), duration())
    Condition
      Error:
      ! Can't combine `interval()` <Interval> and `duration()` <Duration>.
    Code
      # # can't cast between Period/Duration/Interval
      vec_cast(period(), duration())
    Condition
      Error:
      ! Can't convert `period()` <Period> to <Duration>.
    Code
      vec_cast(duration(), period())
    Condition
      Error:
      ! Can't convert `duration()` <Duration> to <Period>.
    Code
      vec_cast(period(), interval())
    Condition
      Error:
      ! Can't convert `period()` <Period> to <Interval>.
    Code
      vec_cast(interval(), period())
    Condition
      Error:
      ! Can't convert `interval()` <Interval> to <Period>.
    Code
      vec_cast(duration(), interval())
    Condition
      Error:
      ! Can't convert `duration()` <Duration> to <Interval>.
    Code
      vec_cast(interval(), duration())
    Condition
      Error:
      ! Can't convert `interval()` <Interval> to <Duration>.
    Code
      # # Period default ptype2 method falls through to `vec_default_ptype2()`
      vec_ptype2(period(), 1)
    Condition
      Error:
      ! Can't combine `period()` <Period> and `1` <double>.
    Code
      vec_ptype2(1, period())
    Condition
      Error:
      ! Can't combine `1` <double> and `period()` <Period>.
    Code
      # # Period default cast method falls through to `vec_default_cast()`
      vec_cast(period(), 1)
    Condition
      Error:
      ! Can't convert `period()` <Period> to <double>.
    Code
      vec_cast(1, period())
    Condition
      Error:
      ! Can't convert `1` <double> to <Period>.
    Code
      # # Duration default ptype2 method falls through to `vec_default_ptype2()`
      vec_ptype2(duration(), 1)
    Condition
      Error:
      ! Can't combine `duration()` <Duration> and `1` <double>.
    Code
      vec_ptype2(1, duration())
    Condition
      Error:
      ! Can't combine `1` <double> and `duration()` <Duration>.
    Code
      # # Duration default cast method falls through to `vec_default_cast()`
      vec_cast(duration(), 1)
    Condition
      Error:
      ! Can't convert `duration()` <Duration> to <double>.
    Code
      vec_cast(1, duration())
    Condition
      Error:
      ! Can't convert `1` <double> to <Duration>.
    Code
      # # Interval default ptype2 method falls through to `vec_default_ptype2()`
      vec_ptype2(interval(), 1)
    Condition
      Error:
      ! Can't combine `interval()` <Interval> and `1` <double>.
    Code
      vec_ptype2(1, interval())
    Condition
      Error:
      ! Can't combine `1` <double> and `interval()` <Interval>.
    Code
      # # Interval default cast method falls through to `vec_default_cast()`
      vec_cast(interval(), 1)
    Condition
      Error:
      ! Can't convert `interval()` <Interval> to <double>.
    Code
      vec_cast(1, interval())
    Condition
      Error:
      ! Can't convert `1` <double> to <Interval>.

