.PHONY = default ping lint requirements deps

# Shell to use for running scripts
SHELL := $(shell which bash)

# Test if the dependencies we need to run this Makefile are installed
ANSIBLE 		:= $(shell command -v ansible-galaxy ansible-playbook)
KUBECTL 		:= $(shell command -v kubectl)
ANSIBLE_LINT	:= $(shell command -v ansible-test)

default: requirements
ifdef env
	@echo -e "🚨 Start Development Environment Setup"
	@ansible-playbook -i $(env) site.yml -K
	@echo -e "✅ Development Environment Setup Completed"
else
	@echo -e "❌ No Environment Found."
	@exit 1
endif

ping: deps
ifdef env
	@ansible all -i $(env) -m ping
else
	@echo -e "❌ No Environment Found."
	@exit 1
endif

lint: deps
	@ansible-lint -p site.yml

requirements: deps
	@echo -e "🎁 Installing ansible collections..."
	@ansible-galaxy collection install -r requirements.yml
	@echo -e "✅ Ansible collections installed"

deps:
ifndef ANSIBLE
	@echo "Ansible is not available."
	@exit 1
endif
ifndef ANSIBLE_LINT
	@echo "ansible-lint is not available. Please install it using 'pip3 install "ansible-lint[yamllint]"'."
	@exit 1
endif
ifndef KUBECTL
	@echo "kubectl is not available."
	@exit 1
endif
