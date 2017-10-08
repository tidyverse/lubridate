
remove.packages(c("rlang", "revdepcheck", "crayon", "boxes", "progress", "callr", "rcmdcheck"))

source("https://install-github.me/r-lib/revdepcheck")

library(revdepcheck)
revdep_reset()

revdep_check(num_workers = 8, bioc = FALSE)
revdep_summary()

revdep_todo()
revdep_add_broken()
revdep_check()

revdep_details(revdep = "FedData")
revdep_details(revdep = "fmdates")
revdep_details(revdep = "openair")

## crancache::get_cache_package_dirs()
revdep_report_summary(pkg = ".", file = "./revdep/README.md")
revdep_report_problems(pkg = ".", file = "./revdep/problems.md")
revdep_report_cran()
