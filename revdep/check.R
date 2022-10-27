
devtools::install_github("r-lib/revdepcheck")

library(revdepcheck)

revdep_reset()
revdep_check(num_workers = 6)

revdep_summary()
revdep_todo()

revdep_add_broken(install_failures = F, timeout_failures = T)
revdep_check(num_workers = 6)

## revdep_rm(packages = "xROI")
## revdep_add(packages = "GenEst")
revdep_check()


revdep_summary()
revdep_report()
revdep_report_problems()
revdep_report_summary()

revdep_summary()
revdep_maintainers()




db_delete <- function(pkgdir, package) {
  db <- db(pkgdir)
  dbExecute(db,
    sqlInterpolate(db,
      "DELETE FROM revdeps WHERE package = ?package",
      package = package
    )
  )
}
## revdepcheck:::db_delete(".", "GenEst")
