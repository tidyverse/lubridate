# vctrs methods have informative errors

    Code
      # # no common type when mixing Period/Duration/Interval
      vec_ptype2(period(), duration())
    Error <vctrs_error_incompatible_type>
      Can't combine <Period> and <Duration>.
    Code
      vec_ptype2(duration(), period())
    Error <vctrs_error_incompatible_type>
      Can't combine <Duration> and <Period>.
    Code
      vec_ptype2(period(), interval())
    Error <vctrs_error_incompatible_type>
      Can't combine <Period> and <Interval>.
    Code
      vec_ptype2(interval(), period())
    Error <vctrs_error_incompatible_type>
      Can't combine <Interval> and <Period>.
    Code
      vec_ptype2(duration(), interval())
    Error <vctrs_error_incompatible_type>
      Can't combine <Duration> and <Interval>.
    Code
      vec_ptype2(interval(), duration())
    Error <vctrs_error_incompatible_type>
      Can't combine <Interval> and <Duration>.
    Code
      # # can't cast between Period/Duration/Interval
      vec_cast(period(), duration())
    Error <vctrs_error_incompatible_type>
      Can't convert <Period> to <Duration>.
    Code
      vec_cast(duration(), period())
    Error <vctrs_error_incompatible_type>
      Can't convert <Duration> to <Period>.
    Code
      vec_cast(period(), interval())
    Error <vctrs_error_incompatible_type>
      Can't convert <Period> to <Interval>.
    Code
      vec_cast(interval(), period())
    Error <vctrs_error_incompatible_type>
      Can't convert <Interval> to <Period>.
    Code
      vec_cast(duration(), interval())
    Error <vctrs_error_incompatible_type>
      Can't convert <Duration> to <Interval>.
    Code
      vec_cast(interval(), duration())
    Error <vctrs_error_incompatible_type>
      Can't convert <Interval> to <Duration>.
    Code
      # # Period default ptype2 method falls through to `vec_default_ptype2()`
      vec_ptype2(period(), 1)
    Error <vctrs_error_incompatible_type>
      Can't combine <Period> and <double>.
    Code
      vec_ptype2(1, period())
    Error <vctrs_error_incompatible_type>
      Can't combine <double> and <Period>.
    Code
      # # Period default cast method falls through to `vec_default_cast()`
      vec_cast(period(), 1)
    Error <vctrs_error_incompatible_type>
      Can't convert <Period> to <double>.
    Code
      vec_cast(1, period())
    Error <vctrs_error_incompatible_type>
      Can't convert <double> to <Period>.
    Code
      # # Duration default ptype2 method falls through to `vec_default_ptype2()`
      vec_ptype2(duration(), 1)
    Error <vctrs_error_incompatible_type>
      Can't combine <Duration> and <double>.
    Code
      vec_ptype2(1, duration())
    Error <vctrs_error_incompatible_type>
      Can't combine <double> and <Duration>.
    Code
      # # Duration default cast method falls through to `vec_default_cast()`
      vec_cast(duration(), 1)
    Error <vctrs_error_incompatible_type>
      Can't convert <Duration> to <double>.
    Code
      vec_cast(1, duration())
    Error <vctrs_error_incompatible_type>
      Can't convert <double> to <Duration>.
    Code
      # # Interval default ptype2 method falls through to `vec_default_ptype2()`
      vec_ptype2(interval(), 1)
    Error <vctrs_error_incompatible_type>
      Can't combine <Interval> and <double>.
    Code
      vec_ptype2(1, interval())
    Error <vctrs_error_incompatible_type>
      Can't combine <double> and <Interval>.
    Code
      # # Interval default cast method falls through to `vec_default_cast()`
      vec_cast(interval(), 1)
    Error <vctrs_error_incompatible_type>
      Can't convert <Interval> to <double>.
    Code
      vec_cast(1, interval())
    Error <vctrs_error_incompatible_type>
      Can't convert <double> to <Interval>.

