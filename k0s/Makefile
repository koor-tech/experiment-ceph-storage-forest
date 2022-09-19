.PHONY: all \
				ensure-k0sctl ensure-tool-kubie \
				deploy kubeconfig \
				kubie

K0SCTL ?= k0sctl
KUBIE ?= kubie

KUBECONFIG_PATH ?= $(shell realpath ./storage-forest.kubeconfig.yaml)

CLUSTER ?= storage-forest
PRE_KUBIE_WORKING_DIR ?= $(PWD)

all: deploy kubeconfig

###########
# Options #
###########

###########
# Tooling #
###########

ensure-tool-kubie:
ifeq (,$(shell which $(KUBIE)))
	$(error "kubie binary must be installed (see: https://github.com/sbstp/kubie)");
endif

ensure-k0sctl:
ifeq (,$(shell which $(K0SCTL)))
	$(error "k0sctl binary must be installed (see: https://docs.k0sproject.io/v1.24.4+k0s.0/k0sctl-install/)");
endif

##########
# Deploy #
##########

deploy: ensure-k0sctl
	@$(K0SCTL) \
		apply \
		--disable-telemetry \
		--disable-upgrade-check

##############
# Operations #
##############

kubeconfig:
	@$(K0SCTL) kubeconfig > $(KUBECONFIG_PATH)
	@echo "kubeconfig successfully written to [$(KUBECONFIG_PATH)]"

kubie: ensure-tool-kubie
ifeq (,$(PRE_KUBIE_WORKING_DIR))
	$(KUBIE) ctx -f $(KUBECONFIG_PATH)
else
	cd $(PRE_KUBIE_WORKING_DIR) && $(KUBIE) ctx -f $(KUBECONFIG_PATH)
endif
