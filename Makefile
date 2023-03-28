.DEFAULT_GOAL := help

.PHONY: gen-latest-notes # Generate HTML file w pages sorted by last updated
gen-latest-notes:
	pushd scripts/ && ./latest_pages.sh > ../static/latest/index.html && popd

.PHONY: help # Generate list of targets with descriptions
# source: https://github.com/jeffsp/makefile_help/blob/master/Makefile
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1;;;\2/' | column -t -s ";;;"
