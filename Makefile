SHELL := bash

include $(shell test -f .tardigrade-ci || curl -sSL -o .tardigrade-ci "https
://raw.githubusercontent.com/plus3it/tardigrade-ci/master/bootstrap/Makefile.boo
tstrap"; echo .tardigrade-ci)

cfn/%: FIND_CFN ?= find . $(FIND_EXCLUDES) -name '*.template.cfn.*' -type f
cfn/version: guard/program/yq
cfn/version:
	$(FIND_CFN) | $(XARGS) bash -c "yq -e '.Metadata.Version | test(\"^$(VERSION)$$\")' {} > /dev/null || (echo '[{}]: BAD/MISSING Cfn Version Metadata'; exit 1)"
