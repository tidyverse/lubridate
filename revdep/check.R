
devtools::install_github("r-lib/revdepcheck")

library(revdepcheck)

revdep_reset()
revdep_check(num_workers = 4)

revdep_summary()
revdep_todo()

revdep_add_broken(install_failures = F, timeout_failures = T)
revdep_check(num_workers = 4)

## revdep_rm(packages = "xROI")
## revdep_add(packages = "GenEst")
revdep_check()

(smr <- revdep_summary())
revdep_details(revdep = "GenEst")

## in another process
revdep_report_summary()
revdep_report_problems()
revdep_summary()
revdep_maintainers()

## finally
revdep_report()


db_delete <- function(pkgdir, package) {
  db <- revdepcheck:::db(pkgdir)
  DBI:::dbExecute(db,
    DBI::sqlInterpolate(db,
      "DELETE FROM revdeps WHERE package = ?package",
      package = package
    )
  )
}

db_delete(".", "GenEst")
