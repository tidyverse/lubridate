
#' devtools::install_github("r-lib/revdepcheck")

library(revdepcheck)

# revdepcheck::revdep_reset()

## Don't flood my OS partition
Sys.setenv(TMPDIR = "~/vs_revdep_cache")
dir.create(Sys.getenv("TMPDIR"), showWarnings = F)

revdepcheck::revdep_check(num_workers = 6)

revdepcheck::revdep_summary()
revdepcheck::revdep_todo()

revdepcheck::revdep_add_broken(install_failures = T, timeout_failures = T)
revdepcheck::revdep_check(num_workers = 6)

revdepcheck::revdep_rm(packages = c("CDMConnector"))
## revdep_add(packages = "GenEst")


(smr <- revdep_summary())
revdep_details(revdep = "GenEst")

## in another process
revdepcheck::revdep_report_summary()
revdepcheck::revdep_report_problems()
revdepcheck::revdep_summary()
revdepcheck::revdep_maintainers()

## finally
revdepcheck::revdep_report()


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
