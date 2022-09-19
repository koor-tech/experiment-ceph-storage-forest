.PHONY: all \
# Deploy
				deploy deploy-ansible deploy-k0s deploy-k8s \
# Operations
				kubie

all: deploy

##########
# Deploy #
##########

deploy:
	@echo "deploying ansible..."
	@$(MAKE) -s --no-print-directory -C ansible
	@echo "deploying k0s (initial set up may take a while!)..."
	@$(MAKE) -s --no-print-directory -C k0s

deploy-ansible:
	$(MAKE) -C ansible

deploy-k0s:
	$(MAKE) -C k0s

deploy-k8s:
	$(MAKE) -C k8s

##############
# Operations #
##############

kubie:
	@$(MAKE) -s --no-print-directory -C k0s kubie
