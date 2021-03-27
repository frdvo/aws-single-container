AWS_ACCESS_KEY_ID ?=
AWS_REGION ?=
AWS_SECRET_ACCESS_KEY ?=
CONTAINER_NAME ?= weather-react
DOCKER ?= docker-compose run --rm -T
FOLDER ?= 
REPO_URL ?= $(shell $(TF) 'cd ecr; terraform output -raw repo_url')
WORKSPACE ?= default
TAG ?= $(shell git rev-parse --short HEAD)
TF ?= docker-compose run --rm -T terraform sh -c
TF_BACKEND_BUCKET ?= $(shell $(TF) 'cd backend; terraform output -raw bucket')
TF_BACKEND_TABLE ?= $(shell $(TF) 'cd backend; terraform output -raw dynamodb_table')

backend:
	echo "Ensuring backend is configured"
	$(TF) 'cd backend; terraform init; terraform apply'
.PHONY: backend

build:
	@echo "🏷️📦🏗️Building and tagging container..."
	cd docker && docker build --tag ${REPO_URL}:${TAG} .
.PHONY: build

init: .env
	$(TF) 'cd $(FOLDER); terraform init -backend-config="dynamodb_table=$(TF_BACKEND_TABLE)" -backend-config="bucket=$(TF_BACKEND_BUCKET)"'
.PHONY: init

workspace: .env
	$(DOCKER) envvars ensure --tags terraform
	$(TF) 'cd $(FOLDER); terraform workspace new $(WORKSPACE) || terraform workspace select $(WORKSPACE)' 
.PHONY: workspace

plan: .env init workspace
	$(DOCKER) envvars ensure --tags terraform
	$(TF) 'cd $(FOLDER); terraform plan'
.PHONY: plan

apply: .env init workspace
	$(DOCKER) envvars ensure --tags terraform
	$(TF) 'cd $(FOLDER); terraform apply'
.PHONY: apply

.env:
	@echo "🌏🌍🌏 Creating .env file"
	touch .env
	$(DOCKER) envvars validate
	$(DOCKER) envvars envfile --overwrite
.PHONY: .env