library("devtools")

## pkg <- "~/dev/lubridate"
revdep_check_reset()
revdep_check(ignore = c("aoristic", "ChainLadder"), libpath = "~/tmp/R-lib/")

## revdep_check_reset()
## revdep_check()
revdep_check_save_summary()
revdep_check_print_problems()
