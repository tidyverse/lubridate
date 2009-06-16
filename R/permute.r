# Permutation function (borrowed from my version of guess_format())
# Garrett Grolemund 2009 

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
combine <- function(mat, vec){
	combined <- mat[rep(1:nrow(mat), each = length(vec)),]
	combined <- cbind(unname(combined), sep = rep(vec, nrow(mat)))
	combined
}