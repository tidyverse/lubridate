
RSCRIPT ?= Rscript
R = $(RSCRIPT) --slave

.PHONY: all version deploy site test

version:
	@echo "RSCRIPT: $(shell $(RSCRIPT) --version 2>&1)" # Rscript prints to stderr
	@echo "REPO: $(shell $(R) -e 'cat(getOption("repos"))')"
	@echo "LIB: $(shell $(R) -e 'cat(.libPaths()[[1]])')"

R_FILES := $(shell find R/)

NAMESPACE: $(R_FILES)
	$(R) -e 'devtools::document()'

install: version
	$(R) -e 'devtools::document()'
	$(R) -e 'devtools::install()'

MAN_FILES := $(shell find man/)
site: NAMESPACE _pkgdown.yml NEWS.md README.md $(MAN_FILES)
	$(R) \
	 -e 'pkgdown::clean_site()' \
	 -e 'pkgdown::build_site(preview = TRUE)'

test: version
