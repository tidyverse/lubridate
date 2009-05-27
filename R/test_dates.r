# Making exhaustive list of ways to write August 6, 2003
# To do: mixed separators: Nov. 16, 2008


# Functions needed
# ____________________________________________________________

library(plyr)

# Permutation function (borrowed from my version of guess_format())
# Returns all permutations of elements in a vector
permute <- function(...){
	data <- unlist(list(...))

	# Creates grid of all unique combinations of data elements with 
	# length = length(data). 	
	perms <- splat(expand.grid)(rep(list(seq_along(data)), length(data)))
	
	# Retains only combinations that sample each element once
	perms <- perms[apply(perms, 1, function(x) nlevels(as.factor(x))) == length(data), ]
	
	# Replaces each element with its value from data
	perm_strings <- sapply(perms, function(x) data[x])
	perm_strings
}




# Splits each row in a matric into n rows, and adds to each a unique element from a 
# vector of length n
combine <- function(mat, vec, name){
	combined <- mat[rep(1:nrow(mat), each = length(vec)),]
	combined <- cbind(unname(combined), sep = rep(vec, nrow(mat)))
	combined
}



# Making a list of test dates
# ______________________________________________________________
  
months <- as.matrix(c("8", "08", "August", "AUGUST", "august", "aug", "AUG", "Aug", "Aug."))
days <- c("6", "06", "6th", "6TH")
years <- c("2003", "03")
seps <- c("-", "/", ".", "", " ")
  
# All the uniques combinations of month, day, year
dmy <- unname(combine(combine(months,years), days))
  
# All the permutations of each combination
perms <- unname(splat(rbind)(mlply(dmy,permute)))

# Adding seps column  
with_seps <- combine(perms, seps)	

standard <- unlist(mlply(with_seps, paste))
  
  
# Adding Roman numerals  
# ____________________________________________________________

lower <- c("iii", "vi", "mmiii")
upper <- c("III", "VI", "MMIII")
  
romans <- rbind(permute(lower), permute(upper))
with_seps <- combine(romans, seps)

roman <- unlist(mlply(with_seps, paste))


# Adding mixed separators (month space day)
# _________________________________________________________________

mdsep <- c(" ")
ysep <- c("-", "/", ".", "")

md <- combine(combine(months,days), mdsep)
mds <- unlist(mlply(md, paste))

ymds <- combine(as.matrix(mds), years)
perm_ymds <- unname(splat(rbind)(mlply(ymds,permute)))
with_seps <- combine(perm_ymds, ysep)

mixed <- unlist(mlply(with_seps, paste))



# Adding miscellaneous dates
# _____________________________________________________________

misc <- c("the 6th day of August in the year of our Lord 2003",
"the 6th of August 2003",
"August, 6 2003 BC",
"August, 6 2003 BCE",
"August, 6 2003 AC",
"August, 6 2003 CE",
"August, 6 2003 AD",
"1060146000") # the POSIXct number for Aug 6, 2003



test_dates <- unname(c(standard, roman, mixed, misc))
save(test_dates, file = "test_dates.Rdata")
