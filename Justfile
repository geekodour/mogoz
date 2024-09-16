list:
	just --list

# Export org-md and org-html files
export: export-org

export-org:
	#!/usr/bin/env bash
	echo "export-org starting"
	emacsclient -e "(cf/hugo-export-all \"${HOME}/notes/org/roam\")"
	echo "export-org finished"

# Generate HTML file w pages sorted by last updated
gen-latest-notes:
	pushd scripts/ && ./latest_pages.sh > ../static/latest/index.html && popd
