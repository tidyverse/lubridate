
remove.packages(c("rlang", "revdepcheck", "crayon", "boxes", "progress", "callr", "rcmdcheck"))

## source("https://install-github.me/r-lib/boxes")
## source("https://install-github.me/r-lib/crancache")
source("https://install-github.me/r-lib/revdepcheck")

devtools::install("~/tmp/revdepcheck")

library(revdepcheck)
revdep_reset()

revdep_check(num_workers = 8, bioc = FALSE)
revdep_summary()

revdep_todo()
revdep_add_broken()
revdep_check()

library(revdepcheck)

revdep_details(revdep = "bikedata")
revdep_details(revdep = "GSODR")
revdep_details(revdep = "stplanr")

## crancache::get_cache_package_dirs()
## revdep_report_summary(pkg = ".", file = "./revdep/README.md")
## revdep_report_problems(pkg = ".", file = "./revdep/problems.md")
## revdep_report_cran()
