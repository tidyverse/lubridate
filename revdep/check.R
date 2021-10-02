
devtools::install_github("r-lib/revdepcheck")

library(revdepcheck)

revdep_reset()
revdep_check(num_workers = 6)

revdep_summary()
revdep_todo()

revdep_add_broken(install_failures = F)
revdep_check(num_workers = 6)

## revdep_rm(packages = "xROI")

revdep_maintainers()
