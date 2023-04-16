.PHONY: export # Export org-md and org-html files
export: export-org

.PHONY: export-org
export-org:
	@echo "export-org starting"
	@emacsclient -e '(cf/hugo-export-all "$(HOME)/notes/org/roam")'
	@echo "export-org finished"

.PHONY: gen-latest-notes # Generate HTML file w pages sorted by last updated
gen-latest-notes:
	pushd scripts/ && ./latest_pages.sh > ../static/latest/index.html && popd

include $(HOME)/infra/workshop/common/Makefile.common
