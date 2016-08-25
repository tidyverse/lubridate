library("devtools")

## pkg <- "~/dev/lubridate"
devtools::revdep_check_reset()
devtools::revdep_check(ignore = c("aoristic", "ChainLadder"), libpath = "~/tmp/R-lib/")

## revdep_check_reset()
## revdep_check()
revdep_check_save_summary()
revdep_check_print_problems()
