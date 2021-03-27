AWS_ACCESS_KEY_ID ?=
AWS_REGION ?=
AWS_SECRET_ACCESS_KEY ?=
CONTAINER_NAME ?= weather-react
DOCKER ?= docker-compose run --rm -T
FOLDER ?= 
REPO_URL ?=
WORKSPACE ?=
TAG ?= $(shell git rev-parse --short HEAD)
TF ?= docker-compose run --rm -T terraform sh -c
TF_BACKEND_BUCKET ?= $(shell $(TF) 'cd backend; terraform output -raw bucket')
TF_BACKEND_TABLE ?= $(shell $(TF) 'cd backend; terraform output -raw dynamodb_table')

test123:
	echo $(TF_BACKEND_BUCKET)

build:
	@echo "🏷️📦🏗️Building and tagging container..."
	cd docker && docker build --tag ${REPO_URL}:${TAG} .
.PHONY: build

init: .env
	$(TF) 'cd $(FOLDER); terraform init'
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