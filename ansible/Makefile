.PHONY: all deploy

ANSIBLE_PLAYBOOK ?= ansible-playbook

PLAYBOOK_PATH ?= storage-forest.yml
INVENTORY_PATH ?= inventory.yml

# ANSIBLE_LIMIT=<machines> will translate to --limit=<machines>
# ex. ANSIBLE_LIMIT=workers[1] and ANSIBLE_LIMIT=workers
ANSIBLE_LIMIT_ARG ?=
ifneq ("","$(ANSIBLE_LIMIT)")
	ANSIBLE_LIMIT_ARG = "--limit=$(ANSIBLE_LIMIT)"
endif

# ANSIBLE_TAGS=<tags> will translate to --tags=<tags>
# ex. ANSIBLE_TAGS=one,two
ANSIBLE_TAGS_ARG ?=
ifneq ("","$(ANSIBLE_TAGS)")
	ANSIBLE_TAGS_ARG = "--tags=$(ANSIBLE_TAGS)"
endif

all: deploy

###########
# Tooling #
###########

ensure-ansible-playbook:
ifeq (,$(shell which $(ANSIBLE_PLAYBOOK)))
	$(error "ansible-playbook binary must be installed");
endif

##########
# Deploy #
##########

deploy: ensure-ansible-playbook
	@$(ANSIBLE_PLAYBOOK) \
		$(ANSIBLE_LIMIT_ARG) \
		$(ANSIBLE_TAGS_ARG) \
		--inventory=$(INVENTORY_PATH) \
		$(PLAYBOOK_PATH)
