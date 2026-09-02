SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

.PHONY: help
help: ## Show this help
> @grep -E -h '\s##\s' $(MAKEFILE_LIST) | \
> sort | \
> awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))

__check_defined = \
    $(if $(value $1),, \
      $(shell echo -e "\033[0;31m[ERROR]\033[0m Missing parameter: \033[0;33m$1\033[0m" >&2) \
      $(shell echo -e "        $2" >&2) \
      $(error ))
