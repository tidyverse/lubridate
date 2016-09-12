library("devtools")

## pkg <- "~/dev/lubridate"
revdep_check_reset()
revdep_check(libpath = "~/tmp/R-lib/", threads = 6)

revdep_check_save_summary()
revdep_check_print_problems()

build("..")
build_win("..")
