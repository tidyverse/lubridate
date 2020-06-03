
devtools::install_github("r-lib/revdepcheck")

library(revdepcheck)
revdep_reset()
revdep_check(num_workers = 8)
revdep_summary()
revdep_todo()
revdep_add_broken()
revdep_rm(packages = "xROI")
revdep_reset()
revdep_check()

revdep_maintainers()
