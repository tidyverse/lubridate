# The first thing we do is load the plyr package so we can use the function 
#   lapply.
# warn.conflicts = FALSE tells R not to notify us if plyr loads an object that has a 
#   name that is already in use.
library(plyr, warn.conflicts = FALSE)

# sys.function() returns the definition of the most recent function in the call 
#   stack.
# body() returns the body of this function.
# attr( , "srcfile") returns the source file for this function.
FILE <- (function() {
  attr(body(sys.function()), "srcfile")
})()$filename

# we make PATH which is the directory of FILE
PATH <- dirname(FILE)


# file.path constructs the file path to R on the computer we are using.
# dir( , full.name = T) produces a character vector of all the file names in our 
#   R directory. Each filename has the directory path appended to it.
# lapply( , source) tells R to load (i.e. source) each of these files.
paths <- dir(file.path(PATH, "R"), pattern = "\\.r$", full.name=T)
lapply(paths, source)
