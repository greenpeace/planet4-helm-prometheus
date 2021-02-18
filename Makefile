SHELL := /bin/bash

RELEASE := prometheus-stack
NAMESPACE := kube-system

CHART_NAME := prometheus-community/kube-prometheus-stack
CHART_VERSION ?= 10.3.2

DEV_CLUSTER ?= p4-development
DEV_PROJECT ?= planet-4-151612
DEV_ZONE ?= us-central1-a

PROD_CLUSTER ?= planet4-production
PROD_PROJECT ?= planet4-production
PROD_ZONE ?= us-central1-a

.DEFAULT_TARGET: status

lint: lint-yaml lint-ci

lint-yaml:
		@find . -type f -name '*.yml' | xargs yamllint
		@find . -type f -name '*.yaml' | xargs yamllint

lint-ci:
		@circleci config validate

# Helm Initialisation
init:
	helm3 repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm3 repo update

# Helm Deploy to Development - PW is a CircleCI env var
dev: lint init config-secrets-dev 
ifndef CI
	$(error Please commit and push, this is intended to be run in a CI environment)
endif
	gcloud config set project $(DEV_PROJECT)
	gcloud container clusters get-credentials $(DEV_CLUSTER) --zone $(DEV_ZONE) --project $(DEV_PROJECT)
	-kubectl create namespace $(NAMESPACE)
	./create_crds.sh
	helm3 upgrade --install --wait $(RELEASE) \
		--namespace=$(NAMESPACE) \
		--version $(CHART_VERSION) \
		--set grafana.adminPassword=$(DEV_GRAFANA_PW) \
		-f values.yaml \
		--values env/dev/values.yaml \
		$(CHART_NAME)
	$(MAKE) history

# Helm Deploy to Production - PW is a CircleCI env var
prod: lint init config-secrets-prod 
ifndef CI
	$(error Please commit and push, this is intended to be run in a CI environment)
endif
	gcloud config set project $(DEV_PROJECT)
	gcloud container clusters get-credentials $(DEV_CLUSTER) --zone $(DEV_ZONE) --project $(DEV_PROJECT)
	-kubectl create namespace $(NAMESPACE)
	./create_crds.sh
	helm3 upgrade --install --wait $(RELEASE) \
		--namespace=$(NAMESPACE) \
		--version $(CHART_VERSION) \
		--set grafana.adminPassword=$(PROD_GRAFANA_PW) \
		-f values.yaml \
		--values env/prod/values.yaml \
		$(CHART_NAME)
	$(MAKE) history

# Helm status
status:
	helm3 status $(RELEASE) -n $(NAMESPACE)

# Display user values followed by all values
values:
	helm3 get values $(RELEASE) -n $(NAMESPACE)
	helm3 get values $(RELEASE) -n $(NAMESPACE) -a

# Display helm history
history:
	helm3 history $(RELEASE) -n $(NAMESPACE) --max=5

# Expose the port for the service
port:
	@echo "Visit http://127.0.0.1:9090 to access Prometheus"
	kubectl port-forward --namespace $(NAMESPACE) svc/prometheus-stack-kube-prom-prometheus 9090:9090

# Delete a release when you intend reinstalling it to keep history
uninstall:
	helm3 uninstall $(RELEASE) -n $(NAMESPACE) --keep-history

# Completely remove helm install, config data, persistent volumes etc.
# Before running this ensure you have deleted any other related config
destroy:
	@echo -n "You are about to ** DELETE DATA **, enter y if your sure ? [y/N] " && read ans && [ $${ans:-N} = y ]
	helm3 uninstall $(RELEASE) -n $(NAMESPACE)
	kubectl delete pvc -l app=prometheus -n $(NAMESPACE)
	kubectl delete pvc -l app.kubernetes.io/instance=$(RELEASE) -n $(NAMESPACE)
	./delete_crds.sh

config-secrets-dev:
	@echo DEV: Appending Thanos Service Account credentials from environment to objstore.yaml
	perl -p -i template.pl < ./env/dev/secrets.yaml.tpl > secrets.yaml
	kubectl apply -f secrets.yaml

config-secrets-prod:
	@echo PROD: Appending Thanos Service Account credentials from environment to objstore.yaml
	perl -p -i template.pl < ./env/prod/secrets.yaml.tpl > secrets.yaml
	kubectl apply -f secrets.yaml

	
