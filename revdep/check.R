
remove.packages(c("rlang", "revdepcheck", "crayon", "boxes", "progress", "callr", "rcmdcheck"))
## source("https://install-github.me/r-lib/boxes")
## source("https://install-github.me/r-lib/crancache")
devtools::install_github("r-lib/revdepcheck")

library(revdepcheck)
revdep_reset()
revdep_check(num_workers = 8)
revdep_summary()
revdep_todo()
revdep_add_broken()
revdep_rm(packages = "CAWaR")
revdep_check()

revdep_maintainers()
