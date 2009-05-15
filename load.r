# lapply is a function that exists in the package plyr. 
# We first load plyr so we can later use lapply
library(plyr, warn.conflicts = FALSE)

FILE <- (function() {
  attr(body(sys.function()), "srcfile")
})()$filename
PATH <- dirname(FILE)

lapply(dir(file.path(PATH, "R"), full.name=T), source)
